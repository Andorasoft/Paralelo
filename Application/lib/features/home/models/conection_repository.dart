import 'package:paralelo/core/imports.dart';

abstract class ConectionRepository {
  Future<int> getForUser(String userId);
}

class SupabaseConectionRepository implements ConectionRepository {
  final SupabaseClient _client;

  const SupabaseConectionRepository(this._client);

  @override
  Future<int> getForUser(String userId) async {
    final res = await _client.functions.invoke(
      'get-recent-conections',
      queryParameters: {'user_id': userId},
    );

    return res.status == 200 ? int.parse(res.data) : 0;
  }
}
