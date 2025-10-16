import 'package:paralelo/core/imports.dart';
import 'package:paralelo/features/user/models/user_preference_repository.dart';

final userPreferenceProvider = Provider<UserPreferenceRepository>((ref) {
  final client = Supabase.instance.client;
  return SupabaseUserPreferenceRepository(client);
});
