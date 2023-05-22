import 'package:dropandgouser/shared/network/domain/api_error.dart';

import 'package:fpdart/src/either.dart';

import '../../domain/subscription/i_stripe_subscription.dart';
import '../../domain/subscription/stripe_model.dart';
import 'subscription_data_source.dart';

class SubscriptionRepository extends IStripeSubscription {
  SubscriptionRepository({required this.dataSource});

  final SubscriptionDataSource dataSource;

  @override
  Future<dynamic> attachPaymentMethod(
      String paymentMethodId, String customerId) async {
    await dataSource.attachPaymentMethod(paymentMethodId, customerId);
  }

  @override
  Future<dynamic> createCustomer() async {
    final response = await dataSource.createCustomer();
    return response['id'];
  }

  @override
  Future<dynamic> createPaymentMethod(
      String number, String expMonth, String expYear, String cvc) async {
    final response = await dataSource.createPaymentMethod(
        number: number, expMonth: expMonth, expYear: expYear, cvc: cvc);
    return response['id'];
  }

  @override
  Future<StripeModel> createSubscriptions(
      String customerId, String price) async {
    return await dataSource.createSubscriptions(customerId, price);
  }

  @override
  Future<dynamic> updateCustomer(
      String paymentMethodId, String customerId) async {
    await dataSource.updateCustomer(paymentMethodId, customerId);
  }

  @override
  Future<Either<ApiError, StripeModel>> buySubscription(String number,
      String expMonth, String expYear, String cvc, String price) async {
    try {
      final _customer = await createCustomer();
      final _paymentMethod =
          await createPaymentMethod(number, expMonth, expYear, cvc);
      await attachPaymentMethod(_paymentMethod, _customer);
      await updateCustomer(_paymentMethod, _customer);
      final response = await createSubscriptions(_customer, price);

      return right(response ?? StripeModel());
    } catch (e) {
      return left(
        ApiError(code: "500", message: "Something went wrong"),
      );
    }
  }

  @override
  Future<Either<ApiError, StripeModel>> cancelSubscription(
      String subscriptionId) async {
    try {
      final response = await dataSource.cancelSubscription(subscriptionId);
      return right(response ?? StripeModel());
    } catch (e) {
      return left(
        ApiError(code: "500", message: "Something went wrong"),
      );
    }
  }
}
