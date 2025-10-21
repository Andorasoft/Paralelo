import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paralelo/features/skills/models/skill.dart';
import 'package:paralelo/features/skills/models/skill_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final skillProvider = Provider((ref) {
  final client = Supabase.instance.client;
  final repo = SupabaseSkillRepository(client);

  return SkillProvider(repo);
});

class SkillProvider {
  final SkillRepository _repo;

  const SkillProvider(this._repo);

  Future<Skill?> getById(int id) {
    return _repo.getById(id);
  }
}
