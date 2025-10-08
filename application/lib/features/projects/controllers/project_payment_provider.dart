import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:paralelo/features/projects/models/project_payment_repository.dart';
import 'package:paralelo/features/projects/models/project_payment.dart';

final projectPaymentProvider = Provider((ref) {
  final client = Supabase.instance.client;
  final repo = SupabaseProjectPaymentRepository(client);

  return _ProjectPaymentProvider(repo);
});

class _ProjectPaymentProvider {
  final ProjectPaymentRepository _repo;

  const _ProjectPaymentProvider(this._repo);

  Future<ProjectPayment?> getByProject(int projectId) {
    return _repo.getByProject(projectId);
  }
}
