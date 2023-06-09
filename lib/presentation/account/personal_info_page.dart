import 'dart:io';

import 'package:dropandgouser/application/account/personal_info_bloc/personal_info_bloc.dart';
import 'package:dropandgouser/application/complete_profile/cubit/countries_cubit.dart';
import 'package:dropandgouser/application/complete_profile/cubit/country_cubit.dart';
import 'package:dropandgouser/application/complete_profile/cubit/dob_date_cubit.dart';
import 'package:dropandgouser/application/complete_profile/cubit/profile_file_cubit.dart';
import 'package:dropandgouser/domain/services/user_service.dart';
import 'package:dropandgouser/domain/signup/userdata.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/infrastructure/services/navigation_service.dart';
import 'package:dropandgouser/presentation/account/widgets/account_appbar.dart';
import 'package:dropandgouser/presentation/signup/widgets/drop&go_date_picker.dart';
import 'package:dropandgouser/presentation/signup/widgets/user_avatar.dart';
import 'package:dropandgouser/shared/constants/assets.dart';
import 'package:dropandgouser/shared/constants/global.dart';
import 'package:dropandgouser/shared/enums/alert_type.dart';
import 'package:dropandgouser/shared/extensions/datetime_extensions.dart';
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

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({Key? key}) : super(key: key);

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  final TextEditingController nameTextEditingController =
      TextEditingController();
  final TextEditingController phoneTextEditingController =
      TextEditingController();
  final TextEditingController dobTextEditingController =
      TextEditingController();
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late UserData? user;
  final Toasts toasts = Toasts();

  @override
  void initState() {
    assignInitialValues();
    super.initState();
  }

  @override
  void dispose() {
    nameTextEditingController.dispose();
    phoneTextEditingController.dispose();
    dobTextEditingController.dispose();
    emailTextEditingController.dispose();
    super.dispose();
  }

  assignInitialValues() {
    user = getIt<UserService>().userData;
    nameTextEditingController.text = user?.fullName ?? '';
    phoneTextEditingController.text = user?.phoneNo ?? '';
    dobTextEditingController.text = user?.dateOfBirth.toDateMonthYear() ?? '';
    emailTextEditingController.text = user?.email ?? '';
    if (user?.country != null) {
      context.read<CountryCubit>().onValueSelected(user?.country);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<ProfileFileCubit>().dispose();
        return true;
      },
      child: BlocListener<PersonalInfoBloc, PersonalInfoState>(
        listener: (context, state) {
          if (state is PersonalInfoStateLoading) {
            getIt<NavigationService>().navigateBack(context: context);
          } else if (state is PersonalInfoStateLoaded) {
            context.read<DobDateCubit>().dispose();
            context.read<CountryCubit>().dispose();
            context.read<ProfileFileCubit>().dispose();
            context.read<ProfileFileCubit>().dispose();
            toasts.showToast(
              context,
              type: AlertType.Info,
              title: 'Success',
              description: "Profile updated successfully",
            );
          }
        },
        child: Scaffold(
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: AccountAppBar(
              title: 'Personal Info',
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 35.w),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  30.verticalSpace,
                  BlocBuilder<ProfileFileCubit, File?>(
                      builder: (context, file) {
                    return (file == null)
                        ? EditUserAvatar(
                            imageUrl: user?.profilePicUrl,
                          )
                        : EditUserAvatar(
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
                  23.h.verticalGap,
                  StandardText.headline6(
                    context,
                    'create_account.email'.tr(),
                    fontSize: 12,
                  ),
                  StandardTextField(
                    controller: emailTextEditingController,
                    isEnabled: false,
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
                            return DropAndGoDatePicker.showMaterialDatePicker(
                                context,
                                initialDate:
                                    user?.dateOfBirth ?? DateTime.now(),
                                dobTextEditingController:
                                    dobTextEditingController);
                          case TargetPlatform.iOS:
                          case TargetPlatform.macOS:
                            return DropAndGoDatePicker.showCupertinoDatePicker(
                              context,
                              initialDate: user?.dateOfBirth ?? DateTime.now(),
                              dobTextEditingController:
                                  dobTextEditingController,
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
                  // BlocBuilder<CountryCubit, String?>(
                  //     builder: (context, countryName) {
                  //   return DropdownSearch<String>(
                  //     popupProps: PopupProps.dialog(
                  //       showSearchBox: true,
                  //       showSelectedItems: true,
                  //       itemBuilder: (context, item){
                  //         return Container(
                  //           color: Drop,
                  //         )
                  //       }
                  //     ),
                  //
                  //     dropdownDecoratorProps: DropDownDecoratorProps(
                  //       baseStyle: TextStyle(
                  //         fontSize: 12,
                  //         color: DropAndGoColors.primary,
                  //         overflow: TextOverflow.ellipsis,
                  //       )
                  //     ),
                  //     validator: (val) {
                  //       if (val == null || val.isEmpty) {
                  //         return 'Please select country';
                  //       } else {
                  //         return null;
                  //       }
                  //     },
                  //     items: CountriesCubit.countries,
                  //     onChanged: (value) {},
                  //     selectedItem: "Brazil",
                  //   );
                  // }),
                  BlocBuilder<CountryCubit, String?>(
                      builder: (context, countryName) {
                    return DropAndGoDropdown<String>(
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
                      value: countryName,
                      onChanged: context.read<CountryCubit>().onValueSelected,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Please select country';
                        } else {
                          return null;
                        }
                      },
                    );
                  }),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 28,
                      bottom: 43,
                    ),
                    alignment: Alignment.bottomCenter,
                    child: BlocBuilder<PersonalInfoBloc, PersonalInfoState>(
                        builder: (context, state) {
                      return (state is PersonalInfoStateLoading)
                          ? const DropAndGoButtonLoading()
                          : AppButton(
                              width: context.width,
                              text: 'login.confirm'.tr(),
                              onPressed: () {
                                if (formKey.currentState != null &&
                                    formKey.currentState!.validate()) {
                                  user = user?.copyWith(
                                    fullName: nameTextEditingController.text,
                                    phoneNo: phoneTextEditingController.text,
                                    dateOfBirth:
                                        context.read<DobDateCubit>().state,
                                    country: context.read<CountryCubit>().state,
                                  );
                                  context.read<PersonalInfoBloc>().add(
                                        UpdatePersonalInfo(
                                          userData: user!,
                                          fileImage: context
                                              .read<ProfileFileCubit>()
                                              .state,
                                        ),
                                      );
                                }
                              },
                            );
                    }),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
