import 'package:paralelo/core/imports.dart';
import 'package:paralelo/features/university/models/university_repository.dart';

final universityProvider = Provider<UniversityRepository>((_) {
  final client = Supabase.instance.client;
  return SupabaseUniversityRepository(client);
});
