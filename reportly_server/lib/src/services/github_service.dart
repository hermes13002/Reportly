import 'dart:convert';
import 'package:http/http.dart' as http;

/// github commit data model
class GitHubCommit {
  final String sha;
  final String message;
  final String authorName;
  final String authorEmail;
  final DateTime date;

  GitHubCommit({
    required this.sha,
    required this.message,
    required this.authorName,
    required this.authorEmail,
    required this.date,
  });

  /// extract first line of commit message
  String get firstLine => message.split('\n').first.trim();

  /// extract commit type from conventional commit format
  String? get commitType {
    final match = RegExp(r'^(\w+)(\(.+\))?:').firstMatch(firstLine);
    return match?.group(1)?.toLowerCase();
  }

  factory GitHubCommit.fromJson(Map<String, dynamic> json) {
    final commit = json['commit'] as Map<String, dynamic>;
    final author = commit['author'] as Map<String, dynamic>;

    return GitHubCommit(
      sha: json['sha'] as String,
      message: commit['message'] as String,
      authorName: author['name'] as String,
      authorEmail: author['email'] as String,
      date: DateTime.parse(author['date'] as String),
    );
  }
}

/// github api service for fetching commits
class GitHubService {
  final String token;
  final http.Client _client;

  static const _baseUrl = 'https://api.github.com';

  GitHubService({required this.token, http.Client? client})
    : _client = client ?? http.Client();

  /// fetch commits for a repository within date range
  Future<List<GitHubCommit>> fetchCommits({
    required String owner,
    required String repo,
    required String branch,
    required DateTime since,
    required DateTime until,
    List<String>? excludeAuthors,
  }) async {
    final commits = <GitHubCommit>[];
    var page = 1;
    const perPage = 100;

    while (true) {
      final uri = Uri.parse('$_baseUrl/repos/$owner/$repo/commits').replace(
        queryParameters: {
          'sha': branch,
          'since': since.toUtc().toIso8601String(),
          'until': until.toUtc().toIso8601String(),
          'per_page': perPage.toString(),
          'page': page.toString(),
        },
      );

      final response = await _client.get(uri, headers: _headers);

      if (response.statusCode != 200) {
        throw GitHubException(
          'Failed to fetch commits: ${response.statusCode}',
          statusCode: response.statusCode,
          body: response.body,
        );
      }

      final data = jsonDecode(response.body) as List<dynamic>;
      if (data.isEmpty) break;

      for (final item in data) {
        final commit = GitHubCommit.fromJson(item as Map<String, dynamic>);

        // filter by excluded authors
        if (excludeAuthors != null &&
            excludeAuthors.contains(commit.authorEmail)) {
          continue;
        }

        commits.add(commit);
      }

      if (data.length < perPage) break;
      page++;
    }

    return commits;
  }

  /// validate repository access
  Future<bool> validateRepo({
    required String owner,
    required String repo,
  }) async {
    final uri = Uri.parse('$_baseUrl/repos/$owner/$repo');
    final response = await _client.get(uri, headers: _headers);
    return response.statusCode == 200;
  }

  /// get default branch for repository
  Future<String?> getDefaultBranch({
    required String owner,
    required String repo,
  }) async {
    final uri = Uri.parse('$_baseUrl/repos/$owner/$repo');
    final response = await _client.get(uri, headers: _headers);

    if (response.statusCode != 200) return null;

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    return data['default_branch'] as String?;
  }

  Map<String, String> get _headers => {
    'Authorization': 'token $token',
    'Accept': 'application/vnd.github.v3+json',
  };

  void dispose() {
    _client.close();
  }
}

/// github api exception
class GitHubException implements Exception {
  final String message;
  final int? statusCode;
  final String? body;

  GitHubException(this.message, {this.statusCode, this.body});

  @override
  String toString() => 'GitHubException: $message (status: $statusCode)';
}
