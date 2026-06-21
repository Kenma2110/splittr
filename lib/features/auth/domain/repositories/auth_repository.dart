import 'package:fpdart/fpdart.dart';
import 'package:splittr/features/auth/domain/entities/user.dart';
import 'package:splittr/utils/typedefs/typedefs.dart';

abstract interface class AuthRepository {
  FutureEitherFailure<User> loginWithEmail({
    required String email,
    required String password,
  });

  FutureEitherFailure<User> signUpWithEmail({
    required String email,
    required String password,
    required String name,
  });

  FutureEitherFailure<User> checkAuthStatus();

  FutureEitherFailure<Unit> logout();

  FutureEitherFailure<Unit> saveGuestSession();

  FutureEitherFailure<Unit> clearSession();

  Future<bool> isGuestUser();
}
