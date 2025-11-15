import 'package:paralelo/core/imports.dart';
import 'package:paralelo/features/management/models/application_repository.dart';

final applicationProvider = Provider<ApplicationRepository>((_) {
  final client = Supabase.instance.client;
  return SupabaseApplicationRepository(client);
});
