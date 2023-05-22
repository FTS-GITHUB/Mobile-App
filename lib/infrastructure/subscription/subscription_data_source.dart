import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SubscriptionDataSource {
  static Map<String, String> headers = {
    // 'Authorization': 'Bearer ${dotenv.env['STRIPE_KEY']}',
    'Authorization': 'Bearer sk_test_4eC39HqLyjWDarjtT1zdp7dc',
    'Content-Type': 'application/x-www-form-urlencoded'
  };
  final client = http.Client();

  static String base_url = 'https://api.stripe.com/v1';
  Future<dynamic> createCustomer() async {
    var response = await client.post(
      Uri.parse("$base_url/customers"),
      headers: headers,
      body: {'description': 'new customer'},
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw 'Failed to register as a customer.';
    }
  }

  Future<dynamic> createPaymentMethod(
      {required String number,
      required String expMonth,
      required String expYear,
      required String cvc}) async {
    final String url = '$base_url/payment_methods';
    var response = await client.post(
      Uri.parse(url),
      headers: headers,
      body: {
        'type': 'card',
        'card[number]': '$number',
        'card[exp_month]': '$expMonth',
        'card[exp_year]': '$expYear',
        'card[cvc]': '$cvc',
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(json.decode(response.body));
      throw 'Failed to create PaymentMethod.';
    }
  }

  Future<dynamic> attachPaymentMethod(
      String paymentMethodId, String customerId) async {
    final String url = '$base_url/payment_methods/$paymentMethodId/attach';
    var response = await client.post(
      Uri.parse(url),
      headers: headers,
      body: {
        'customer': customerId,
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(json.decode(response.body));
      throw 'Failed to attach PaymentMethod.';
    }
  }

  Future<dynamic> updateCustomer(
      String paymentMethodId, String customerId) async {
    final String url = '$base_url/customers/$customerId';

    var response = await client.post(
      Uri.parse(url),
      headers: headers,
      body: {
        'invoice_settings[default_payment_method]': paymentMethodId,
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(json.decode(response.body));
      throw 'Failed to update Customer.';
    }
  }

  Future<dynamic> createSubscriptions(String customerId, String price) async {
    final String url = '$base_url/subscriptions';

    Map<String, dynamic> body = {
      'customer': customerId,
      'items[0][price]': price,
    };

    var response =
        await client.post(Uri.parse(url), headers: headers, body: body);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(json.decode(response.body));
      throw 'Failed to register as a subscriber.';
    }
  }

  Future<dynamic> cancelSubscription(String subscriptionId) async {
    final String url = '$base_url/subscriptions/$subscriptionId';

    var response = await client.delete(
      Uri.parse(url),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(json.decode(response.body));
      throw 'Failed to register as a subscriber.';
    }
  }
}
