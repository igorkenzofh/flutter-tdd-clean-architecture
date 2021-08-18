// Packages do dart
import 'package:flutter/foundation.dart';
// Package de terceiros
// Packages/imports do próprio lib, domain
import '../entities/entities.dart';

abstract class Authentication {
  Future<AccountEntity> auth(AuthenticationParams params);
}

class AuthenticationParams {
  final String email;
  final String password;

  AuthenticationParams({@required this.email, @required this.password});
}
