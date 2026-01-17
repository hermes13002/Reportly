import 'dart:convert';
import 'package:http/http.dart' as http;

/// groq ai service for text summarization
class GroqService {
  final String apiKey;
  final http.Client _client;

  static const _baseUrl = 'https://api.groq.com/openai/v1';
  static const _defaultModel = 'llama-3.3-70b-versatile';

  GroqService({required this.apiKey, http.Client? client})
    : _client = client ?? http.Client();

  /// summarize commit list into business-friendly text
  Future<String> summarizeCommits({
    required List<String> commits,
    required String tone,
    String? companyContext,
  }) async {
    final commitList = commits.map((c) => '- $c').join('\n');

    final prompt = _buildSummarizationPrompt(
      commits: commitList,
      tone: tone,
      context: companyContext,
    );

    return await _complete(prompt);
  }

  /// generate report content from grouped commits
  Future<String> generateReportContent({
    required Map<String, List<String>> groupedCommits,
    required String tone,
    String? companyContext,
  }) async {
    final sections = <String>[];

    groupedCommits.forEach((type, commits) {
      sections.add('## ${_formatTypeHeader(type)}');
      for (final commit in commits) {
        sections.add('- $commit');
      }
    });

    final prompt =
        '''
You are a technical writer creating a professional work report.
Convert the following commit summaries into a polished report section.
Use a $tone tone. Be concise but comprehensive.
${companyContext != null ? 'Company context: $companyContext' : ''}

Commit groups:
${sections.join('\n')}

Write a summary paragraph for each section, keeping technical details but making it readable for stakeholders.
Do not include any headers, just output the summarized content.
''';

    return await _complete(prompt);
  }

  /// complete a prompt using groq api
  Future<String> _complete(String prompt) async {
    final uri = Uri.parse('$_baseUrl/chat/completions');

    final response = await _client.post(
      uri,
      headers: _headers,
      body: jsonEncode({
        'model': _defaultModel,
        'messages': [
          {'role': 'user', 'content': prompt},
        ],
        'temperature': 0.3,
        'max_tokens': 2048,
      }),
    );

    if (response.statusCode != 200) {
      throw GroqException(
        'Failed to complete prompt: ${response.statusCode}',
        statusCode: response.statusCode,
        body: response.body,
      );
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final choices = data['choices'] as List<dynamic>;

    if (choices.isEmpty) {
      throw GroqException('No completion returned');
    }

    final message = choices.first['message'] as Map<String, dynamic>;
    return message['content'] as String;
  }

  String _buildSummarizationPrompt({
    required String commits,
    required String tone,
    String? context,
  }) {
    return '''
You are a technical writer. Summarize the following git commits into a professional work report.
Tone: $tone
${context != null ? 'Context: $context' : ''}

Rules:
- Group similar work together
- Use clear, business-friendly language
- Keep technical accuracy but avoid jargon
- Be concise

Commits:
$commits

Provide a brief summary (2-4 sentences max).
''';
  }

  String _formatTypeHeader(String type) {
    switch (type.toLowerCase()) {
      case 'feat':
        return 'Features';
      case 'fix':
        return 'Bug Fixes';
      case 'refactor':
        return 'Code Improvements';
      case 'docs':
        return 'Documentation';
      case 'test':
        return 'Testing';
      case 'chore':
        return 'Maintenance';
      default:
        return 'Other Changes';
    }
  }

  Map<String, String> get _headers => {
    'Authorization': 'Bearer $apiKey',
    'Content-Type': 'application/json',
  };

  void dispose() {
    _client.close();
  }
}

/// groq api exception
class GroqException implements Exception {
  final String message;
  final int? statusCode;
  final String? body;

  GroqException(this.message, {this.statusCode, this.body});

  @override
  String toString() => 'GroqException: $message (status: $statusCode)';
}
