import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:sky_storage_hive/sky_storage_hive.dart';
import 'package:splittr/features/auth/data/datasources/auth_local_data_source.dart';

@Injectable(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  static const String _boxName = 'auth_local_box';
  static const String _isGuestKey = 'is_guest_user';
  HiveDao<bool>? _dao;

  Future<HiveDao<bool>> get _getDao async {
    if (_dao != null) return _dao!;

    final box = await Hive.openBox<bool>(_boxName);
    _dao = HiveDao<bool>(box: box);
    return _dao!;
  }

  @override
  Future<void> saveGuestSession() async {
    final dao = await _getDao;
    await dao.put(_isGuestKey, true);
  }

  @override
  Future<void> clearSession() async {
    final dao = await _getDao;
    await dao.delete(_isGuestKey);
  }

  @override
  Future<bool> isGuestUser() async {
    final dao = await _getDao;
    return await dao.get(_isGuestKey) ?? false;
  }
}
