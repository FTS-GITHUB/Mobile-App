// To parse this JSON data, do
//
//     final stripeModel = stripeModelFromJson(jsonString);

import 'dart:convert';

StripeModel stripeModelFromJson(String str) =>
    StripeModel.fromJson(json.decode(str));

String stripeModelToJson(StripeModel data) => json.encode(data.toJson());

class StripeModel {
  String? id;
  String? object;
  dynamic application;
  dynamic applicationFeePercent;
  AutomaticTax? automaticTax;
  int? billingCycleAnchor;
  dynamic billingThresholds;
  dynamic cancelAt;
  bool? cancelAtPeriodEnd;
  dynamic canceledAt;
  CancellationDetails? cancellationDetails;
  String? collectionMethod;
  int? created;
  String? currency;
  int? currentPeriodEnd;
  int? currentPeriodStart;
  String? customer;
  dynamic daysUntilDue;
  dynamic defaultPaymentMethod;
  dynamic defaultSource;
  List<dynamic>? defaultTaxRates;
  dynamic description;
  dynamic discount;
  dynamic endedAt;
  Items? items;
  String? latestInvoice;
  bool? livemode;
  DatumMetadata? metadata;
  dynamic nextPendingInvoiceItemInvoice;
  dynamic onBehalfOf;
  dynamic pauseCollection;
  PaymentSettings? paymentSettings;
  dynamic pendingInvoiceItemInterval;
  dynamic pendingSetupIntent;
  dynamic pendingUpdate;
  Plan? plan;
  int? quantity;
  dynamic schedule;
  int? startDate;
  String? status;
  dynamic testClock;
  dynamic transferData;
  dynamic trialEnd;
  TrialSettings? trialSettings;
  dynamic trialStart;

  StripeModel({
    this.id,
    this.object,
    this.application,
    this.applicationFeePercent,
    this.automaticTax,
    this.billingCycleAnchor,
    this.billingThresholds,
    this.cancelAt,
    this.cancelAtPeriodEnd,
    this.canceledAt,
    this.cancellationDetails,
    this.collectionMethod,
    this.created,
    this.currency,
    this.currentPeriodEnd,
    this.currentPeriodStart,
    this.customer,
    this.daysUntilDue,
    this.defaultPaymentMethod,
    this.defaultSource,
    this.defaultTaxRates,
    this.description,
    this.discount,
    this.endedAt,
    this.items,
    this.latestInvoice,
    this.livemode,
    this.metadata,
    this.nextPendingInvoiceItemInvoice,
    this.onBehalfOf,
    this.pauseCollection,
    this.paymentSettings,
    this.pendingInvoiceItemInterval,
    this.pendingSetupIntent,
    this.pendingUpdate,
    this.plan,
    this.quantity,
    this.schedule,
    this.startDate,
    this.status,
    this.testClock,
    this.transferData,
    this.trialEnd,
    this.trialSettings,
    this.trialStart,
  });

