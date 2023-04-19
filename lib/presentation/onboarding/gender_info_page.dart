import 'package:country/country.dart';
import 'package:dropandgouser/application/complete_profile/cubit/countries_cubit.dart';
import 'package:dropandgouser/application/onboarding/cubit/gender_cubit.dart';
import 'package:dropandgouser/application/setting/setting_bloc/setting_bloc.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/infrastructure/services/navigation_service.dart';
import 'package:dropandgouser/presentation/onboarding/widgets/gender_radio_body.dart';
import 'package:dropandgouser/presentation/onboarding/widgets/onboarding_appbar.dart';
import 'package:dropandgouser/shared/constants/assets.dart';
import 'package:dropandgouser/shared/enums/alert_type.dart';
import 'package:dropandgouser/shared/extensions/number_extensions.dart';
import 'package:dropandgouser/shared/widgets/app_button_widget.dart';
import 'package:dropandgouser/shared/widgets/button_loading.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:dropandgouser/shared/widgets/toasts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GenderInfoPage extends StatefulWidget {
  const GenderInfoPage({Key? key}) : super(key: key);

  @override
  State<GenderInfoPage> createState() => _GenderInfoPageState();
}

class _GenderInfoPageState extends State<GenderInfoPage> {
  @override
  void initState() {
    getCountries();
    super.initState();
  }
  
  getCountries(){
    for(var country in Countries.values){
      CountriesCubit.countries.add(country.isoShortName);
    }
    context.read<CountriesCubit>().onCountriesAdded();
  }
  
  @override
  Widget build(BuildContext context) {
    var genderCubit = context.read<GenderCubit>();
    return BlocBuilder<GenderSettingBloc, SettingState>(
      builder: (context, state) {
        return (state is SettingStateLoading)?
        const Scaffold(
          body: DropAndGoButtonLoading(),
        )  : (state is SettingStateLoaded)?
        Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: Hero(
              tag: 'progress',
              child: OnboardingAppbar(
                barValue: .16,
                onBack: () {
                  getIt<NavigationService>().navigateBack(context: context);
                },
              ),
            ),
          ),
          body: LayoutBuilder(builder: (context, constraints) {
            return Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              margin: EdgeInsets.only(
                left: 35.w,
                top: 20.h,
                right: 35.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StandardText.headline4(
                    context,
                    state.setting?.title??'',
                    // 'onboarding.gender_title'.tr(),
                  ),
                  10.h.verticalGap,
                  StandardText.headline6(
                    context,
                    state.setting?.subtitle??'',
                    // 'onboarding.gender_subTitle'.tr(),
                  ),
                  31.h.verticalGap,
                  GenderRadioBody(
                    data: state.setting?.data
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                        bottom: 50.h,
                      ),
                      alignment: Alignment.bottomCenter,
                      child: AppButton(
                        width: constraints.maxWidth,
                        text: 'onboarding.continue'.tr(),
                        isPrefixIcon: false,
                        icon: SvgPicture.asset(
                          DropAndGoIcons.arrowForward,
                        ),
                        onPressed: () {
                          if(genderCubit.state.value!=null){
                            getIt<NavigationService>().pushNamed(
                              context: context,
                              uri: NavigationService.onboardingAgeRouteUri,
                            );
                          }else{
                            getIt<Toasts>().showToast(
                              context,
                              type: AlertType.Error,
                              title: "Error",
                              description: "Please select gender and continue",
                            );
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
        ):(state is SettingStateError)?
        Scaffold(
          body: Center(
            child: StandardText.headline6(context, state.message),
          ),
        ):const SizedBox.shrink();
      }
    );
  }
}
