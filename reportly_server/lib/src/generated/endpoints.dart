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
import 'package:serverpod/serverpod.dart' as _i1;
import '../auth/email_idp_endpoint.dart' as _i2;
import '../auth/jwt_refresh_endpoint.dart' as _i3;
import '../endpoints/company_endpoint.dart' as _i4;
import '../endpoints/delivery_channel_endpoint.dart' as _i5;
import '../endpoints/report_endpoint.dart' as _i6;
import '../endpoints/report_generation_endpoint.dart' as _i7;
import '../endpoints/report_template_endpoint.dart' as _i8;
import '../endpoints/repository_endpoint.dart' as _i9;
import '../endpoints/schedule_config_endpoint.dart' as _i10;
import '../greetings/greeting_endpoint.dart' as _i11;
import 'package:reportly_server/src/generated/company.dart' as _i12;
import 'package:reportly_server/src/generated/delivery_channel.dart' as _i13;
import 'package:reportly_server/src/generated/report.dart' as _i14;
import 'package:reportly_server/src/generated/report_template.dart' as _i15;
import 'package:reportly_server/src/generated/repository.dart' as _i16;
import 'package:reportly_server/src/generated/schedule_config.dart' as _i17;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i18;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i19;
import 'package:reportly_server/src/generated/future_calls.dart' as _i20;
export 'future_calls.dart' show ServerpodFutureCallsGetter;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'emailIdp': _i2.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
          null,
        ),
      'jwtRefresh': _i3.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'company': _i4.CompanyEndpoint()
        ..initialize(
          server,
          'company',
          null,
        ),
      'deliveryChannel': _i5.DeliveryChannelEndpoint()
        ..initialize(
          server,
          'deliveryChannel',
          null,
        ),
      'report': _i6.ReportEndpoint()
        ..initialize(
          server,
          'report',
          null,
        ),
      'reportGeneration': _i7.ReportGenerationEndpoint()
        ..initialize(
          server,
          'reportGeneration',
          null,
        ),
      'reportTemplate': _i8.ReportTemplateEndpoint()
        ..initialize(
          server,
          'reportTemplate',
          null,
        ),
      'repository': _i9.RepositoryEndpoint()
        ..initialize(
          server,
          'repository',
          null,
        ),
      'scheduleConfig': _i10.ScheduleConfigEndpoint()
        ..initialize(
          server,
          'scheduleConfig',
          null,
        ),
      'greeting': _i11.GreetingEndpoint()
        ..initialize(
          server,
          'greeting',
          null,
        ),
    };
    connectors['emailIdp'] = _i1.EndpointConnector(
      name: 'emailIdp',
      endpoint: endpoints['emailIdp']!,
      methodConnectors: {
        'login': _i1.MethodConnector(
          name: 'login',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint).login(
                session,
                email: params['email'],
                password: params['password'],
              ),
        ),
        'startRegistration': _i1.MethodConnector(
          name: 'startRegistration',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .startRegistration(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyRegistrationCode': _i1.MethodConnector(
          name: 'verifyRegistrationCode',
          params: {
            'accountRequestId': _i1.ParameterDescription(
              name: 'accountRequestId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _i1.ParameterDescription(
              name: 'verificationCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .verifyRegistrationCode(
                    session,
                    accountRequestId: params['accountRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishRegistration': _i1.MethodConnector(
          name: 'finishRegistration',
          params: {
            'registrationToken': _i1.ParameterDescription(
              name: 'registrationToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .finishRegistration(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                  ),
        ),
        'startPasswordReset': _i1.MethodConnector(
          name: 'startPasswordReset',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .startPasswordReset(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyPasswordResetCode': _i1.MethodConnector(
          name: 'verifyPasswordResetCode',
          params: {
            'passwordResetRequestId': _i1.ParameterDescription(
              name: 'passwordResetRequestId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _i1.ParameterDescription(
              name: 'verificationCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .verifyPasswordResetCode(
                    session,
                    passwordResetRequestId: params['passwordResetRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishPasswordReset': _i1.MethodConnector(
          name: 'finishPasswordReset',
          params: {
            'finishPasswordResetToken': _i1.ParameterDescription(
              name: 'finishPasswordResetToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'newPassword': _i1.ParameterDescription(
              name: 'newPassword',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .finishPasswordReset(
                    session,
                    finishPasswordResetToken:
                        params['finishPasswordResetToken'],
                    newPassword: params['newPassword'],
                  ),
        ),
      },
    );
    connectors['jwtRefresh'] = _i1.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _i1.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _i1.ParameterDescription(
              name: 'refreshToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['jwtRefresh'] as _i3.JwtRefreshEndpoint)
                  .refreshAccessToken(
                    session,
                    refreshToken: params['refreshToken'],
                  ),
        ),
      },
    );
    connectors['company'] = _i1.EndpointConnector(
      name: 'company',
      endpoint: endpoints['company']!,
      methodConnectors: {
        'create': _i1.MethodConnector(
          name: 'create',
          params: {
            'company': _i1.ParameterDescription(
              name: 'company',
              type: _i1.getType<_i12.Company>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['company'] as _i4.CompanyEndpoint).create(
                session,
                params['company'],
              ),
        ),
        'list': _i1.MethodConnector(
          name: 'list',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['company'] as _i4.CompanyEndpoint).list(session),
        ),
        'getById': _i1.MethodConnector(
          name: 'getById',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['company'] as _i4.CompanyEndpoint).getById(
                session,
                params['id'],
              ),
        ),
        'update': _i1.MethodConnector(
          name: 'update',
          params: {
            'company': _i1.ParameterDescription(
              name: 'company',
              type: _i1.getType<_i12.Company>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['company'] as _i4.CompanyEndpoint).update(
                session,
                params['company'],
              ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['company'] as _i4.CompanyEndpoint).delete(
                session,
                params['id'],
              ),
        ),
      },
    );
    connectors['deliveryChannel'] = _i1.EndpointConnector(
      name: 'deliveryChannel',
      endpoint: endpoints['deliveryChannel']!,
      methodConnectors: {
        'create': _i1.MethodConnector(
          name: 'create',
          params: {
            'channel': _i1.ParameterDescription(
              name: 'channel',
              type: _i1.getType<_i13.DeliveryChannel>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['deliveryChannel'] as _i5.DeliveryChannelEndpoint)
                      .create(
                        session,
                        params['channel'],
                      ),
        ),
        'listByCompany': _i1.MethodConnector(
          name: 'listByCompany',
          params: {
            'companyId': _i1.ParameterDescription(
              name: 'companyId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['deliveryChannel'] as _i5.DeliveryChannelEndpoint)
                      .listByCompany(
                        session,
                        params['companyId'],
                      ),
        ),
        'listActiveByCompany': _i1.MethodConnector(
          name: 'listActiveByCompany',
          params: {
            'companyId': _i1.ParameterDescription(
              name: 'companyId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['deliveryChannel'] as _i5.DeliveryChannelEndpoint)
                      .listActiveByCompany(
                        session,
                        params['companyId'],
                      ),
        ),
        'getDefault': _i1.MethodConnector(
          name: 'getDefault',
          params: {
            'companyId': _i1.ParameterDescription(
              name: 'companyId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['deliveryChannel'] as _i5.DeliveryChannelEndpoint)
                      .getDefault(
                        session,
                        params['companyId'],
                      ),
        ),
        'getById': _i1.MethodConnector(
          name: 'getById',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['deliveryChannel'] as _i5.DeliveryChannelEndpoint)
                      .getById(
                        session,
                        params['id'],
                      ),
        ),
        'update': _i1.MethodConnector(
          name: 'update',
          params: {
            'channel': _i1.ParameterDescription(
              name: 'channel',
              type: _i1.getType<_i13.DeliveryChannel>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['deliveryChannel'] as _i5.DeliveryChannelEndpoint)
                      .update(
                        session,
                        params['channel'],
                      ),
        ),
        'setDefault': _i1.MethodConnector(
          name: 'setDefault',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['deliveryChannel'] as _i5.DeliveryChannelEndpoint)
                      .setDefault(
                        session,
                        params['id'],
                      ),
        ),
        'toggleActive': _i1.MethodConnector(
          name: 'toggleActive',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['deliveryChannel'] as _i5.DeliveryChannelEndpoint)
                      .toggleActive(
                        session,
                        params['id'],
                      ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['deliveryChannel'] as _i5.DeliveryChannelEndpoint)
                      .delete(
                        session,
                        params['id'],
                      ),
        ),
      },
    );
    connectors['report'] = _i1.EndpointConnector(
      name: 'report',
      endpoint: endpoints['report']!,
      methodConnectors: {
        'create': _i1.MethodConnector(
          name: 'create',
          params: {
            'report': _i1.ParameterDescription(
              name: 'report',
              type: _i1.getType<_i14.Report>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['report'] as _i6.ReportEndpoint).create(
                session,
                params['report'],
              ),
        ),
        'listByCompany': _i1.MethodConnector(
          name: 'listByCompany',
          params: {
            'companyId': _i1.ParameterDescription(
              name: 'companyId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'offset': _i1.ParameterDescription(
              name: 'offset',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['report'] as _i6.ReportEndpoint).listByCompany(
                    session,
                    params['companyId'],
                    status: params['status'],
                    limit: params['limit'],
                    offset: params['offset'],
                  ),
        ),
        'getById': _i1.MethodConnector(
          name: 'getById',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['report'] as _i6.ReportEndpoint).getById(
                session,
                params['id'],
              ),
        ),
        'update': _i1.MethodConnector(
          name: 'update',
          params: {
            'report': _i1.ParameterDescription(
              name: 'report',
              type: _i1.getType<_i14.Report>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['report'] as _i6.ReportEndpoint).update(
                session,
                params['report'],
              ),
        ),
        'markSent': _i1.MethodConnector(
          name: 'markSent',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'deliveryChannel': _i1.ParameterDescription(
              name: 'deliveryChannel',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['report'] as _i6.ReportEndpoint).markSent(
                session,
                params['id'],
                params['deliveryChannel'],
              ),
        ),
        'archive': _i1.MethodConnector(
          name: 'archive',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['report'] as _i6.ReportEndpoint).archive(
                session,
                params['id'],
              ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['report'] as _i6.ReportEndpoint).delete(
                session,
                params['id'],
              ),
        ),
      },
    );
    connectors['reportGeneration'] = _i1.EndpointConnector(
      name: 'reportGeneration',
      endpoint: endpoints['reportGeneration']!,
      methodConnectors: {
        'generate': _i1.MethodConnector(
          name: 'generate',
          params: {
            'companyId': _i1.ParameterDescription(
              name: 'companyId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'startDate': _i1.ParameterDescription(
              name: 'startDate',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'endDate': _i1.ParameterDescription(
              name: 'endDate',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'templateId': _i1.ParameterDescription(
              name: 'templateId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['reportGeneration']
                          as _i7.ReportGenerationEndpoint)
                      .generate(
                        session,
                        companyId: params['companyId'],
                        startDate: params['startDate'],
                        endDate: params['endDate'],
                        templateId: params['templateId'],
                      ),
        ),
        'regenerate': _i1.MethodConnector(
          name: 'regenerate',
          params: {
            'reportId': _i1.ParameterDescription(
              name: 'reportId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['reportGeneration']
                          as _i7.ReportGenerationEndpoint)
                      .regenerate(
                        session,
                        params['reportId'],
                      ),
        ),
        'send': _i1.MethodConnector(
          name: 'send',
          params: {
            'reportId': _i1.ParameterDescription(
              name: 'reportId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['reportGeneration']
                          as _i7.ReportGenerationEndpoint)
                      .send(
                        session,
                        params['reportId'],
                      ),
        ),
        'sendViaChannel': _i1.MethodConnector(
          name: 'sendViaChannel',
          params: {
            'reportId': _i1.ParameterDescription(
              name: 'reportId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'channelId': _i1.ParameterDescription(
              name: 'channelId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['reportGeneration']
                          as _i7.ReportGenerationEndpoint)
                      .sendViaChannel(
                        session,
                        params['reportId'],
                        params['channelId'],
                      ),
        ),
      },
    );
    connectors['reportTemplate'] = _i1.EndpointConnector(
      name: 'reportTemplate',
      endpoint: endpoints['reportTemplate']!,
      methodConnectors: {
        'create': _i1.MethodConnector(
          name: 'create',
          params: {
            'template': _i1.ParameterDescription(
              name: 'template',
              type: _i1.getType<_i15.ReportTemplate>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['reportTemplate'] as _i8.ReportTemplateEndpoint)
                      .create(
                        session,
                        params['template'],
                      ),
        ),
        'listByCompany': _i1.MethodConnector(
          name: 'listByCompany',
          params: {
            'companyId': _i1.ParameterDescription(
              name: 'companyId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['reportTemplate'] as _i8.ReportTemplateEndpoint)
                      .listByCompany(
                        session,
                        params['companyId'],
                      ),
        ),
        'getDefault': _i1.MethodConnector(
          name: 'getDefault',
          params: {
            'companyId': _i1.ParameterDescription(
              name: 'companyId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['reportTemplate'] as _i8.ReportTemplateEndpoint)
                      .getDefault(
                        session,
                        params['companyId'],
                      ),
        ),
        'getById': _i1.MethodConnector(
          name: 'getById',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['reportTemplate'] as _i8.ReportTemplateEndpoint)
                      .getById(
                        session,
                        params['id'],
                      ),
        ),
        'update': _i1.MethodConnector(
          name: 'update',
          params: {
            'template': _i1.ParameterDescription(
              name: 'template',
              type: _i1.getType<_i15.ReportTemplate>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['reportTemplate'] as _i8.ReportTemplateEndpoint)
                      .update(
                        session,
                        params['template'],
                      ),
        ),
        'setDefault': _i1.MethodConnector(
          name: 'setDefault',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['reportTemplate'] as _i8.ReportTemplateEndpoint)
                      .setDefault(
                        session,
                        params['id'],
                      ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['reportTemplate'] as _i8.ReportTemplateEndpoint)
                      .delete(
                        session,
                        params['id'],
                      ),
        ),
      },
    );
    connectors['repository'] = _i1.EndpointConnector(
      name: 'repository',
      endpoint: endpoints['repository']!,
      methodConnectors: {
        'create': _i1.MethodConnector(
          name: 'create',
          params: {
            'repository': _i1.ParameterDescription(
              name: 'repository',
              type: _i1.getType<_i16.Repository>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['repository'] as _i9.RepositoryEndpoint).create(
                    session,
                    params['repository'],
                  ),
        ),
        'listByCompany': _i1.MethodConnector(
          name: 'listByCompany',
          params: {
            'companyId': _i1.ParameterDescription(
              name: 'companyId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['repository'] as _i9.RepositoryEndpoint)
                  .listByCompany(
                    session,
                    params['companyId'],
                  ),
        ),
        'getById': _i1.MethodConnector(
          name: 'getById',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['repository'] as _i9.RepositoryEndpoint).getById(
                    session,
                    params['id'],
                  ),
        ),
        'update': _i1.MethodConnector(
          name: 'update',
          params: {
            'repository': _i1.ParameterDescription(
              name: 'repository',
              type: _i1.getType<_i16.Repository>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['repository'] as _i9.RepositoryEndpoint).update(
                    session,
                    params['repository'],
                  ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['repository'] as _i9.RepositoryEndpoint).delete(
                    session,
                    params['id'],
                  ),
        ),
        'toggleActive': _i1.MethodConnector(
          name: 'toggleActive',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['repository'] as _i9.RepositoryEndpoint)
                  .toggleActive(
                    session,
                    params['id'],
                  ),
        ),
      },
    );
    connectors['scheduleConfig'] = _i1.EndpointConnector(
      name: 'scheduleConfig',
      endpoint: endpoints['scheduleConfig']!,
      methodConnectors: {
        'upsert': _i1.MethodConnector(
          name: 'upsert',
          params: {
            'config': _i1.ParameterDescription(
              name: 'config',
              type: _i1.getType<_i17.ScheduleConfig>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['scheduleConfig'] as _i10.ScheduleConfigEndpoint)
                      .upsert(
                        session,
                        params['config'],
                      ),
        ),
        'getByCompany': _i1.MethodConnector(
          name: 'getByCompany',
          params: {
            'companyId': _i1.ParameterDescription(
              name: 'companyId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['scheduleConfig'] as _i10.ScheduleConfigEndpoint)
                      .getByCompany(
                        session,
                        params['companyId'],
                      ),
        ),
        'toggleEnabled': _i1.MethodConnector(
          name: 'toggleEnabled',
          params: {
            'companyId': _i1.ParameterDescription(
              name: 'companyId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['scheduleConfig'] as _i10.ScheduleConfigEndpoint)
                      .toggleEnabled(
                        session,
                        params['companyId'],
                      ),
        ),
        'updateNextRun': _i1.MethodConnector(
          name: 'updateNextRun',
          params: {
            'companyId': _i1.ParameterDescription(
              name: 'companyId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'nextRunAt': _i1.ParameterDescription(
              name: 'nextRunAt',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['scheduleConfig'] as _i10.ScheduleConfigEndpoint)
                      .updateNextRun(
                        session,
                        params['companyId'],
                        params['nextRunAt'],
                      ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'companyId': _i1.ParameterDescription(
              name: 'companyId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['scheduleConfig'] as _i10.ScheduleConfigEndpoint)
                      .delete(
                        session,
                        params['companyId'],
                      ),
        ),
      },
    );
    connectors['greeting'] = _i1.EndpointConnector(
      name: 'greeting',
      endpoint: endpoints['greeting']!,
      methodConnectors: {
        'hello': _i1.MethodConnector(
          name: 'hello',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['greeting'] as _i11.GreetingEndpoint).hello(
                session,
                params['name'],
              ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _i18.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _i19.Endpoints()
      ..initializeEndpoints(server);
  }

  @override
  _i1.FutureCallDispatch? get futureCalls {
    return _i20.FutureCalls();
  }
}
