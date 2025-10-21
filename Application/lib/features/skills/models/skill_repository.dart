import 'package:supabase_flutter/supabase_flutter.dart';
import './skill.dart';

abstract class SkillRepository {
  Future<Skill?> getById(int id);
}

class SupabaseSkillRepository implements SkillRepository {
  final SupabaseClient _client;

  const SupabaseSkillRepository(this._client);

  @override
  Future<Skill?> getById(int id) async {
    final data = await _client
        .from('skill')
        .select()
        .eq('id', id)
        .maybeSingle();

    return data != null ? Skill.fromMap(data) : null;
  }
}
