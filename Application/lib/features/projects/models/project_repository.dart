import 'package:supabase_flutter/supabase_flutter.dart';
import './project.dart';

abstract class ProjectRepository {
  Future<List<Project>> getAll(String userId, {int? universityId});
  Future<Project?> getById(int id);
}

class SupabaseProjectRepository implements ProjectRepository {
  final SupabaseClient _client;

  const SupabaseProjectRepository(this._client);

  @override
  Future<List<Project>> getAll(String userId, {int? universityId}) async {
    final data = await _client.from('project').select().neq('owner_id', userId);

    return data.map((i) => _fromMap(i)).toList();
  }

  @override
  Future<Project?> getById(int id) async {
    final data = await _client
        .from('project')
        .select()
        .eq('id', id)
        .maybeSingle();

    return data != null ? _fromMap(data) : null;
  }

  /// Builds a [Project] object from a database map.
  Project _fromMap(Map<String, dynamic> map) {
    return Project(
      id: map['id'],
      createdAt: DateTime.parse(map['created_at']),
      title: map['title'],
      description: map['description'],
      budget: map['budget'],
      status: map['status'],
      category: map['category'],
      ownerId: map['owner_id'],
    );
  }
}
