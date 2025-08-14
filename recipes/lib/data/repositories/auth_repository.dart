import 'package:dart_either/dart_either.dart';
import 'package:get/get.dart';
import 'package:recipes/data/models/user.dart';
import 'package:recipes/data/services/auth_service.dart';
import 'package:recipes/di/service_locator.dart';
import 'package:recipes/utils/errors/app_error.dart';

class AuthRepository extends GetxController {
  final _service = getIt<AuthService>();

  Future<Either<AppError, UserProfile>> get currentUser async {
    final user = _service.currentUser;
    final profile = await _service.fetchUserProfile(user!.id);
    return profile.fold(
      ifLeft: (left) => Left(left),
      ifRight: (right) =>
          Right(UserProfile.fromSupabase(user.toJson(), right!)),
    );
  }

  Future<Either<AppError, UserProfile>> signInWithPassword(
    String email,
    String password,
  ) async {
    final result = await _service.signInWithPassword(
      email: email,
      password: password,
    );
    return result.fold(
      ifLeft: (left) => Left(left),
      ifRight: (right) async {
        final user = right.user!;
        final profileResult = await _service.fetchUserProfile(user.id);
        return profileResult.fold(
          ifLeft: (left) => Left(left),
          ifRight: (profile) =>
              Right(UserProfile.fromSupabase(user.toJson(), profile!)),
        );
      },
    );
  }

  Future<Either<AppError, void>> signOut() async {
    return await _service.signOut();
  }

  // TODO: Implement signUp method
}
