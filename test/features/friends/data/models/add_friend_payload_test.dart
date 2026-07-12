import 'package:flutter_test/flutter_test.dart';
import 'package:splittr/features/friends/data/models/add_friend_payload.dart';

void main() {
  group('AddFriendPayload', () {
    test('toJson converts fields to JSON correctly', () {
      const payload = AddFriendPayload(
        friendEmail: 'friend@example.com',
        friendPhone: '+1234567890',
      );

      final json = payload.toJson();

      expect(json['friendEmail'], 'friend@example.com');
      expect(json['friendPhone'], '+1234567890');
    });
  });
}
