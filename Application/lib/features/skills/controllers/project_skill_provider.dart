import 'package:paralelo/core/imports.dart';
import 'package:paralelo/features/skills/models/project_skill_repository.dart';

final projectSkillProvider = Provider<ProjectSkillRepository>((ref) {
  final client = Supabase.instance.client;
  return SupabaseProjectSkillRepository(client);
});
