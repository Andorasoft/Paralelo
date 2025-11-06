import 'package:paralelo/core/imports.dart';
import 'skill.dart';

abstract class SkillRepository {
  Future<List<Skill>> getAll();

  Future<List<Skill>> getForUser(String userId);

  Future<List<Skill>> getForProject(String projectId);
}

class SupabaseSkillRepository implements SkillRepository {
  final SupabaseClient _client;

  const SupabaseSkillRepository(this._client);

  @override
  Future<List<Skill>> getAll() async {
    final data = await _client.from('skill').select();

    return data.map((i) => Skill.fromMap(i)).toList();
  }

  @override
  Future<List<Skill>> getForUser(String userId) async {
    final res = await _client
        .from('user_skill')
        .select('skill_id')
        .eq('user_id', userId);

    final skillIds = res.map((e) => e['skill_id'] as int).toList();

    if (skillIds.isEmpty) return [];

    final data = await _client
        .from('skill')
        .select()
        .inFilter('id', skillIds)
        .order('name', ascending: true);

    return data.map((e) => Skill.fromMap(e)).toList();
  }

  @override
  Future<List<Skill>> getForProject(String projectId) async {
    final res = await _client
        .from('project_skill')
        .select('skill_id')
        .eq('project_id', projectId);

    final ids = res.map((e) => e['skill_id'] as int).toList();

    if (ids.isEmpty) return [];

    final data = await _client
        .from('skill')
        .select()
        .inFilter('id', ids)
        .order('name', ascending: true);

    return data.map((e) => Skill.fromMap(e)).toList();
  }
}
