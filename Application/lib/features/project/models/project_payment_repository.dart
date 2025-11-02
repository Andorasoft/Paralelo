import 'package:supabase_flutter/supabase_flutter.dart';
import 'project_payment.dart';

abstract class ProjectPaymentRepository {
  Future<ProjectPayment?> getForProject(int projectId);

  Future<ProjectPayment> create({
    required double min,
    required double max,
    required String currency,
    required String type,
    required int projectId,
  });
}

class SupabaseProjectPaymentRepository implements ProjectPaymentRepository {
  final SupabaseClient _client;

  const SupabaseProjectPaymentRepository(this._client);

  @override
  Future<ProjectPayment?> getForProject(int projectId) async {
    final data = await _client
        .from('project_payment')
        .select()
        .eq('project_id', projectId)
        .maybeSingle();

    return data != null ? ProjectPayment.fromMap(data) : null;
  }

  @override
  Future<ProjectPayment> create({
    required double min,
    required double max,
    required String currency,
    required String type,
    required int projectId,
  }) async {
    final data = await _client
        .from('project_payment')
        .insert({
          'min': min,
          'max': max,
          'currency': currency,
          'type': type,
          'project_id': projectId,
        })
        .select()
        .single();

    return ProjectPayment.fromMap(data);
  }
}
