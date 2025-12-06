import 'package:supabase_flutter/supabase_flutter.dart';
import 'project_payment.dart';

abstract class ProjectPaymentRepository {
  Future<ProjectPayment?> getById(String id);

  Future<ProjectPayment?> getForProject(String projectId);

  Future<ProjectPayment> create({
    required double min,
    required double max,
    required String currency,
    required String type,
    required String projectId,
  });

  Future<ProjectPayment?> update(
    String id, {
    double? min,
    double? max,
    String? currency,
    String? type,
  });
}

class SupabaseProjectPaymentRepository implements ProjectPaymentRepository {
  final SupabaseClient _client;

  const SupabaseProjectPaymentRepository(this._client);

  @override
  Future<ProjectPayment?> getById(String id) async {
    final data = await _client
        .from('project_payment')
        .select()
        .eq('id', id)
        .maybeSingle();

    return data != null ? ProjectPayment.fromMap(data) : null;
  }

  @override
  Future<ProjectPayment?> getForProject(String projectId) async {
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
    required String projectId,
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

  @override
  Future<ProjectPayment?> update(
    String id, {
    double? min,
    double? max,
    String? currency,
    String? type,
  }) async {
    final updates = <String, dynamic>{};

    if (min != null) {
      updates['min'] = min;
    }
    if (max != null) {
      updates['max'] = max;
    }
    if (currency != null) {
      updates['currency'] = currency;
    }
    if (type != null) {
      updates['type'] = type;
    }

    if (updates.isEmpty) return await getById(id);

    final data = await _client
        .from('project_payment')
        .update(updates)
        .eq('id', id)
        .select()
        .maybeSingle();

    return data != null ? ProjectPayment.fromMap(data) : null;
  }
}
