import 'package:paralelo/core/imports.dart';
import 'project_skill.dart';

abstract class ProjectSkillRepository {
  Future<ProjectSkill> create({
    required String projectId,
    required String skillId,
  });
}

class SupabaseProjectSkillRepository implements ProjectSkillRepository {
  final SupabaseClient _client;

  const SupabaseProjectSkillRepository(this._client);

  @override
  Future<ProjectSkill> create({
    required String projectId,
    required String skillId,
  }) async {
    final data = await _client
        .from('project_skill')
        .insert({'project_id': projectId, 'skill_id': skillId})
        .select()
        .single();

    return ProjectSkill.fromMap(data);
  }
}
