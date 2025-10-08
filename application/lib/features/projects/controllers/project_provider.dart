import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:paralelo/features/projects/models/project_repository.dart';
import 'package:paralelo/features/projects/models/project.dart';

final projectProvider = Provider((ref) {
  final client = Supabase.instance.client;
  final repo = SupabaseProjectRepository(client);

  return _ProjectProvider(repo);
});

class _ProjectProvider {
  final ProjectRepository _repo;

  const _ProjectProvider(this._repo);

  Future<List<Project>> getAll(String userId, {int? universityId}) {
    return _repo.getAll(userId, universityId: universityId);
  }

  Future<Project?> getById(int id) {
    return _repo.getById(id);
  }
}
