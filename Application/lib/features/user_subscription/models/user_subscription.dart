import 'package:paralelo/core/imports.dart';

class UserSubscription {
  final String id;
  final DateTime createdAt;
  final String platform;
  final Timestamp? expiryTime;
  final String purchaseToken;
  final String status;
  final bool autoRenewing;
  final String productId;
  final String userId;
  final String planId;

  const UserSubscription({
    required this.id,
    required this.createdAt,
    required this.platform,
    this.expiryTime,
    required this.purchaseToken,
    required this.status,
    required this.autoRenewing,
    required this.productId,
    required this.userId,
    required this.planId,
  });

  factory UserSubscription.fromMap(Map<String, dynamic> map) {
    return UserSubscription(
      id: map['id'],
      createdAt: DateTime.parse(map['created_at']),
      platform: map['platform'],
      expiryTime: map['expiry_time'],
      purchaseToken: map['purchase_token'],
      status: map['status'],
      autoRenewing: map['auto_renewing'],
      productId: map['product_id'],
      userId: map['user_id'],
      planId: map['plan_id'],
    );
  }
}
