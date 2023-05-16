import 'dart:io';

import 'package:dropandgouser/application/complete_profile/cubit/profile_file_cubit.dart';
import 'package:dropandgouser/shared/constants/assets.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditUserAvatar extends StatelessWidget {
  const EditUserAvatar({
    Key? key,
    this.file,
    this.imageUrl,
  }) : super(key: key);

  final File? file;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    print(imageUrl);
    print(file);
    return GestureDetector(
      onTap: () {
        context.read<ProfileFileCubit>().getImage(context);
      },
      child: Center(
        child: Stack(
          children: [
            Visibility(
              visible: file!=null,
              child: CircleAvatar(
                maxRadius: 60,
                backgroundColor: DropAndGoColors.primary.withOpacity(.1),
                backgroundImage: file==null?null:FileImage(file!),
              ),
            ),
            Visibility(
              visible: imageUrl!=null,
              child: CircleAvatar(
                maxRadius: 60,
                backgroundColor: DropAndGoColors.primary.withOpacity(.1),
                backgroundImage: imageUrl==null?null: NetworkImage(imageUrl!),
              ),
            ),
            Visibility(
              visible: imageUrl==null && file==null,
              child: CircleAvatar(
                maxRadius: 60,
                backgroundColor: DropAndGoColors.primary.withOpacity(.1),
              ),
            ),
            Positioned(
              bottom: 5,
              right: 10,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: DropAndGoColors.white,
                ),
                padding: const EdgeInsets.all(2),
                child: SvgPicture.asset(
                  DropAndGoIcons.edit,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
