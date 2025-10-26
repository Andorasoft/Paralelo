import 'package:paralelo/core/imports.dart';
import 'package:paralelo/features/home/models/conection_repository.dart';

final conectionProvider = Provider((_) {
  final client = Supabase.instance.client;
  return SupabaseConectionRepository(client);
});
