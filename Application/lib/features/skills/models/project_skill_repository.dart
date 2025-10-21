import 'package:supabase_flutter/supabase_flutter.dart';
import './project_skill.dart';

abstract class ProjectSkillRepository {
  Future<List<ProjectSkill>> getByProject(
    int projectId, {
    required bool includeRelations,
  });
}

class SupabaseProjectSkillRepository implements ProjectSkillRepository {
  final SupabaseClient _client;

  const SupabaseProjectSkillRepository(this._client);

  @override
  Future<List<ProjectSkill>> getByProject(
    int projectId, {
    required bool includeRelations,
  }) async {
    final data = await _client
        .from('project_skill')
        .select(includeRelations ? '*, skill(*)' : '*')
        .eq('project_id', projectId);

    return data.map((i) => ProjectSkill.fromMap(i)).toList();
  }
}
