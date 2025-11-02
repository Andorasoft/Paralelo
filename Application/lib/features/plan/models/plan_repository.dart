import 'package:paralelo/core/imports.dart';
import 'package:paralelo/features/plan/models/plan.dart';

abstract class PlanRepository {
  Future<List<Plan>> getAll();

  Future<Plan?> getForUser(String userId);
}

class SupabasePlanRepository implements PlanRepository {
  final SupabaseClient _client;

  const SupabasePlanRepository(this._client);

  @override
  Future<List<Plan>> getAll() async {
    final data = await _client.from('plan').select();

    return data.map((i) => Plan.fromMap(i)).toList();
  }

  @override
  Future<Plan?> getForUser(String userId) async {
    final data = await _client
        .from('user')
        .select('plan(*)')
        .eq('id', userId)
        .maybeSingle();

    return data != null ? Plan.fromMap(data['plan']) : null;
  }
}
