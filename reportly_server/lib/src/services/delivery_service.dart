import 'dart:convert';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:http/http.dart' as http;

/// email delivery service
class EmailDeliveryService {
  final String host;
  final int port;
  final String username;
  final String password;
  final String fromName;
  final String fromEmail;

  late final SmtpServer _smtpServer;

  EmailDeliveryService({
    required this.host,
    required this.port,
    required this.username,
    required this.password,
    required this.fromName,
    required this.fromEmail,
  }) {
    _smtpServer = SmtpServer(
      host,
      port: port,
      username: username,
      password: password,
      ssl: false,
      allowInsecure: true,
    );
  }

  /// send report via email
  Future<bool> sendReport({
    required List<String> recipients,
    required String subject,
    required String content,
    bool isHtml = true,
  }) async {
    final message = Message()
      ..from = Address(fromEmail, fromName)
      ..recipients.addAll(recipients.map((e) => Address(e)))
      ..subject = subject;

    if (isHtml) {
      message.html = content;
    } else {
      message.text = content;
    }

    try {
      await send(message, _smtpServer);
      return true;
    } catch (e) {
      throw DeliveryException('Email send failed: $e');
    }
  }
}

/// clickup delivery service
class ClickUpDeliveryService {
  final String apiToken;
  final http.Client _client;

  static const _baseUrl = 'https://api.clickup.com/api/v2';

  ClickUpDeliveryService({required this.apiToken, http.Client? client})
    : _client = client ?? http.Client();

  /// add comment to a task
  Future<bool> addTaskComment({
    required String taskId,
    required String content,
  }) async {
    final uri = Uri.parse('$_baseUrl/task/$taskId/comment');

    final response = await _client.post(
      uri,
      headers: _headers,
      body: jsonEncode({
        'comment_text': content,
      }),
    );

    if (response.statusCode != 200) {
      throw DeliveryException(
        'ClickUp comment failed: ${response.statusCode}',
      );
    }

    return true;
  }

  /// create a document in a space
  Future<String?> createDoc({
    required String workspaceId,
    required String name,
    required String content,
  }) async {
    final uri = Uri.parse('$_baseUrl/workspaces/$workspaceId/docs');

    final response = await _client.post(
      uri,
      headers: _headers,
      body: jsonEncode({
        'name': name,
        'content': content,
      }),
    );

    if (response.statusCode != 200) {
      throw DeliveryException(
        'ClickUp doc creation failed: ${response.statusCode}',
      );
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    return data['id'] as String?;
  }

  Map<String, String> get _headers => {
    'Authorization': apiToken,
    'Content-Type': 'application/json',
  };

  void dispose() {
    _client.close();
  }
}

/// delivery exception
class DeliveryException implements Exception {
  final String message;

  DeliveryException(this.message);

  @override
  String toString() => 'DeliveryException: $message';
}
