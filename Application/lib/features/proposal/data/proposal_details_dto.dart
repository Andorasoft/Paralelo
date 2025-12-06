import 'package:paralelo/features/chat/exports.dart';
import 'package:paralelo/features/proposal/exports.dart';

class ProposalDetailsDto {
  final Proposal proposal;
  final ChatRoom chatRoom;

  const ProposalDetailsDto({required this.proposal, required this.chatRoom});
}
