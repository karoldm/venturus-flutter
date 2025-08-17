import 'package:dart_either/dart_either.dart';
import 'package:flutter/foundation.dart';
import 'package:recipes/di/service_locator.dart';
import 'package:recipes/utils/errors/app_error.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabaseClient = getIt<SupabaseClient>();

  User? get currentUser => _supabaseClient.auth.currentUser;

  // Stream para ouvir mudanças na autenticação
  // o próprio supabase já fornece um stream de mudanças
  Stream<AuthState> get authStateChanges =>
      _supabaseClient.auth.onAuthStateChange;

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
      switch (error.message) {
        case 'Invalid login credentials':
          return Left(
            AppError('Usuário não cadastrado ou credenciais inválidas.'),
          );
        case "Email not confirmed":
          return Left(AppError('Email não confirmado.'));
        default:
          debugPrint(error.code);
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

  Future<Either<AppError, AuthResponse>> signUp({
    required String email,
    required String password,
    required String username,
    required String avatarUrl,
  }) async {
    try {
      // verificar se o username já existe
      final existingUsername = await _supabaseClient
          .from('profiles')
          .select()
          .eq('username', username)
          .maybeSingle();
      if (existingUsername != null) {
        return Left(AppError('Esse nome de usuário já existe.'));
      }

      final result = await insertUser(email: email, password: password);
      return result.fold(
        ifLeft: (left) => Left(left),
        ifRight: (right) async {
          await _supabaseClient.from('profiles').insert({
            'id': right.user!.id,
            'username': username,
            'avatar_url': avatarUrl,
          });
          return Right(right);
        },
      );
    } on PostgrestException catch (error) {
      switch (error.code) {
        case '23505':
          return Left(AppError('Esse email já está cadastrado.'));
        default:
          debugPrint(error.toString());
          return Left(AppError('Erro ao cadastrar usuário.', error));
      }
    } catch (error) {
      return Left(AppError('Erro desconhecido ao cadastrar usuário.', error));
    }
  }

  Future<Either<AppError, AuthResponse>> insertUser({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabaseClient.auth.signUp(
        email: email,
        password: password,
      );
      return Right(response);
    } on AuthException catch (error) {
      switch (error.message) {
        case 'Email not confirmed':
          return Left(
            AppError('Email não confirmado. Verifique sua caixa de entrada.'),
          );
        default:
          debugPrint(error.toString());
          return Left(AppError('Erro ao cadastrar usuário.'));
      }
    }
  }

  Future<Either<AppError, void>> signOut() async {
    try {
      await _supabaseClient.auth.signOut();
      return Right(null);
    } on AuthException catch (error) {
      return Left(AppError('Erro ao fazer logout.', error));
    } catch (error) {
      return Left(AppError('Erro inesperado ao sair.', error));
    }
  }
}
