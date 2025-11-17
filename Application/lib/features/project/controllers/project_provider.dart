import 'package:paralelo/core/imports.dart';
import '../models/project_repository.dart';

final projectProvider = Provider<ProjectRepository>((_) {
  final client = Supabase.instance.client;
  return SupabaseProjectRepository(client);
});
