abstract interface class AuthLocalDataSource {
  Future<void> saveGuestSession();
  Future<void> clearSession();
  Future<bool> isGuestUser();
}
