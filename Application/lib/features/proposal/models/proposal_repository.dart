import 'package:paralelo/core/imports.dart';
import '../models/proposal.dart';

abstract class ProposalRepository {
  Future<Proposal?> getById(int id);

  Future<List<Proposal>> getByIds(List<int> ids);

  Future<Proposal> create({
    required String message,
    required String mode,
    num? amount,
    num? hourlyRate,
    required num estimatedDurationValue,
    required String estimatedDurationUnit,
    required String providerId,
    required int projectId,
  });

  Future<Proposal?> update(
    int id, {
    num? amount,
    num? hourlyRate,
    num? estimatedDurationValue,
    String? estimatedDurationUnit,
  });

  Future<bool> applied({required int projectId, required String providerId});

  Future<bool> accept(int id);
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

    return data != null ? Proposal.fromMap(data) : null;
  }

  @override
  Future<List<Proposal>> getByIds(List<int> ids) async {
    final data = await _client
        .from('proposal')
        .select()
        .filter('id', 'in', '(${ids.join(',')})');

    return data.map((i) => Proposal.fromMap(i)).toList();
  }

  @override
  Future<Proposal> create({
    required String message,
    required String mode,
    num? amount,
    num? hourlyRate,
    required num estimatedDurationValue,
    required String estimatedDurationUnit,
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
          'estimated_duration_value': estimatedDurationValue,
          'estimated_duration_unit': estimatedDurationUnit,
          'provider_id': providerId,
          'project_id': projectId,
        })
        .select()
        .single();

    return Proposal.fromMap(data);
  }

  @override
  Future<Proposal?> update(
    int id, {
    num? amount,
    num? hourlyRate,
    num? estimatedDurationValue,
    String? estimatedDurationUnit,
  }) async {
    final updates = <String, dynamic>{};

    if (amount != null) {
      updates['amount'] = amount;
    }
    if (hourlyRate != null) {
      updates['hourly_rate'] = hourlyRate;
    }
    if (estimatedDurationValue != null) {
      updates['estimated_duration_value'] = estimatedDurationValue;
    }
    if (estimatedDurationUnit != null) {
      updates['estimated_duration_unit'] = estimatedDurationUnit;
    }

    if (updates.isEmpty) return await getById(id);

    final data = await _client
        .from('proposal')
        .update(updates)
        .eq('id', id)
        .select()
        .maybeSingle();

    return data != null ? Proposal.fromMap(data) : null;
  }

  @override
  Future<bool> applied({
    required int projectId,
    required String providerId,
  }) async {
    final data = await _client
        .from('proposal')
        .select('id')
        .eq('project_id', projectId)
        .eq('provider_id', providerId)
        .limit(1)
        .maybeSingle();

    return data != null;
  }

  @override
  Future<bool> accept(int id) async {
    final res = await _client.functions.invoke(
      'accept-proposal',
      queryParameters: {'proposal_id': '$id'},
    );

    return res.status == 200;
  }
}
