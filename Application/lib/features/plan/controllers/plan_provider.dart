import 'package:paralelo/core/imports.dart';
import 'package:paralelo/features/plan/models/plan_repository.dart';

final planProvider = Provider<PlanRepository>((_) {
  final client = Supabase.instance.client;
  return SupabasePlanRepository(client);
});
