import 'package:paralelo/core/imports.dart';
import 'package:paralelo/features/report/exports.dart';

final reportProvider = Provider<ReportRepository>((_) {
  final client = Supabase.instance.client;
  return SupabaseReportRepository(client);
});
