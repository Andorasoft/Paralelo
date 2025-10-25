import 'package:paralelo/core/imports.dart';
import 'package:paralelo/features/home/models/conections_repository.dart';

final conectionsProvider = Provider((_) {
  final client = Supabase.instance.client;
  return SupabaseConectionsRepository(client);
});