  factory StripeModel.fromJson(Map<String, dynamic> json) => StripeModel(
        id: json["id"],
        object: json["object"],
        application: json["application"],
        applicationFeePercent: json["application_fee_percent"],
        automaticTax: json["automatic_tax"] == null
            ? null
            : AutomaticTax.fromJson(json["automatic_tax"]),
        billingCycleAnchor: json["billing_cycle_anchor"],
        billingThresholds: json["billing_thresholds"],
        cancelAt: json["cancel_at"],
        cancelAtPeriodEnd: json["cancel_at_period_end"],
        canceledAt: json["canceled_at"],
        cancellationDetails: json["cancellation_details"] == null
            ? null
            : CancellationDetails.fromJson(json["cancellation_details"]),
        collectionMethod: json["collection_method"],
        created: json["created"],
        currency: json["currency"],
        currentPeriodEnd: json["current_period_end"],
        currentPeriodStart: json["current_period_start"],
        customer: json["customer"],
        daysUntilDue: json["days_until_due"],
        defaultPaymentMethod: json["default_payment_method"],
        defaultSource: json["default_source"],
        defaultTaxRates: json["default_tax_rates"] == null
            ? []
            : List<dynamic>.from(json["default_tax_rates"]!.map((x) => x)),
        description: json["description"],
        discount: json["discount"],
        endedAt: json["ended_at"],
        items: json["items"] == null ? null : Items.fromJson(json["items"]),
        latestInvoice: json["latest_invoice"],
        livemode: json["livemode"],
        metadata: json["metadata"] == null
            ? null
            : DatumMetadata.fromJson(json["metadata"]),
        nextPendingInvoiceItemInvoice:
            json["next_pending_invoice_item_invoice"],
        onBehalfOf: json["on_behalf_of"],
        pauseCollection: json["pause_collection"],
        paymentSettings: json["payment_settings"] == null
            ? null
            : PaymentSettings.fromJson(json["payment_settings"]),
        pendingInvoiceItemInterval: json["pending_invoice_item_interval"],
        pendingSetupIntent: json["pending_setup_intent"],
        pendingUpdate: json["pending_update"],
        plan: json["plan"] == null ? null : Plan.fromJson(json["plan"]),
        quantity: json["quantity"],
        schedule: json["schedule"],
        startDate: json["start_date"],
        status: json["status"],
        testClock: json["test_clock"],
        transferData: json["transfer_data"],
        trialEnd: json["trial_end"],
        trialSettings: json["trial_settings"] == null
            ? null
            : TrialSettings.fromJson(json["trial_settings"]),
        trialStart: json["trial_start"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "object": object,
        "application": application,
        "application_fee_percent": applicationFeePercent,
        "automatic_tax": automaticTax?.toJson(),
        "billing_cycle_anchor": billingCycleAnchor,
        "billing_thresholds": billingThresholds,
        "cancel_at": cancelAt,
        "cancel_at_period_end": cancelAtPeriodEnd,
        "canceled_at": canceledAt,
        "cancellation_details": cancellationDetails?.toJson(),
        "collection_method": collectionMethod,
        "created": created,
        "currency": currency,
        "current_period_end": currentPeriodEnd,
        "current_period_start": currentPeriodStart,
        "customer": customer,
        "days_until_due": daysUntilDue,
        "default_payment_method": defaultPaymentMethod,
        "default_source": defaultSource,
        "default_tax_rates": defaultTaxRates == null
            ? []
            : List<dynamic>.from(defaultTaxRates!.map((x) => x)),
        "description": description,
        "discount": discount,
        "ended_at": endedAt,
        "items": items?.toJson(),
        "latest_invoice": latestInvoice,
        "livemode": livemode,
        "metadata": metadata?.toJson(),
        "next_pending_invoice_item_invoice": nextPendingInvoiceItemInvoice,
        "on_behalf_of": onBehalfOf,
        "pause_collection": pauseCollection,
        "payment_settings": paymentSettings?.toJson(),
        "pending_invoice_item_interval": pendingInvoiceItemInterval,
        "pending_setup_intent": pendingSetupIntent,
        "pending_update": pendingUpdate,
        "plan": plan?.toJson(),
        "quantity": quantity,
        "schedule": schedule,
        "start_date": startDate,
        "status": status,
        "test_clock": testClock,
        "transfer_data": transferData,
        "trial_end": trialEnd,
        "trial_settings": trialSettings?.toJson(),
        "trial_start": trialStart,
      };
}

class AutomaticTax {
  bool? enabled;

  AutomaticTax({
    this.enabled,
  });

  factory AutomaticTax.fromJson(Map<String, dynamic> json) => AutomaticTax(
        enabled: json["enabled"],
      );

  Map<String, dynamic> toJson() => {
        "enabled": enabled,
      };
}

class CancellationDetails {
  dynamic comment;
  dynamic feedback;
  dynamic reason;

  CancellationDetails({
    this.comment,
    this.feedback,
    this.reason,
  });

  factory CancellationDetails.fromJson(Map<String, dynamic> json) =>
      CancellationDetails(
        comment: json["comment"],
        feedback: json["feedback"],
        reason: json["reason"],
      );

  Map<String, dynamic> toJson() => {
        "comment": comment,
        "feedback": feedback,
        "reason": reason,
      };
}

class Items {
  String? object;
  List<Datum>? data;
  bool? hasMore;
  int? totalCount;
  String? url;

  Items({
    this.object,
    this.data,
    this.hasMore,
    this.totalCount,
    this.url,
  });

