import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:paralelo/features/projects/models/project_skill_repository.dart';
import 'package:paralelo/features/projects/models/project_skill.dart';

final projectSkillProvider = Provider((ref) {
  final client = Supabase.instance.client;
  final repo = SupabaseProjectSkillRepository(client);

  return _ProjectSkillProvider(repo);
});

class _ProjectSkillProvider {
  final ProjectSkillRepository _repo;

  const _ProjectSkillProvider(this._repo);

  Future<List<ProjectSkill>> getByProject(int projectId) {
    return _repo.getByProject(projectId);
  }
}
