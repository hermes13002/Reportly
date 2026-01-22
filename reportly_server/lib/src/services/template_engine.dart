/// template engine for report generation
class TemplateEngine {
  /// available template variables
  /// available template variables
  static const variables = [
    'company_name',
    'start_date',
    'end_date',
    'features',
    'fixes',
    'improvements',
    'others',
    'chores',
    'tests',
    'documentation',
    'notes',
    'summary',
    'total_commits',
  ];

  /// process template with given values
  String process(String template, Map<String, String> values) {
    var result = template;

    for (final entry in values.entries) {
      result = result.replaceAll('{{${entry.key}}}', entry.value);
    }

    // remove unused variables
    result = result.replaceAll(RegExp(r'\{\{[a-z_]+\}\}'), '');

    return result.trim();
  }

  /// build values map from grouped commits and metadata
  Map<String, String> buildValues({
    required String companyName,
    required DateTime startDate,
    required DateTime endDate,
    required Map<String, List<String>> groupedCommits,
    String? summary,
    String? notes,
  }) {
    return {
      'company_name': companyName,
      'start_date': _formatDate(startDate),
      'end_date': _formatDate(endDate),
      'features': _formatList(groupedCommits['feat'] ?? []),
      'fixes': _formatList(groupedCommits['fix'] ?? []),
      'improvements': _formatList(groupedCommits['refactor'] ?? []),
      'others': _formatList(groupedCommits['other'] ?? []),
      'chores': _formatList(groupedCommits['chore'] ?? []),
      'tests': _formatList(groupedCommits['test'] ?? []),
      'documentation': _formatList(groupedCommits['docs'] ?? []),
      'notes': notes ?? '',
      'summary': summary ?? '',
      'total_commits': groupedCommits.values
          .fold<int>(0, (sum, list) => sum + list.length)
          .toString(),
    };
  }

  /// default report template
  static String get defaultTemplate => '''
# Weekly Report - {{company_name}}

**Period:** {{start_date}} - {{end_date}}

## Summary
{{summary}}

## Features
{{features}}

## Bug Fixes
{{fixes}}

## Improvements
{{improvements}}

## Notes
{{notes}}

---
*Total commits: {{total_commits}}*
''';

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  String _formatList(List<String> items) {
    if (items.isEmpty) return '_None_';
    return items.map((item) => '- $item').join('\n');
  }

  /// validate template has required variables
  List<String> validateTemplate(String template) {
    final missing = <String>[];
    final required = ['company_name', 'start_date', 'end_date'];

    for (final variable in required) {
      if (!template.contains('{{$variable}}')) {
        missing.add(variable);
      }
    }

    return missing;
  }
}
