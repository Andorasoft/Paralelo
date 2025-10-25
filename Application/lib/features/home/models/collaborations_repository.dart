import 'package:paralelo/core/imports.dart';

abstract class CollaborationsRepository {
  Future<int> getForUser(String userId);
}

class SupabaseCollaborationsRepository implements CollaborationsRepository {
  final SupabaseClient _client;

  const SupabaseCollaborationsRepository(this._client);

  @override
  Future<int> getForUser(String userId) async {
    final res = await _client.functions.invoke(
      'get-total-collaborations',
      queryParameters: {'user_id': userId},
    );

    return res.status == 200 ? int.parse(res.data) : 0;
  }
}
