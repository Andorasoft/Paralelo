import 'package:paralelo/core/imports.dart';
import 'package:paralelo/features/home/models/collaborations_repository.dart';

final collaborationsProvider = Provider((_) {
  final client = Supabase.instance.client;
  return SupabaseCollaborationsRepository(client);
});
