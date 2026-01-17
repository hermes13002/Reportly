import 'github_service.dart';

/// service for processing and grouping commits
class CommitProcessor {
  /// default commit types for grouping
  static const defaultTypes = [
    'feat',
    'fix',
    'refactor',
    'docs',
    'test',
    'chore',
  ];

  /// process and group commits by type
  Map<String, List<String>> groupByType(
    List<GitHubCommit> commits, {
    List<String>? customTypes,
    List<String>? excludeKeywords,
  }) {
    final types = customTypes ?? defaultTypes;
    final groups = <String, List<String>>{};

    for (final commit in commits) {
      final message = commit.firstLine;

      // skip if contains exclude keywords
      if (excludeKeywords != null &&
          excludeKeywords.any(
            (kw) => message.toLowerCase().contains(kw.toLowerCase()),
          )) {
        continue;
      }

      final type = commit.commitType ?? 'other';
      final normalizedType = types.contains(type) ? type : 'other';

      groups.putIfAbsent(normalizedType, () => []);
      groups[normalizedType]!.add(_normalizeMessage(message));
    }

    return groups;
  }

  /// deduplicate similar commit messages
  List<String> deduplicate(List<String> messages) {
    final seen = <String>{};
    final result = <String>[];

    for (final msg in messages) {
      final normalized = msg.toLowerCase().trim();
      if (!seen.contains(normalized)) {
        seen.add(normalized);
        result.add(msg);
      }
    }

    return result;
  }

  /// normalize commit message (remove type prefix, clean up)
  String _normalizeMessage(String message) {
    // remove conventional commit prefix
    final cleaned = message.replaceFirst(RegExp(r'^\w+(\(.+\))?:\s*'), '');
    // capitalize first letter
    if (cleaned.isEmpty) return message;
    return cleaned[0].toUpperCase() + cleaned.substring(1);
  }

  /// flatten grouped commits to list
  List<String> flatten(Map<String, List<String>> grouped) {
    return grouped.values.expand((list) => list).toList();
  }

  /// get commit count summary
  Map<String, int> getCountSummary(Map<String, List<String>> grouped) {
    return grouped.map((key, value) => MapEntry(key, value.length));
  }
}
