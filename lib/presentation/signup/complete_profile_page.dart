// ignore_for_file: must_be_immutable


import 'package:dropandgouser/application/setting/setting_bloc/setting_bloc.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/infrastructure/services/navigation_service.dart';
import 'package:dropandgouser/presentation/onboarding/widgets/onboarding_appbar.dart';
import 'package:dropandgouser/presentation/signup/complete_profile_form.dart';
import 'package:dropandgouser/shared/widgets/button_loading.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


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
