import 'package:supabase_flutter/supabase_flutter.dart';
import './proposal.dart';

abstract class ProposalRepository {
  Future<Proposal?> getById(int id);
  Future<Proposal> create({
    required String message,
    required String mode,
    num? amount,
    num? hourlyRate,
    required String status,
    required String providerId,
    required int projectId,
  });
}

class SupabaseProposalRepository implements ProposalRepository {
  final SupabaseClient _client;

  const SupabaseProposalRepository(this._client);

  @override
  Future<Proposal?> getById(int id) async {
    final data = await _client
        .from('proposal')
        .select()
        .eq('id', id)
        .maybeSingle();

    return data != null ? _fromMap(data) : null;
  }

  @override
  Future<Proposal> create({
    required String message,
    required String mode,
    num? amount,
    num? hourlyRate,
    required String status,
    required String providerId,
    required int projectId,
  }) async {
    final data = await _client
        .from('proposal')
        .insert({
          'message': message,
          'mode': mode,
          'amount': amount,
          'hourly_rate': hourlyRate,
          'status': status,
          'provider_id': providerId,
          'project_id': projectId,
        })
        .select()
        .single();

    return _fromMap(data);
  }

  /// Builds a [Proposal] object from a database map.
  Proposal _fromMap(Map<String, dynamic> map) {
    return Proposal(
      id: map['id'],
      createdAt: DateTime.parse(map['created_at']),
      message: map['message'],
      mode: map['mode'],
      amount: map['amount'],
      hourlyRate: map['hourly_rate'],
      status: map['status'],
      providerId: map['provider_id'],
      projectId: map['project_id'],
    );
  }
}
