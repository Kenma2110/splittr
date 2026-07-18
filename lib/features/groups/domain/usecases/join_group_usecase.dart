import 'package:injectable/injectable.dart';
import 'package:sky_architecture/sky_architecture.dart' hide Group;
import 'package:splittr/features/groups/domain/entities/group.dart';
import 'package:splittr/features/groups/domain/repositories/groups_repository.dart';

@lazySingleton
final class JoinGroupUseCase implements UseCase<Group, JoinGroupParams> {
  const JoinGroupUseCase(this._groupsRepository);

  final GroupsRepository _groupsRepository;

  @override
  Future<Either<Failure, Group>> call(JoinGroupParams params) {
    return _groupsRepository.joinGroup(inviteCode: params.inviteCode);
  }
}

class JoinGroupParams extends Equatable {
  const JoinGroupParams({
    required this.inviteCode,
  });

  final String inviteCode;

  @override
  List<Object?> get props => [inviteCode];
}
