import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:sky_storage_hive/sky_storage_hive.dart';
import 'package:splittr/features/quick_split/data/datasources/quick_split_local_data_source.dart';
import 'package:splittr/features/quick_split/data/models/split_history_hive_model.dart';
import 'package:splittr/features/quick_split/domain/entities/split_history.dart';

@Injectable(as: QuickSplitLocalDataSource)
class QuickSplitLocalDataSourceImpl implements QuickSplitLocalDataSource {
  static const String _boxName = 'split_history_box';
  HiveDao<SplitHistoryHiveModel>? _dao;

  Future<HiveDao<SplitHistoryHiveModel>> get _getDao async {
    if (_dao != null) return _dao!;

    // Open the native Hive CE box
    final box = await Hive.openBox<SplitHistoryHiveModel>(_boxName);

    // Wrap it in the package's DAO
    _dao = HiveDao<SplitHistoryHiveModel>(box: box);
    return _dao!;
  }

  @override
  Future<void> cacheSplit(SplitHistory split) async {
    final dao = await _getDao;
    final hiveModel = SplitHistoryHiveModel.fromEntity(split);

    // The DAO handles the actual box.put()
    await dao.put(split.id, hiveModel);
  }

  @override
  Future<List<SplitHistory>> fetchCachedSplits() async {
    final dao = await _getDao;
    final hiveModels = await dao.getAll();

    return hiveModels.map((model) => model.toEntity()).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }
}
