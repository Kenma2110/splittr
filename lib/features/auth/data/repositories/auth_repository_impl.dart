import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:sky_architecture/sky_architecture.dart';
import 'package:sky_network/sky_network.dart';
import 'package:splittr/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:splittr/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:splittr/features/auth/data/mappers/user.dart';
import 'package:splittr/features/auth/domain/entities/user.dart';
import 'package:splittr/features/auth/domain/repositories/auth_repository.dart';

@LazySingleton(as: AuthRepository)
final class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(
    this._authRemoteDataSource,
    this._authLocalDataSource,
    this._apiCallHandler,
  );

  final AuthRemoteDataSource _authRemoteDataSource;
  final AuthLocalDataSource _authLocalDataSource;
  final ApiCallHandler _apiCallHandler;

  @override
  FutureEitherFailure<User> loginWithEmail({
    required String email,
    required String password,
  }) async {
    final result = await _apiCallHandler.handle(
      () => _authRemoteDataSource.loginWithEmail(
        email: email,
        password: password,
      ),
    );
    return result.map((userModel) => userModel.toDomain());
  }

  @override
  FutureEitherFailure<User> signUpWithEmail({
    required String email,
    required String password,
    required String name,
  }) async {
    final result = await _apiCallHandler.handle(
      () => _authRemoteDataSource.signUpWithEmail(
        email: email,
        password: password,
        name: name,
      ),
    );
    return result.map((userModel) => userModel.toDomain());
  }

  @override
  FutureEitherFailure<User> checkAuthStatus() async {
    try {
      final isGuest = await _authLocalDataSource.isGuestUser();
      if (isGuest) {
        return const Right(User(id: 'guest', name: 'Guest'));
      }
    } on Exception catch (e) {
      return Left(e.toFailure());
    }

    final result = await _apiCallHandler.handle(
      _authRemoteDataSource.checkAuthStatus,
    );

    return result.map((userModel) => userModel.toDomain());
  }

  @override
  FutureEitherFailure<Unit> logout() async {
    try {
      await _authLocalDataSource.clearSession();
      await _authRemoteDataSource.logout();
      return const Right(unit);
    } on Exception catch (e) {
      return Left(e.toFailure());
    }
  }

  @override
  FutureEitherFailure<Unit> saveGuestSession() async {
    try {
      await _authLocalDataSource.saveGuestSession();
      return const Right(unit);
    } on Exception catch (e) {
      return Left(e.toFailure());
    }
  }

  @override
  FutureEitherFailure<Unit> clearSession() async {
    try {
      await _authLocalDataSource.clearSession();
      return const Right(unit);
    } on Exception catch (e) {
      return Left(e.toFailure());
    }
  }

  @override
  Future<bool> isGuestUser() async {
    try {
      return await _authLocalDataSource.isGuestUser();
    } on Exception catch (_) {
      return false;
    }
  }
}
