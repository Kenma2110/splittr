import 'package:hive_ce/hive.dart';
import 'package:sky_storage_hive/sky_storage_hive.dart';
import 'package:splittr/features/quick_split/data/models/split_history_hive_model.dart';

class QuickSplitHiveRegisterer implements HiveAdapterRegisterer {
  @override
  void registerAdapters() {
    Hive.registerAdapter<SplitHistoryHiveModel>(SplitHistoryHiveModelAdapter());
  }
}
