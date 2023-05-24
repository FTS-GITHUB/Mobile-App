import 'dart:developer';

import 'package:dropandgouser/shared/extensions/number_extensions.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:flutter/material.dart';

import '../../infrastructure/di/injectable.dart';
import '../../infrastructure/services/navigation_service.dart';
import '../../shared/widgets/standard_text.dart';
import 'widgets/account_appbar.dart';

class SubscriptionPage extends StatelessWidget {
  SubscriptionPage({super.key});

  List<Map<String, String>> subsList = [
    <String, String>{
      "name": "3 Months",
      "desc": "Save 30%",
      "price_str": "30 USD",
      "price": "30",
    },
    <String, String>{
      "name": "6 Months",
      "desc": "Save 30%",
      "price_str": "40 USD",
      "price": "20",
    },
    <String, String>{
      "name": "1 Year",
      "desc": "Save 30%",
      "price_str": "60 USD",
      "price": "60",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AccountAppBar(
          title: 'Subscription',
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: StandardText.headline6(
              context,
              "Subscription Plans",
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 3,
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(5),
                      onTap: () async {
                        getIt<NavigationService>().pushNamed(
                          context: context,
                          uri: NavigationService.stripePayment,
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 10,
                              color: DropAndGoColors.grey,
                              offset: Offset(1, 2),
                              spreadRadius: 10,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(5),
                          color: DropAndGoColors.black,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                StandardText.headline6(
                                  context,
                                  subsList[index]["name"].toString(),
                                  fontWeight: FontWeight.bold,
                                  color: DropAndGoColors.white,
                                ),
                                StandardText.headline6(
                                  context,
                                  subsList[index]["desc"].toString(),
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12,
                                  color: DropAndGoColors.white,
                                ),
                              ],
                            ),
                            StandardText.headline6(
                              context,
                              subsList[index]["price_str"].toString(),
                              fontWeight: FontWeight.bold,
                              color: DropAndGoColors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                })),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: StandardText.body2(
              context,
              "What we offer",
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          20.verticalGap,
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.check_rounded,
                        color: DropAndGoColors.green,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      StandardText.body2(context, "No Ads"),
                    ],
                  ),
                  Flexible(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.check_rounded,
                          color: DropAndGoColors.green,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Flexible(
                          child: StandardText.body2(context,
                              "Access to all premium Content and Recordings"),
                        ),
                      ],
                    ),
                  ),
                  20.verticalGap,
                  Row(
                    children: [
                      StandardText.body2(
                        context,
                        "You can",
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                      ),
                      InkWell(
                        onTap: () {
                          // repo.cancelSubscription("");
                          log("cancel");
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: StandardText.body2(
                            context,
                            "cancel",
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                            color: DropAndGoColors.blue,
                          ),
                        ),
                      ),
                      StandardText.body2(
                        context,
                        "your subscription at any time",
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
