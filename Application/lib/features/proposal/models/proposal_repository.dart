import 'package:supabase_flutter/supabase_flutter.dart';
import './proposal.dart';

abstract class ProposalRepository {
  Future<bool> applied(int projectId);

  Future<Proposal?> getById(int id, {required bool includeRelations});

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
  Future<bool> applied(int projectId) async {
    final data = await _client
        .from('proposal')
        .select('id')
        .eq('project_id', projectId)
        .limit(1)
        .maybeSingle();

    return data != null;
  }

  @override
  Future<Proposal?> getById(int id, {required bool includeRelations}) async {
    final data = await _client
        .from('proposal')
        .select(includeRelations ? '*, project(*)' : '*')
        .eq('id', id)
        .maybeSingle();

    return data != null ? Proposal.fromMap(data) : null;
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

    return Proposal.fromMap(data);
  }
}
