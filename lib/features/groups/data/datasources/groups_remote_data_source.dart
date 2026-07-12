import 'package:splittr/features/groups/data/models/group_model.dart';

abstract interface class GroupsRemoteDataSource {
  Future<List<GroupModel>> getGroups();

  Future<GroupModel> createGroup({
    required String name,
    required String description,
  });
}
