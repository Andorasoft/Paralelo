import 'package:paralelo/core/imports.dart';
import 'package:paralelo/features/proposal/models/proposal_repository.dart';

final proposalProvider = Provider<ProposalRepository>((ref) {
  final client = Supabase.instance.client;
  return SupabaseProposalRepository(client);
});
