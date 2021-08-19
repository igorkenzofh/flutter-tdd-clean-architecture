import 'package:flutter/foundation.dart';

import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';

import '../http/http.dart';

// Regra de negocio, garantir a conversão de dados da api para domínio
class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({@required this.httpClient, @required this.url});

  Future<void> auth(AuthenticationParams params) async {
    try {
      await httpClient.request(
          url: url,
          method: 'post',
          body: RemoteAuthenticationParams.fromDomain(params).toJson());
    } on HttpError catch (error) {
      throw error == HttpError.unauthorized
          ? DomainError.invalidCredentials
          : DomainError.unexpected;
    }
  }
}

class RemoteAuthenticationParams {
  final String email;
  final String password;

  RemoteAuthenticationParams({@required this.email, @required this.password});

  factory RemoteAuthenticationParams.fromDomain(AuthenticationParams params) =>
      RemoteAuthenticationParams(
          email: params.email, password: params.password);

  Map toJson() => {'email': email, 'password': password};
}
