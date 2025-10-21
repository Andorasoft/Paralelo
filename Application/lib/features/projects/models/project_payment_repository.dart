import 'package:supabase_flutter/supabase_flutter.dart';
import './project_payment.dart';

abstract class ProjectPaymentRepository {
  Future<ProjectPayment?> getByProject(int projectId);
}

class SupabaseProjectPaymentRepository implements ProjectPaymentRepository {
  final SupabaseClient _client;

  const SupabaseProjectPaymentRepository(this._client);

  @override
  Future<ProjectPayment?> getByProject(int projectId) async {
    final data = await _client
        .from('project_payment')
        .select()
        .eq('project_id', projectId)
        .maybeSingle();

    return data != null ? _fromMap(data) : null;
  }

  /// Builds a [ProjectPayment] object from a database map.
  ProjectPayment _fromMap(Map<String, dynamic> map) {
    return ProjectPayment(
      id: map['id'],
      createdAt: DateTime.parse(map['created_at']),
      min: (map['min'] as num).toDouble(),
      max: (map['max'] as num).toDouble(),
      currency: map['currency'],
      type: map['type'],
      projectId: map['project_id'],
    );
  }
}
