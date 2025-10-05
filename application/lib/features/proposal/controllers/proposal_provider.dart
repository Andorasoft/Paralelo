import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:paralelo/features/proposal/models/proposal_repository.dart';
import 'package:paralelo/features/proposal/models/proposal.dart';

final proposalProvider = Provider((ref) {
  final client = Supabase.instance.client;
  final repo = SupabaseProposalRepository(client);

  return _ProposalProvider(repo);
});

class _ProposalProvider {
  final ProposalRepository _repo;

  const _ProposalProvider(this._repo);

  Future<Proposal?> getById(int id) {
    return _repo.getById(id);
  }

  Future<Proposal> create({
    required String message,
    required String mode,
    num? amount,
    num? hourlyRate,
    required String status,
    required int providerId,
    required int projectId,
  }) {
    return _repo.create(
      message: message,
      mode: mode,
      status: status,
      providerId: providerId,
      projectId: projectId,
    );
  }
}
