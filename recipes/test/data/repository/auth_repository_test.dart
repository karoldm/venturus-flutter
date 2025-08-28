import 'package:dart_either/dart_either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:recipes/data/repositories/auth_repository.dart';
import 'package:recipes/data/services/auth_service.dart';
import 'package:recipes/di/service_locator.dart';
import 'package:recipes/utils/errors/app_error.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import './auth_repository_test.mocks.dart';

@GenerateMocks([AuthService])
void main() {
  late AuthRepository authRepository;
  late MockAuthService mockAuthService;

  // antes de todos os testes
  setUpAll(() {
    provideDummy<Either<AppError, AuthResponse>>(Right(AuthResponse()));
    provideDummy<Either<AppError, Map<String, dynamic>?>>(
      Right(<String, dynamic>{}),
    );
    provideDummy<Either<AppError, void>>(Right(null));
  });

  // antes de cada teste
  setUp(() {
    mockAuthService = MockAuthService();

    // limpar todas as DI
    getIt.reset();

    // registrar o mock do AuthService
    getIt.registerSingleton<AuthService>(mockAuthService);

    authRepository = AuthRepository();
  });

  // garantindo que o getit não mantenha instancias desnecessárias
  tearDown(() {
    if (getIt.isRegistered<AuthService>()) {
      getIt.unregister<AuthService>();
    }
  });

  group("AuthRepository", () {
    group("CurrentUser", () {
      test("should return the user profile when user is logged", () async {
        // Arrange
        final mockUser = User(
          id: 'user-id',
          appMetadata: {},
          userMetadata: {},
          aud: 'authenticated',
          createdAt: DateTime.now().toIso8601String(),
        );
        final mockProfile = {'id': 'user-id', 'username': 'user.name'};
        when(mockAuthService.currentUser).thenReturn(mockUser);
        when(
          mockAuthService.fetchUserProfile('user-id'),
        ).thenAnswer((_) async => Right(mockProfile));

        // Act
        final result = await authRepository.currentUser;

        // Assert
        expect(result.isRight, true);
      });
    });
    group("SignInWithPassword", () {});
    group("SignUp", () {});
    group("SignOut", () {});
  });
}
