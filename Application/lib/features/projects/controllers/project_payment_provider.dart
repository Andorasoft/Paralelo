import 'package:paralelo/core/imports.dart';
import 'package:paralelo/features/projects/models/project_payment_repository.dart';

final projectPaymentProvider = Provider<ProjectPaymentRepository>((_) {
  final client = Supabase.instance.client;
  return SupabaseProjectPaymentRepository(client);
});
