import 'package:fpdart/fpdart.dart';

import '../../shared/network/domain/api_error.dart';
import 'stripe_model.dart';

abstract class IStripeSubscription {
  Future<dynamic> createCustomer();
  Future<dynamic> createPaymentMethod(
      String number, String expMonth, String expYear, String cvc);
  Future<dynamic> attachPaymentMethod(
      String paymentMethodId, String customerId);
  Future<dynamic> updateCustomer(String paymentMethodId, String customerId);
  Future<StripeModel> createSubscriptions(String customerId, String price);

  Future<Either<ApiError, StripeModel>> buySubscription(
      String number, String expMonth, String expYear, String cvc, String price);

  Future<Either<ApiError, StripeModel>> cancelSubscription(
      String subscriptionId);
}
