// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:dropandgouser/application/complete_profile/cubit/countries_cubit.dart';
import 'package:dropandgouser/application/complete_profile/cubit/country_cubit.dart';
import 'package:dropandgouser/application/complete_profile/cubit/dob_date_cubit.dart';
import 'package:dropandgouser/application/setting/setting_bloc/setting_bloc.dart';
import 'package:dropandgouser/domain/signup/userdata.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/infrastructure/services/navigation_service.dart';
import 'package:dropandgouser/presentation/onboarding/widgets/onboarding_appbar.dart';
import 'package:dropandgouser/presentation/signup/widgets/drop&go_date_picker.dart';
import 'package:dropandgouser/presentation/signup/widgets/user_avatar.dart';
import 'package:dropandgouser/shared/constants/assets.dart';
import 'package:dropandgouser/shared/enums/alert_type.dart';
import 'package:dropandgouser/shared/extensions/extensions.dart';
import 'package:dropandgouser/shared/extensions/number_extensions.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/widgets/app_button_widget.dart';
import 'package:dropandgouser/shared/widgets/appl_dropdown.dart';
import 'package:dropandgouser/shared/widgets/button_loading.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:dropandgouser/shared/widgets/standard_textfield.dart';
import 'package:dropandgouser/shared/widgets/toasts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../application/complete_profile/cubit/profile_file_cubit.dart';

class CompleteProfilePage extends StatefulWidget {
  const CompleteProfilePage({Key? key}) : super(key: key);

  @override
  State<CompleteProfilePage> createState() => _CompleteProfilePageState();
}

class _CompleteProfilePageState extends State<CompleteProfilePage> {
  @override
  void dispose() {
    nameTextEditingController.dispose();
    phoneTextEditingController.dispose();
    dobTextEditingController.dispose();
    super.dispose();
  }

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController dobTextEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompleteProfileSettingBloc, SettingState>(
        builder: (context, state) {
      return (state is SettingStateLoading)
          ? const Scaffold(
              body: DropAndGoButtonLoading(),
            )
          : (state is SettingStateLoaded)
              ? Scaffold(
                  appBar: PreferredSize(
                    preferredSize: const Size.fromHeight(70),
                    child: OnboardingAppbar(
                      barValue: .84,
                      onBack: () {
                        getIt<NavigationService>().navigateBack(
                          context: context,
                        );
                      },
                    ),
                  ),
                  body: CompleteProfileForm(
                    nameTextEditingController: nameTextEditingController,
                    phoneTextEditingController: phoneTextEditingController,
                    dobTextEditingController: dobTextEditingController,
                    title: state.setting?.title,
                    subtitle: state.setting?.subtitle,
                    formKey: _formKey,
                  ),
                )
              : (state is SettingStateError)
                  ? Scaffold(
                      body: Center(
                        child: StandardText.headline6(context, state.message),
                      ),
                    )
                  : const SizedBox.shrink();
    });
  }
}

class CompleteProfileForm extends StatelessWidget {
  const CompleteProfileForm({
    Key? key,
    required this.nameTextEditingController,
    required this.phoneTextEditingController,
    required this.dobTextEditingController,
    required this.title,
    required this.subtitle,
    required this.formKey,
  }) : super(key: key);

