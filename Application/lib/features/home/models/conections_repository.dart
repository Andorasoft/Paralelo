import 'package:paralelo/core/imports.dart';

abstract class ConectionsRepository {
  Future<int> getForUser(String userId);
}

class SupabaseConectionsRepository implements ConectionsRepository {
  final SupabaseClient _client;

  const SupabaseConectionsRepository(this._client);

  @override
  Future<int> getForUser(String userId) async {
    final res = await _client.functions.invoke(
      'get-recent-proposals',
      queryParameters: {'user_id': userId},
    );

    return res.status == 200 ? int.parse(res.data) : 0;
  }
}
