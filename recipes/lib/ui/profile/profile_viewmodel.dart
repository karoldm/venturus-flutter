import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:recipes/data/models/user.dart';
import 'package:recipes/data/repositories/auth_repository.dart';
import 'package:recipes/di/service_locator.dart';

class ProfileViewModel extends GetxController {
  final _repository = getIt<AuthRepository>();

  final _profile = Rxn<UserProfile>();
  final _isLoading = false.obs;
  final _errorMessage = ''.obs;

  // Rxn é usado quando o valor pode ser nulo
  // iniciar por padrão como null
  Rxn<UserProfile> get profile => _profile;
  // .obs é usado para tipos primitos ou quando você tem um valor inicial
  bool get isLoading => _isLoading.value;
  String? get errorMessage => _errorMessage.value;

  Future<void> getCurrentUser() async {
    _isLoading.value = true;
    final result = await _repository.currentUser;
    result.fold(
      ifLeft: (left) => _errorMessage.value = left.message,
      ifRight: (right) => _profile.value = right,
    );
    _isLoading.value = false;
  }

  // TODO: signout
}
