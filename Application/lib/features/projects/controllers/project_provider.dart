import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:paralelo/features/projects/models/project_repository.dart';
import 'package:paralelo/features/projects/models/project.dart';

final projectProvider = Provider((ref) {
  final client = Supabase.instance.client;
  final repo = SupabaseProjectRepository(client);

  return ProjectProvider(repo);
});

class ProjectProvider {
  final ProjectRepository _repo;

  const ProjectProvider(this._repo);

  Future<List<Project>> getAll(String userId, {bool includeRelations = false}) {
    return _repo.getAll(userId, includeRelations: includeRelations);
  }

  Future<List<Project>> getForUser(
    String userId, {
    bool includeRelations = false,
  }) {
    return _repo.getForUser(userId, includeRelations: includeRelations);
  }

  Future<Project?> getById(int id, {bool includeRelations = false}) {
    return _repo.getById(id, includeRelations: includeRelations);
  }
}
