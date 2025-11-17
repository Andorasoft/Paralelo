import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/imports.dart';
import '../models/user_subscription.dart';

abstract class UserSubscriptionRepository {
  Future<UserSubscription> create({
    required String platform,
    Timestamp? expiryTime,
    required String purchaseToken,
    required String productId,
    required String userId,
    required String planId,
  });

  Future<UserSubscription?> getByToken(String token);

  Future<List<UserSubscription>> getByUser(String userId);

  Future<bool> verify({
    required String purchaseToken,
    required String productId,
    required String userId,
  });
}

class SupabaseUserSubscriptionRepository implements UserSubscriptionRepository {
  final SupabaseClient _client;

  const SupabaseUserSubscriptionRepository(this._client);

  @override
  Future<UserSubscription> create({
    required String platform,
    Timestamp? expiryTime,
    required String purchaseToken,
    required String productId,
    required String userId,
    required String planId,
  }) async {
    final data = await _client
        .from('user_subscription')
        .insert({
          'platform': platform,
          'expiry_time': expiryTime,
          'purchase_token': purchaseToken,
          'product_id': productId,
          'user_id': userId,
          'plan_id': planId,
        })
        .select()
        .single();

    return UserSubscription.fromMap(data);
  }

  @override
  Future<UserSubscription?> getByToken(String token) async {
    final data = await _client
        .from('user_subscription')
        .select()
        .eq('purchase_token', token)
        .maybeSingle();

    return data != null ? UserSubscription.fromMap(data) : null;
  }

  @override
  Future<List<UserSubscription>> getByUser(String userId) async {
    final data = await _client
        .from('user_subscription')
        .select()
        .eq('user_id', userId);

    return data.map((i) => UserSubscription.fromMap(i)).toList();
  }

  @override
  Future<bool> verify({
    required String purchaseToken,
    required String productId,
    required String userId,
  }) async {
    final res = await _client.functions.invoke(
      'verify-subscription',
      body: {
        'user_id': userId,
        'product_id': productId,
        'purchase_token': purchaseToken,
        'platform': isAndroid ? 'Android' : 'iOS',
      },
    );

    return res.status == 200;
  }
}
