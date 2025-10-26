import 'package:paralelo/core/imports.dart';

abstract class CollaborationRepository {
  Future<int> getForUser(String userId);
}

class SupabaseCollaborationRepository implements CollaborationRepository {
  final SupabaseClient _client;

  const SupabaseCollaborationRepository(this._client);

  @override
  Future<int> getForUser(String userId) async {
    final res = await _client.functions.invoke(
      'get-total-collaborations',
      queryParameters: {'user_id': userId},
    );

    return res.status == 200 ? int.parse(res.data) : 0;
  }
}
