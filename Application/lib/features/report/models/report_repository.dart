import 'package:paralelo/core/imports.dart';
import '../models/report.dart';

abstract class ReportRepository {
  Future<Report> create({
    required String reason,
    required String reporterId,
    String? reportedId,
    String? projectId,
  });
}

class SupabaseReportRepository implements ReportRepository {
  final SupabaseClient _client;

  const SupabaseReportRepository(this._client);

  @override
  Future<Report> create({
    required String reason,
    required String reporterId,
    String? reportedId,
    String? projectId,
  }) async {
    assert(!(reportedId == null && projectId == null), '');

    final data = await _client
        .from('report')
        .insert({
          'reason': reason,
          'reporter_id': reporterId,
          'reported_id': reportedId,
          'project_id': projectId,
        })
        .select()
        .single();

    return Report.fromMap(data);
  }
}
