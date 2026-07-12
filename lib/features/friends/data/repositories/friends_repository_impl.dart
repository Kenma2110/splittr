import 'package:injectable/injectable.dart';
import 'package:sky_architecture/sky_architecture.dart';
import 'package:sky_network/sky_network.dart';
import 'package:splittr/features/auth/data/mappers/user.dart';
import 'package:splittr/features/auth/domain/entities/user.dart';
import 'package:splittr/features/friends/data/datasources/friends_remote_data_source.dart';
import 'package:splittr/features/friends/domain/repositories/friends_repository.dart';

@LazySingleton(as: FriendsRepository)
final class FriendsRepositoryImpl implements FriendsRepository {
  const FriendsRepositoryImpl(
    this._apiCallHandler,
    this._friendsRemoteDataSource,
  );

  final ApiCallHandler _apiCallHandler;
  final FriendsRemoteDataSource _friendsRemoteDataSource;

  @override
  FutureEitherFailure<List<User>> getFriends() async {
    final result = await _apiCallHandler.handle(
      _friendsRemoteDataSource.getFriends,
    );
    return result.map((models) => models.toDomain());
  }

  @override
  FutureEitherFailure<User> addFriend({
    String? friendEmail,
    String? friendPhone,
  }) async {
    final result = await _apiCallHandler.handle(
      () => _friendsRemoteDataSource.addFriend(
        friendEmail: friendEmail,
        friendPhone: friendPhone,
      ),
    );
    return result.map((model) => model.toDomain());
  }

  @override
  FutureEitherFailure<Unit> removeFriend(String friendId) async {
    return _apiCallHandler.handle(
      () => _friendsRemoteDataSource.removeFriend(friendId),
    );
  }
}
