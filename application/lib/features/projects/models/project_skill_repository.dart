import 'package:paralelo/features/projects/models/project_skill.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ProjectSkillRepository {
  Future<List<ProjectSkill>> getByProject(int projectId);
}

class SupabaseProjectSkillRepository implements ProjectSkillRepository {
  final SupabaseClient _client;

  const SupabaseProjectSkillRepository(this._client);

  @override
  Future<List<ProjectSkill>> getByProject(int projectId) async {
    final data = await _client
        .from('project_skill')
        .select()
        .eq('project_id', projectId);

    return data.map((i) => _fromMap(i)).toList();
  }

  /// Builds a [ProjectSkill] object from a database map.
  ProjectSkill _fromMap(Map<String, dynamic> map) {
    return ProjectSkill(
      id: map['id'],
      createdAt: DateTime.parse(map['created_at']),
      projectId: map['project_id'],
      skillId: map['skill_id'],
    );
  }
}
