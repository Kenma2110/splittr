import 'package:sky_architecture/sky_architecture.dart';
import 'package:splittr/features/auth/data/models/user_model.dart';

abstract interface class FriendsRemoteDataSource {
  Future<List<UserModel>> getFriends();

  Future<UserModel> addFriend({String? friendEmail, String? friendPhone});

  Future<Unit> removeFriend(String friendId);
}
