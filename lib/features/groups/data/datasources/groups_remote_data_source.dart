import 'package:splittr/features/groups/data/models/group_model.dart';

abstract interface class GroupsRemoteDataSource {
  Future<List<GroupModel>> getGroups();

  Future<GroupModel> joinGroup({
    required String inviteCode,
  });

  Future<GroupModel> createGroup({
    required String name,
    required String description,
  });
}
