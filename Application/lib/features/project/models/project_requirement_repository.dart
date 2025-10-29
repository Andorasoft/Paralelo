import 'package:supabase_flutter/supabase_flutter.dart';
import 'project_requirement.dart';

abstract class ProjectRequirementRepository {
  Future<ProjectRequirement?> getByProject(int projectId);
}

class SupabaseProjectRequirementRepository
    implements ProjectRequirementRepository {
  final SupabaseClient _client;

  const SupabaseProjectRequirementRepository(this._client);

  @override
  Future<ProjectRequirement?> getByProject(int projectId) async {
    final data = await _client
        .from('project_requirement')
        .select()
        .eq('project_id', projectId)
        .maybeSingle();

    return data != null ? _fromMap(data) : null;
  }

  /// Builds a [ProjectRequirement] object from a database map.
  ProjectRequirement _fromMap(Map<String, dynamic> map) {
    return ProjectRequirement(
      id: map['id'],
      createdAt: DateTime.parse(map['created_at']),
      requirement: map['requirement'],
      projectId: map['project_id'],
    );
  }
}
