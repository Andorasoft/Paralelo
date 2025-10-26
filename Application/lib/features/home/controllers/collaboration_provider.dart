import 'package:paralelo/core/imports.dart';
import 'package:paralelo/features/home/models/collaboration_repository.dart';

final collaborationProvider = Provider((_) {
  final client = Supabase.instance.client;
  return SupabaseCollaborationRepository(client);
});
