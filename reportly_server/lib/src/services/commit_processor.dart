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
      // Use full message for content
      final message = commit.message;

      // skip if contains exclude keywords (check full message)
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
      // Normalize for comparison (ignore whitespace/case)
      final normalizedInfo = msg.trim().toLowerCase();
      if (!seen.contains(normalizedInfo)) {
        seen.add(normalizedInfo);
        result.add(msg);
      }
    }

    return result;
  }

  /// normalize commit message (remove type prefix from first line, keep body)
  String _normalizeMessage(String message) {
    final lines = message.split('\n');
    if (lines.isEmpty) return message;

    // Process first line to remove conventional commit prefix
    var firstLine = lines.first.trim();
    firstLine = firstLine.replaceFirst(RegExp(r'^\w+(\(.+\))?:\s*'), '');

    // Capitalize first letter of first line
    if (firstLine.isNotEmpty) {
      firstLine = firstLine[0].toUpperCase() + firstLine.substring(1);
    }

    if (lines.length == 1) return firstLine;

    // Reassemble with processed first line and original body
    return [firstLine, ...lines.skip(1)].join('\n');
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
