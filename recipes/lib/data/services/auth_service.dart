import 'package:dart_either/dart_either.dart';
import 'package:recipes/di/service_locator.dart';
import 'package:recipes/utils/errors/app_error.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabaseClient = getIt<SupabaseClient>();

  User? get currentUser => _supabaseClient.auth.currentUser;

  Future<Either<AppError, AuthResponse>> signInWithPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return Right(response);
    } on AuthException catch (error) {
      switch (error.code) {
        case 'invalid login credentials':
          return Left(
            AppError('Usuário não cadastrado ou credenciais inválidas.'),
          );
        case "Email not confirmed":
          return Left(AppError('Email não confirmado.'));
        default:
          return Left(AppError('Erro ao fazer login.', error));
      }
    }
  }

  Future<Either<AppError, Map<String, dynamic>?>> fetchUserProfile(
    String userId,
  ) async {
    try {
      final profile = await _supabaseClient
          .from('profiles')
          .select()
          .eq('id', userId)
          .maybeSingle();

      return Right(profile);
    } catch (error) {
      return Left(AppError('Erro ao buscar perfil do usuário.', error));
    }
  }

  // TODO implement signUpWithPassword
}
