import 'package:dropandgouser/application/login/login_bloc/login_bloc.dart';
import 'package:dropandgouser/shared/constants/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: (){
            context.read<LoginBloc>().add(LoginUserWithGmail());
          },
          child: Flexible(
            flex: 5,
            child: SvgPicture.asset(
              DropAndGoIcons.google,
            ),
          ),
        ),
        const Spacer(),
        Flexible(
          flex: 5,
          child: SvgPicture.asset(
            DropAndGoIcons.facebook,
          ),
        ),
      ],
    );
  }
}
