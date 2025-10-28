import 'package:paralelo/core/imports.dart';
import 'package:paralelo/features/plan/models/plan.dart';

abstract class PlanRepository {
  Future<List<Plan>> getAll();
}

class SupabasePlanRepository implements PlanRepository {
  final SupabaseClient _client;

  const SupabasePlanRepository(this._client);

  @override
  Future<List<Plan>> getAll() async {
    final data = await _client.from('plan').select();

    return data.map((i) => Plan.fromMap(i)).toList();
  }
}
