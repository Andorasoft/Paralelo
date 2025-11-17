import 'package:paralelo/core/imports.dart';
import '../models/user_repository.dart';

/// Provides a singleton instance of [SupabaseUserRepository].
///
/// This provider gives access to all user-related database operations,
/// using the global [Supabase.instance.client] configured in the app.
///
/// Example:
/// ```dart
/// final repo = ref.read(appUserProvider);
/// final user = await repo.getById(userId);
/// ```
final userProvider = Provider<UserRepository>((_) {
  final client = Supabase.instance.client;
  return SupabaseUserRepository(client);
});
