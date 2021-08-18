// Packages do dart
import 'package:flutter/foundation.dart';
// Package de terceiros
// Packages/imports do próprio lib, domain
import '../entities/entities.dart';

abstract class Authentication {
  Future<AccountEntity> auth(
      {@required String email, @required String password});
}
