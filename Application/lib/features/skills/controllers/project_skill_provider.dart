import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:paralelo/features/skills/models/project_skill_repository.dart';
import 'package:paralelo/features/skills/models/project_skill.dart';

final projectSkillProvider = Provider((ref) {
  final client = Supabase.instance.client;
  final repo = SupabaseProjectSkillRepository(client);

  return ProjectSkillProvider(repo);
});

class ProjectSkillProvider {
  final ProjectSkillRepository _repo;

  const ProjectSkillProvider(this._repo);

  Future<List<ProjectSkill>> getByProject(
    int projectId, {
    bool includeRelations = false,
  }) {
    return _repo.getByProject(projectId, includeRelations: includeRelations);
  }
}
