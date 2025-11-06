import 'package:paralelo/core/imports.dart';
import '../models/category.dart';

abstract class CategoryRepository {
  Future<List<Category>> getAll();

  Future<Category?> getById(String id);
}

class SupabaseCategoryRepository implements CategoryRepository {
  final SupabaseClient _client;

  const SupabaseCategoryRepository(this._client);

  @override
  Future<List<Category>> getAll() async {
    final data = await _client.from('category').select();

    return data.map((it) => Category.fromMap(it)).toList();
  }

  @override
  Future<Category?> getById(String id) async {
    final data = await _client
        .from('category')
        .select()
        .eq('id', id)
        .maybeSingle();

    return data != null ? Category.fromMap(data) : null;
  }
}
