import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sky_architecture/sky_architecture.dart';
import 'package:sky_network/sky_network.dart';
import 'package:splittr/features/auth/data/models/user_model.dart';
import 'package:splittr/features/friends/data/datasources/friends_remote_data_source.dart';
import 'package:splittr/features/friends/data/repositories/friends_repository_impl.dart';
import 'package:splittr/features/friends/domain/repositories/friends_repository.dart';

class MockFriendsDataSource extends Mock implements FriendsRemoteDataSource {}

class MockApiCallHandler extends Mock implements ApiCallHandler {
  @override
  Future<Either<Failure, T>> handle<T>(Future<T> Function() call) async {
    try {
      final res = await call();
      return Right(res);
    } on Object catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

void main() {
  late MockFriendsDataSource mockDataSource;
  late MockApiCallHandler mockHandler;
  late FriendsRepository repository;

  setUp(() {
    mockDataSource = MockFriendsDataSource();
    mockHandler = MockApiCallHandler();
    repository = FriendsRepositoryImpl(mockHandler, mockDataSource);
  });

  group('FriendsRepositoryImpl', () {
    const userModel = UserModel(
      id: 'user-123',
      firebaseUid: 'fb-123',
      name: 'John Doe',
      email: 'john@example.com',
      phone: '123456',
    );

    test('getFriends returns list of domain Users', () async {
      when(
        () => mockDataSource.getFriends(),
      ).thenAnswer((_) async => [userModel]);

      final result = await repository.getFriends();

      expect(result.isRight(), true);
      result.fold(
        (failure) => fail('Should succeed'),
        (users) {
          expect(users.length, 1);
          expect(users[0].id, 'user-123');
          expect(users[0].name, 'John Doe');
        },
      );
    });

    test('addFriend returns domain User', () async {
      when(
        () => mockDataSource.addFriend(
          friendEmail: 'john@example.com',
          friendPhone: '123456',
        ),
      ).thenAnswer((_) async => userModel);

      final result = await repository.addFriend(
        friendEmail: 'john@example.com',
        friendPhone: '123456',
      );

      expect(result.isRight(), true);
      result.fold(
        (failure) => fail('Should succeed'),
        (user) => expect(user.id, 'user-123'),
      );
    });

    test('removeFriend returns Unit', () async {
      when(
        () => mockDataSource.removeFriend('user-123'),
      ).thenAnswer((_) async => unit);

      final result = await repository.removeFriend('user-123');

      expect(result.isRight(), true);
      result.fold(
        (failure) => fail('Should succeed'),
        (val) => expect(val, unit),
      );
    });
  });
}
