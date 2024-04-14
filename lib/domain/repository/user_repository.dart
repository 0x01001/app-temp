import '../index.dart';

abstract class UserRepository {
  bool get isLoggedIn;

  Future<bool> register(String email, String password, String name);

  Future<bool> login(String email, String password);

  Future<void> logout();

  Future<void> resetPassword({required String token, required String email, required String password, required String confirmPassword});

  Future<void> forgotPassword(String email);

  Future<bool> checkEmail(String email);

  // UserEntity getUserPreference();

  Future<void> clearCurrentUserData();

  Future<List<UserEntity>> getUsers({required int page, required int? limit});

  Future<UserEntity?> getMe();

  Future<String> getAccessToken();

  // int putLocalUser(User user);

  // Stream<List<User>> getLocalUsersStream();

  // List<User> getLocalUsers();

  // User? getLocalUser(int id);

  // bool deleteImageUrl(int id);

  // int deleteAllUsersAndImageUrls();
}
