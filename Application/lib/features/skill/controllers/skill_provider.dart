import 'package:paralelo/core/imports.dart';
import '../models/skill_repository.dart';

final skillProvider = Provider<SkillRepository>((ref) {
  final client = Supabase.instance.client;
  return SupabaseSkillRepository(client);
});