  factory Items.fromJson(Map<String, dynamic> json) => Items(
        object: json["object"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        hasMore: json["has_more"],
        totalCount: json["total_count"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "object": object,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "has_more": hasMore,
        "total_count": totalCount,
        "url": url,
      };
}

class Datum {
  String? id;
  String? object;
  dynamic billingThresholds;
  int? created;
  DatumMetadata? metadata;
  Plan? plan;
  Price? price;
  int? quantity;
  String? subscription;
  List<dynamic>? taxRates;

  Datum({
    this.id,
    this.object,
    this.billingThresholds,
    this.created,
    this.metadata,
    this.plan,
    this.price,
    this.quantity,
    this.subscription,
    this.taxRates,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        object: json["object"],
        billingThresholds: json["billing_thresholds"],
        created: json["created"],
        metadata: json["metadata"] == null
            ? null
            : DatumMetadata.fromJson(json["metadata"]),
        plan: json["plan"] == null ? null : Plan.fromJson(json["plan"]),
        price: json["price"] == null ? null : Price.fromJson(json["price"]),
        quantity: json["quantity"],
        subscription: json["subscription"],
        taxRates: json["tax_rates"] == null
            ? []
            : List<dynamic>.from(json["tax_rates"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "object": object,
        "billing_thresholds": billingThresholds,
        "created": created,
        "metadata": metadata?.toJson(),
        "plan": plan?.toJson(),
        "price": price?.toJson(),
        "quantity": quantity,
        "subscription": subscription,
        "tax_rates":
            taxRates == null ? [] : List<dynamic>.from(taxRates!.map((x) => x)),
      };
}

class DatumMetadata {
  DatumMetadata();

  factory DatumMetadata.fromJson(Map<String, dynamic> json) => DatumMetadata();

  Map<String, dynamic> toJson() => {};
}

class Plan {
  String? id;
  String? object;
  bool? active;
  dynamic aggregateUsage;
  int? amount;
  String? amountDecimal;
  String? billingScheme;
  int? created;
  String? currency;
  String? interval;
  int? intervalCount;
  bool? livemode;
  PlanMetadata? metadata;
  dynamic nickname;
  String? product;
  dynamic tiersMode;
  dynamic transformUsage;
  int? trialPeriodDays;
  String? usageType;

  Plan({
    this.id,
    this.object,
    this.active,
    this.aggregateUsage,
    this.amount,
    this.amountDecimal,
    this.billingScheme,
    this.created,
    this.currency,
    this.interval,
    this.intervalCount,
    this.livemode,
    this.metadata,
    this.nickname,
    this.product,
    this.tiersMode,
    this.transformUsage,
    this.trialPeriodDays,
    this.usageType,
  });

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
        id: json["id"],
        object: json["object"],
        active: json["active"],
        aggregateUsage: json["aggregate_usage"],
        amount: json["amount"],
        amountDecimal: json["amount_decimal"],
        billingScheme: json["billing_scheme"],
        created: json["created"],
        currency: json["currency"],
        interval: json["interval"],
        intervalCount: json["interval_count"],
        livemode: json["livemode"],
        metadata: json["metadata"] == null
            ? null
            : PlanMetadata.fromJson(json["metadata"]),
        nickname: json["nickname"],
        product: json["product"],
        tiersMode: json["tiers_mode"],
        transformUsage: json["transform_usage"],
        trialPeriodDays: json["trial_period_days"],
        usageType: json["usage_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "object": object,
        "active": active,
        "aggregate_usage": aggregateUsage,
        "amount": amount,
        "amount_decimal": amountDecimal,
        "billing_scheme": billingScheme,
        "created": created,
        "currency": currency,
        "interval": interval,
        "interval_count": intervalCount,
        "livemode": livemode,
        "metadata": metadata?.toJson(),
        "nickname": nickname,
        "product": product,
        "tiers_mode": tiersMode,
        "transform_usage": transformUsage,
        "trial_period_days": trialPeriodDays,
        "usage_type": usageType,
      };
}

class PlanMetadata {
  String? charset;
  String? content;

  PlanMetadata({
    this.charset,
    this.content,
  });

  factory PlanMetadata.fromJson(Map<String, dynamic> json) => PlanMetadata(
        charset: json["charset"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "charset": charset,
        "content": content,
      };
}

class Price {
  String? id;
  String? object;
  bool? active;
  String? billingScheme;
  int? created;
  String? currency;
  dynamic customUnitAmount;
  bool? livemode;
  dynamic lookupKey;
  PlanMetadata? metadata;
  dynamic nickname;
  String? product;
  Recurring? recurring;
  String? taxBehavior;
  dynamic tiersMode;
  dynamic transformQuantity;
  String? type;
  int? unitAmount;
  String? unitAmountDecimal;

  Price({
    this.id,
    this.object,
    this.active,
    this.billingScheme,
    this.created,
    this.currency,
    this.customUnitAmount,
    this.livemode,
    this.lookupKey,
    this.metadata,
    this.nickname,
    this.product,
    this.recurring,
    this.taxBehavior,
    this.tiersMode,
    this.transformQuantity,
    this.type,
    this.unitAmount,
    this.unitAmountDecimal,
  });

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        id: json["id"],
        object: json["object"],
        active: json["active"],
        billingScheme: json["billing_scheme"],
        created: json["created"],
        currency: json["currency"],
        customUnitAmount: json["custom_unit_amount"],
        livemode: json["livemode"],
        lookupKey: json["lookup_key"],
        metadata: json["metadata"] == null
            ? null
            : PlanMetadata.fromJson(json["metadata"]),
        nickname: json["nickname"],
        product: json["product"],
        recurring: json["recurring"] == null
            ? null
            : Recurring.fromJson(json["recurring"]),
        taxBehavior: json["tax_behavior"],
        tiersMode: json["tiers_mode"],
        transformQuantity: json["transform_quantity"],
        type: json["type"],
        unitAmount: json["unit_amount"],
        unitAmountDecimal: json["unit_amount_decimal"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "object": object,
        "active": active,
        "billing_scheme": billingScheme,
        "created": created,
        "currency": currency,
        "custom_unit_amount": customUnitAmount,
        "livemode": livemode,
        "lookup_key": lookupKey,
        "metadata": metadata?.toJson(),
        "nickname": nickname,
        "product": product,
        "recurring": recurring?.toJson(),
        "tax_behavior": taxBehavior,
        "tiers_mode": tiersMode,
        "transform_quantity": transformQuantity,
        "type": type,
        "unit_amount": unitAmount,
        "unit_amount_decimal": unitAmountDecimal,
      };
}

class Recurring {
  dynamic aggregateUsage;
  String? interval;
  int? intervalCount;
  int? trialPeriodDays;
  String? usageType;

  Recurring({
    this.aggregateUsage,
    this.interval,
    this.intervalCount,
    this.trialPeriodDays,
    this.usageType,
  });

  factory Recurring.fromJson(Map<String, dynamic> json) => Recurring(
        aggregateUsage: json["aggregate_usage"],
        interval: json["interval"],
        intervalCount: json["interval_count"],
        trialPeriodDays: json["trial_period_days"],
        usageType: json["usage_type"],
      );

  Map<String, dynamic> toJson() => {
        "aggregate_usage": aggregateUsage,
        "interval": interval,
        "interval_count": intervalCount,
        "trial_period_days": trialPeriodDays,
        "usage_type": usageType,
      };
}

class PaymentSettings {
  dynamic paymentMethodOptions;
  dynamic paymentMethodTypes;
  String? saveDefaultPaymentMethod;

  PaymentSettings({
    this.paymentMethodOptions,
    this.paymentMethodTypes,
    this.saveDefaultPaymentMethod,
  });

  factory PaymentSettings.fromJson(Map<String, dynamic> json) =>
      PaymentSettings(
        paymentMethodOptions: json["payment_method_options"],
        paymentMethodTypes: json["payment_method_types"],
        saveDefaultPaymentMethod: json["save_default_payment_method"],
      );

  Map<String, dynamic> toJson() => {
        "payment_method_options": paymentMethodOptions,
        "payment_method_types": paymentMethodTypes,
        "save_default_payment_method": saveDefaultPaymentMethod,
      };
}

class TrialSettings {
  EndBehavior? endBehavior;

  TrialSettings({
    this.endBehavior,
  });

  factory TrialSettings.fromJson(Map<String, dynamic> json) => TrialSettings(
        endBehavior: json["end_behavior"] == null
            ? null
            : EndBehavior.fromJson(json["end_behavior"]),
      );

  Map<String, dynamic> toJson() => {
        "end_behavior": endBehavior?.toJson(),
      };
}

class EndBehavior {
  String? missingPaymentMethod;

  EndBehavior({
    this.missingPaymentMethod,
  });

  factory EndBehavior.fromJson(Map<String, dynamic> json) => EndBehavior(
        missingPaymentMethod: json["missing_payment_method"],
      );

  Map<String, dynamic> toJson() => {
        "missing_payment_method": missingPaymentMethod,
      };
}
