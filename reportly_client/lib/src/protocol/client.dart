/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i1;
import 'package:serverpod_client/serverpod_client.dart' as _i2;
import 'dart:async' as _i3;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i4;
import 'package:reportly_client/src/protocol/company.dart' as _i5;
import 'package:reportly_client/src/protocol/delivery_channel.dart' as _i6;
import 'package:reportly_client/src/protocol/report.dart' as _i7;
import 'package:reportly_client/src/protocol/report_template.dart' as _i8;
import 'package:reportly_client/src/protocol/repository.dart' as _i9;
import 'package:reportly_client/src/protocol/schedule_config.dart' as _i10;
import 'package:reportly_client/src/protocol/greetings/greeting.dart' as _i11;
import 'protocol.dart' as _i12;

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
/// {@category Endpoint}
class EndpointEmailIdp extends _i1.EndpointEmailIdpBase {
  EndpointEmailIdp(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'emailIdp';

  /// Logs in the user and returns a new session.
  ///
  /// Throws an [EmailAccountLoginException] in case of errors, with reason:
  /// - [EmailAccountLoginExceptionReason.invalidCredentials] if the email or
  ///   password is incorrect.
  /// - [EmailAccountLoginExceptionReason.tooManyAttempts] if there have been
  ///   too many failed login attempts.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _i3.Future<_i4.AuthSuccess> login({
    required String email,
    required String password,
  }) => caller.callServerEndpoint<_i4.AuthSuccess>(
    'emailIdp',
    'login',
    {
      'email': email,
      'password': password,
    },
  );

  /// Starts the registration for a new user account with an email-based login
  /// associated to it.
  ///
  /// Upon successful completion of this method, an email will have been
  /// sent to [email] with a verification link, which the user must open to
  /// complete the registration.
  ///
  /// Always returns a account request ID, which can be used to complete the
  /// registration. If the email is already registered, the returned ID will not
  /// be valid.
  @override
  _i3.Future<_i2.UuidValue> startRegistration({required String email}) =>
      caller.callServerEndpoint<_i2.UuidValue>(
        'emailIdp',
        'startRegistration',
        {'email': email},
      );

  /// Verifies an account request code and returns a token
  /// that can be used to complete the account creation.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if no request exists
  ///   for the given [accountRequestId] or [verificationCode] is invalid.
  @override
  _i3.Future<String> verifyRegistrationCode({
    required _i2.UuidValue accountRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyRegistrationCode',
    {
      'accountRequestId': accountRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a new account registration, creating a new auth user with a
  /// profile and attaching the given email account to it.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if the [registrationToken]
  ///   is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  ///
  /// Returns a session for the newly created user.
  @override
  _i3.Future<_i4.AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  }) => caller.callServerEndpoint<_i4.AuthSuccess>(
    'emailIdp',
    'finishRegistration',
    {
      'registrationToken': registrationToken,
      'password': password,
    },
  );

  /// Requests a password reset for [email].
  ///
  /// If the email address is registered, an email with reset instructions will
  /// be send out. If the email is unknown, this method will have no effect.
  ///
  /// Always returns a password reset request ID, which can be used to complete
  /// the reset. If the email is not registered, the returned ID will not be
  /// valid.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to request a password reset.
  ///
  @override
  _i3.Future<_i2.UuidValue> startPasswordReset({required String email}) =>
      caller.callServerEndpoint<_i2.UuidValue>(
        'emailIdp',
        'startPasswordReset',
        {'email': email},
      );

  /// Verifies a password reset code and returns a finishPasswordResetToken
  /// that can be used to finish the password reset.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to verify the password reset.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// If multiple steps are required to complete the password reset, this endpoint
  /// should be overridden to return credentials for the next step instead
  /// of the credentials for setting the password.
  @override
  _i3.Future<String> verifyPasswordResetCode({
    required _i2.UuidValue passwordResetRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyPasswordResetCode',
    {
      'passwordResetRequestId': passwordResetRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a password reset request by setting a new password.
  ///
  /// The [verificationCode] returned from [verifyPasswordResetCode] is used to
  /// validate the password reset request.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.policyViolation] if the new
  ///   password does not comply with the password policy.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _i3.Future<void> finishPasswordReset({
    required String finishPasswordResetToken,
    required String newPassword,
  }) => caller.callServerEndpoint<void>(
    'emailIdp',
    'finishPasswordReset',
    {
      'finishPasswordResetToken': finishPasswordResetToken,
      'newPassword': newPassword,
    },
  );
}

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
/// {@category Endpoint}
class EndpointJwtRefresh extends _i4.EndpointRefreshJwtTokens {
  EndpointJwtRefresh(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jwtRefresh';

  /// Creates a new token pair for the given [refreshToken].
  ///
  /// Can throw the following exceptions:
  /// -[RefreshTokenMalformedException]: refresh token is malformed and could
  ///   not be parsed. Not expected to happen for tokens issued by the server.
  /// -[RefreshTokenNotFoundException]: refresh token is unknown to the server.
  ///   Either the token was deleted or generated by a different server.
  /// -[RefreshTokenExpiredException]: refresh token has expired. Will happen
  ///   only if it has not been used within configured `refreshTokenLifetime`.
  /// -[RefreshTokenInvalidSecretException]: refresh token is incorrect, meaning
  ///   it does not refer to the current secret refresh token. This indicates
  ///   either a malfunctioning client or a malicious attempt by someone who has
  ///   obtained the refresh token. In this case the underlying refresh token
  ///   will be deleted, and access to it will expire fully when the last access
  ///   token is elapsed.
  ///
  /// This endpoint is unauthenticated, meaning the client won't include any
  /// authentication information with the call.
  @override
  _i3.Future<_i4.AuthSuccess> refreshAccessToken({
    required String refreshToken,
  }) => caller.callServerEndpoint<_i4.AuthSuccess>(
    'jwtRefresh',
    'refreshAccessToken',
    {'refreshToken': refreshToken},
    authenticated: false,
  );
}

/// endpoint for company crud operations
/// {@category Endpoint}
class EndpointCompany extends _i2.EndpointRef {
  EndpointCompany(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'company';

  /// create a new company
  _i3.Future<_i5.Company> create(_i5.Company company) =>
      caller.callServerEndpoint<_i5.Company>(
        'company',
        'create',
        {'company': company},
      );

  /// get all companies
  _i3.Future<List<_i5.Company>> list() =>
      caller.callServerEndpoint<List<_i5.Company>>(
        'company',
        'list',
        {},
      );

  /// get company by id
  _i3.Future<_i5.Company?> getById(int id) =>
      caller.callServerEndpoint<_i5.Company?>(
        'company',
        'getById',
        {'id': id},
      );

  /// update company
  _i3.Future<_i5.Company> update(_i5.Company company) =>
      caller.callServerEndpoint<_i5.Company>(
        'company',
        'update',
        {'company': company},
      );

  /// delete company by id
  _i3.Future<bool> delete(int id) => caller.callServerEndpoint<bool>(
    'company',
    'delete',
    {'id': id},
  );
}

/// endpoint for delivery channel crud operations
/// {@category Endpoint}
class EndpointDeliveryChannel extends _i2.EndpointRef {
  EndpointDeliveryChannel(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'deliveryChannel';

  /// create a new delivery channel
  _i3.Future<_i6.DeliveryChannel> create(_i6.DeliveryChannel channel) =>
      caller.callServerEndpoint<_i6.DeliveryChannel>(
        'deliveryChannel',
        'create',
        {'channel': channel},
      );

  /// get delivery channels by company id
  _i3.Future<List<_i6.DeliveryChannel>> listByCompany(int companyId) =>
      caller.callServerEndpoint<List<_i6.DeliveryChannel>>(
        'deliveryChannel',
        'listByCompany',
        {'companyId': companyId},
      );

  /// get active delivery channels by company id
  _i3.Future<List<_i6.DeliveryChannel>> listActiveByCompany(int companyId) =>
      caller.callServerEndpoint<List<_i6.DeliveryChannel>>(
        'deliveryChannel',
        'listActiveByCompany',
        {'companyId': companyId},
      );

  /// get default channel for company
  _i3.Future<_i6.DeliveryChannel?> getDefault(int companyId) =>
      caller.callServerEndpoint<_i6.DeliveryChannel?>(
        'deliveryChannel',
        'getDefault',
        {'companyId': companyId},
      );

  /// get channel by id
  _i3.Future<_i6.DeliveryChannel?> getById(int id) =>
      caller.callServerEndpoint<_i6.DeliveryChannel?>(
        'deliveryChannel',
        'getById',
        {'id': id},
      );

  /// update delivery channel
  _i3.Future<_i6.DeliveryChannel> update(_i6.DeliveryChannel channel) =>
      caller.callServerEndpoint<_i6.DeliveryChannel>(
        'deliveryChannel',
        'update',
        {'channel': channel},
      );

  /// set as default channel for company
  _i3.Future<_i6.DeliveryChannel> setDefault(int id) =>
      caller.callServerEndpoint<_i6.DeliveryChannel>(
        'deliveryChannel',
        'setDefault',
        {'id': id},
      );

  /// toggle channel active status
  _i3.Future<_i6.DeliveryChannel> toggleActive(int id) =>
      caller.callServerEndpoint<_i6.DeliveryChannel>(
        'deliveryChannel',
        'toggleActive',
        {'id': id},
      );

  /// delete channel by id
  _i3.Future<bool> delete(int id) => caller.callServerEndpoint<bool>(
    'deliveryChannel',
    'delete',
    {'id': id},
  );
}

/// endpoint for report crud operations
/// {@category Endpoint}
class EndpointReport extends _i2.EndpointRef {
  EndpointReport(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'report';

  /// create a new report (draft status)
  _i3.Future<_i7.Report> create(_i7.Report report) =>
      caller.callServerEndpoint<_i7.Report>(
        'report',
        'create',
        {'report': report},
      );

  /// get reports by company id
  _i3.Future<List<_i7.Report>> listByCompany(
    int companyId, {
    String? status,
    required int limit,
    required int offset,
  }) => caller.callServerEndpoint<List<_i7.Report>>(
    'report',
    'listByCompany',
    {
      'companyId': companyId,
      'status': status,
      'limit': limit,
      'offset': offset,
    },
  );

  /// get report by id
  _i3.Future<_i7.Report?> getById(int id) =>
      caller.callServerEndpoint<_i7.Report?>(
        'report',
        'getById',
        {'id': id},
      );

  /// update report content (only drafts)
  _i3.Future<_i7.Report> update(_i7.Report report) =>
      caller.callServerEndpoint<_i7.Report>(
        'report',
        'update',
        {'report': report},
      );

  /// mark report as sent
  _i3.Future<_i7.Report> markSent(
    int id,
    String deliveryChannel,
  ) => caller.callServerEndpoint<_i7.Report>(
    'report',
    'markSent',
    {
      'id': id,
      'deliveryChannel': deliveryChannel,
    },
  );

  /// archive a report
  _i3.Future<_i7.Report> archive(int id) =>
      caller.callServerEndpoint<_i7.Report>(
        'report',
        'archive',
        {'id': id},
      );

  /// delete report by id (only drafts)
  _i3.Future<bool> delete(int id) => caller.callServerEndpoint<bool>(
    'report',
    'delete',
    {'id': id},
  );
}

/// endpoint for report generation and delivery
/// {@category Endpoint}
class EndpointReportGeneration extends _i2.EndpointRef {
  EndpointReportGeneration(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'reportGeneration';

  /// generate a new report for a company
  _i3.Future<_i7.Report> generate({
    required int companyId,
    required DateTime startDate,
    required DateTime endDate,
    int? templateId,
  }) => caller.callServerEndpoint<_i7.Report>(
    'reportGeneration',
    'generate',
    {
      'companyId': companyId,
      'startDate': startDate,
      'endDate': endDate,
      'templateId': templateId,
    },
  );

  /// regenerate an existing report
  _i3.Future<_i7.Report> regenerate(int reportId) =>
      caller.callServerEndpoint<_i7.Report>(
        'reportGeneration',
        'regenerate',
        {'reportId': reportId},
      );

  /// send report via default delivery channel
  _i3.Future<_i7.Report> send(int reportId) =>
      caller.callServerEndpoint<_i7.Report>(
        'reportGeneration',
        'send',
        {'reportId': reportId},
      );

  /// send report via specific channel
  _i3.Future<_i7.Report> sendViaChannel(
    int reportId,
    int channelId,
  ) => caller.callServerEndpoint<_i7.Report>(
    'reportGeneration',
    'sendViaChannel',
    {
      'reportId': reportId,
      'channelId': channelId,
    },
  );
}

/// endpoint for report template crud operations
/// {@category Endpoint}
class EndpointReportTemplate extends _i2.EndpointRef {
  EndpointReportTemplate(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'reportTemplate';

  /// create a new template
  _i3.Future<_i8.ReportTemplate> create(_i8.ReportTemplate template) =>
      caller.callServerEndpoint<_i8.ReportTemplate>(
        'reportTemplate',
        'create',
        {'template': template},
      );

  /// get templates by company id
  _i3.Future<List<_i8.ReportTemplate>> listByCompany(int companyId) =>
      caller.callServerEndpoint<List<_i8.ReportTemplate>>(
        'reportTemplate',
        'listByCompany',
        {'companyId': companyId},
      );

  /// get default template for company
  _i3.Future<_i8.ReportTemplate?> getDefault(int companyId) =>
      caller.callServerEndpoint<_i8.ReportTemplate?>(
        'reportTemplate',
        'getDefault',
        {'companyId': companyId},
      );

  /// get template by id
  _i3.Future<_i8.ReportTemplate?> getById(int id) =>
      caller.callServerEndpoint<_i8.ReportTemplate?>(
        'reportTemplate',
        'getById',
        {'id': id},
      );

  /// update template (increments version)
  _i3.Future<_i8.ReportTemplate> update(_i8.ReportTemplate template) =>
      caller.callServerEndpoint<_i8.ReportTemplate>(
        'reportTemplate',
        'update',
        {'template': template},
      );

  /// set as default template for company
  _i3.Future<_i8.ReportTemplate> setDefault(int id) =>
      caller.callServerEndpoint<_i8.ReportTemplate>(
        'reportTemplate',
        'setDefault',
        {'id': id},
      );

  /// delete template by id
  _i3.Future<bool> delete(int id) => caller.callServerEndpoint<bool>(
    'reportTemplate',
    'delete',
    {'id': id},
  );
}

/// endpoint for repository crud operations
/// {@category Endpoint}
class EndpointRepository extends _i2.EndpointRef {
  EndpointRepository(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'repository';

  /// create a new repository
  _i3.Future<_i9.Repository> create(_i9.Repository repository) =>
      caller.callServerEndpoint<_i9.Repository>(
        'repository',
        'create',
        {'repository': repository},
      );

  /// get repositories by company id
  _i3.Future<List<_i9.Repository>> listByCompany(int companyId) =>
      caller.callServerEndpoint<List<_i9.Repository>>(
        'repository',
        'listByCompany',
        {'companyId': companyId},
      );

  /// get repository by id
  _i3.Future<_i9.Repository?> getById(int id) =>
      caller.callServerEndpoint<_i9.Repository?>(
        'repository',
        'getById',
        {'id': id},
      );

  /// update repository
  _i3.Future<_i9.Repository> update(_i9.Repository repository) =>
      caller.callServerEndpoint<_i9.Repository>(
        'repository',
        'update',
        {'repository': repository},
      );

  /// delete repository by id
  _i3.Future<bool> delete(int id) => caller.callServerEndpoint<bool>(
    'repository',
    'delete',
    {'id': id},
  );

  /// toggle repository active status
  _i3.Future<_i9.Repository> toggleActive(int id) =>
      caller.callServerEndpoint<_i9.Repository>(
        'repository',
        'toggleActive',
        {'id': id},
      );
}

/// endpoint for schedule config operations
/// {@category Endpoint}
class EndpointScheduleConfig extends _i2.EndpointRef {
  EndpointScheduleConfig(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'scheduleConfig';

  /// create or update schedule config for company
  _i3.Future<_i10.ScheduleConfig> upsert(_i10.ScheduleConfig config) =>
      caller.callServerEndpoint<_i10.ScheduleConfig>(
        'scheduleConfig',
        'upsert',
        {'config': config},
      );

  /// get schedule config by company id
  _i3.Future<_i10.ScheduleConfig?> getByCompany(int companyId) =>
      caller.callServerEndpoint<_i10.ScheduleConfig?>(
        'scheduleConfig',
        'getByCompany',
        {'companyId': companyId},
      );

  /// toggle schedule enabled status
  _i3.Future<_i10.ScheduleConfig> toggleEnabled(int companyId) =>
      caller.callServerEndpoint<_i10.ScheduleConfig>(
        'scheduleConfig',
        'toggleEnabled',
        {'companyId': companyId},
      );

  /// update next run time
  _i3.Future<_i10.ScheduleConfig> updateNextRun(
    int companyId,
    DateTime nextRunAt,
  ) => caller.callServerEndpoint<_i10.ScheduleConfig>(
    'scheduleConfig',
    'updateNextRun',
    {
      'companyId': companyId,
      'nextRunAt': nextRunAt,
    },
  );

  /// delete schedule config
  _i3.Future<bool> delete(int companyId) => caller.callServerEndpoint<bool>(
    'scheduleConfig',
    'delete',
    {'companyId': companyId},
  );
}

/// This is an example endpoint that returns a greeting message through
/// its [hello] method.
/// {@category Endpoint}
class EndpointGreeting extends _i2.EndpointRef {
  EndpointGreeting(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'greeting';

  /// Returns a personalized greeting message: "Hello {name}".
  _i3.Future<_i11.Greeting> hello(String name) =>
      caller.callServerEndpoint<_i11.Greeting>(
        'greeting',
        'hello',
        {'name': name},
      );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_idp = _i1.Caller(client);
    serverpod_auth_core = _i4.Caller(client);
  }

  late final _i1.Caller serverpod_auth_idp;

  late final _i4.Caller serverpod_auth_core;
}

class Client extends _i2.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    @Deprecated(
      'Use authKeyProvider instead. This will be removed in future releases.',
    )
    super.authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i2.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_i2.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
         host,
         _i12.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
       ) {
    emailIdp = EndpointEmailIdp(this);
    jwtRefresh = EndpointJwtRefresh(this);
    company = EndpointCompany(this);
    deliveryChannel = EndpointDeliveryChannel(this);
    report = EndpointReport(this);
    reportGeneration = EndpointReportGeneration(this);
    reportTemplate = EndpointReportTemplate(this);
    repository = EndpointRepository(this);
    scheduleConfig = EndpointScheduleConfig(this);
    greeting = EndpointGreeting(this);
    modules = Modules(this);
  }

  late final EndpointEmailIdp emailIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointCompany company;

  late final EndpointDeliveryChannel deliveryChannel;

  late final EndpointReport report;

  late final EndpointReportGeneration reportGeneration;

  late final EndpointReportTemplate reportTemplate;

  late final EndpointRepository repository;

  late final EndpointScheduleConfig scheduleConfig;

  late final EndpointGreeting greeting;

  late final Modules modules;

  @override
  Map<String, _i2.EndpointRef> get endpointRefLookup => {
    'emailIdp': emailIdp,
    'jwtRefresh': jwtRefresh,
    'company': company,
    'deliveryChannel': deliveryChannel,
    'report': report,
    'reportGeneration': reportGeneration,
    'reportTemplate': reportTemplate,
    'repository': repository,
    'scheduleConfig': scheduleConfig,
    'greeting': greeting,
  };

  @override
  Map<String, _i2.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}
