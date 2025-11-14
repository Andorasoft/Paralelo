import 'package:paralelo/core/imports.dart';
import '../models/user_subscription_repository.dart';

final userSubscriptionProvider = Provider<UserSubscriptionRepository>((_) {
  final client = Supabase.instance.client;
  return SupabaseUserSubscriptionRepository(client);
});
