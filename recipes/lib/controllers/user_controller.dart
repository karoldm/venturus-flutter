import 'package:get/get.dart';
import 'package:recipes/data/models/user.dart';
import 'package:recipes/data/repositories/auth_repository.dart';
import 'package:recipes/di/service_locator.dart';

class UserController extends GetxController {
  final _repository = getIt<AuthRepository>();
  final user = Rxn<UserProfile>();

  Future<void> loadUser() async {
    final result = await _repository.currentUser;
    result.fold(ifLeft: (left) => null, ifRight: (right) => user.value = right);
  }
}
