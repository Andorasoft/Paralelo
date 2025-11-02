import 'package:paralelo/core/imports.dart';
import '../models/category_repository.dart';

final categoryProvider = Provider<CategoryRepository>((_) {
  final client = Supabase.instance.client;
  return SupabaseCategoryRepository(client);
});