  final TextEditingController nameTextEditingController;
  final TextEditingController phoneTextEditingController;
  final TextEditingController dobTextEditingController;
  final String? title;
  final String? subtitle;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 35.w),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StandardText.headline4(
              context,
              title ?? '',
              // 'onboarding.profile_title'.tr(),
            ),
            10.h.verticalGap,
            StandardText.headline6(
              context,
              subtitle ?? '',
              // 'onboarding.profile_subtitle'.tr(),
              align: TextAlign.justify,
            ),
            18.h.verticalGap,
            BlocBuilder<ProfileFileCubit, File?>(builder: (context, file) {
              return EditUserAvatar(
                file: file,
              );
            }),
            23.h.verticalGap,
            StandardText.headline6(
              context,
              'onboarding.name'.tr(),
              fontSize: 12,
            ),
            StandardTextField(
              controller: nameTextEditingController,
              validator: (val) {
                if (val!.isEmpty) {
                  return 'Please write your name';
                } else {
                  return null;
                }
              },
            ),
            25.h.verticalGap,
            StandardText.headline6(
              context,
              'onboarding.phone'.tr(),
              fontSize: 12,
            ),
            StandardTextField(
              controller: phoneTextEditingController,
              validator: validateMobile,
              prefixText: '+',
              keyboardType: TextInputType.phone,
              inputFormatter: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
            25.h.verticalGap,
            StandardText.headline6(
              context,
              'onboarding.dob'.tr(),
              fontSize: 12,
            ),
            ValueListenableBuilder(
              valueListenable: dobTextEditingController,
              builder: (context, dob, child) {
                return child!;
              },
              child: StandardTextField(
                readOnly: true,
                controller: dobTextEditingController,
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Please select date of birth';
                  } else {
                    return null;
                  }
                },
                onTap: () async {
                  final ThemeData theme = Theme.of(context);
                  switch (theme.platform) {
                    case TargetPlatform.android:
                    case TargetPlatform.fuchsia:
                    case TargetPlatform.linux:
                    case TargetPlatform.windows:
                      return DropAndGoDatePicker.showMaterialDatePicker(context,
                          initialDate: DateTime.now(),
                          dobTextEditingController: dobTextEditingController);
                    case TargetPlatform.iOS:
                    case TargetPlatform.macOS:
                      return DropAndGoDatePicker.showCupertinoDatePicker(
                        context,
                        initialDate: DateTime.now(),
                        dobTextEditingController: dobTextEditingController,
                      );
                  }
                },
                suffixWidget: Transform.scale(
                  scale: .6,
                  child: SvgPicture.asset(
                    DropAndGoIcons.calender,
                  ),
                ),
              ),
            ),
            25.h.verticalGap,
            StandardText.headline6(
              context,
              'onboarding.country'.tr(),
              fontSize: 12,
            ),
            // Drop
            DropAndGoDropdown<String>(
              data: CountriesCubit.countries
                  .map<DropdownMenuItem<String>>(
                    (String val) => DropdownMenuItem(
                      value: val,
                      child: Container(
                        margin: const EdgeInsets.only(left: 8),
                        width: context.width - 120,
                        child: StandardText.body2(
                          context,
                          val,
                          color: DropAndGoColors.primary,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              hintText: '',
              onChanged: context.read<CountryCubit>().onValueSelected,
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Please select country';
                } else {
                  return null;
                }
              },
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 28,
                bottom: 43,
              ),
              alignment: Alignment.bottomCenter,
              child: AppButton(
                width: context.width,
                text: 'onboarding.continue'.tr(),
                isPrefixIcon: false,
                icon: SvgPicture.asset(
                  DropAndGoIcons.arrowForward,
                ),
                onPressed: () {
                  if (context.read<ProfileFileCubit>().state == null) {
                    getIt<Toasts>().showToast(
                      context,
                      type: AlertType.Error,
                      title: 'Error',
                      description: 'Please select profile picture',
                    );
                  } else if (formKey.currentState != null &&
                      formKey.currentState!.validate()) {
                    getIt<NavigationService>().navigateToNamed(
                      context: context,
                      uri: NavigationService.createAccountRouteUri,
                      data: UserData(
                        fullName: nameTextEditingController.text,
                        phoneNo: phoneTextEditingController.text,
                        dateOfBirth: context.read<DobDateCubit>().state,
                        file: context.read<ProfileFileCubit>().state,
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  String? validateMobile(String? value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (value!=null && value.isEmpty) {
      return 'Please enter mobile number';
    }
    else if (!regExp.hasMatch(value!)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }
}
