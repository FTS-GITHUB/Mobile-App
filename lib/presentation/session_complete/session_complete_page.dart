import 'package:dropandgouser/application/session/session_rating_cubit/session_rating_cubit.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/infrastructure/services/navigation_service.dart';
import 'package:dropandgouser/presentation/session_complete/widgets/complete_tick.dart';
import 'package:dropandgouser/shared/constants/assets.dart';
import 'package:dropandgouser/shared/extensions/media_query.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/packages/rating_bar.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/constants/global.dart';

class SessionCompletePage extends StatelessWidget {
  const SessionCompletePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DropAndGoColors.primary,
      body: SizedBox(
        height: context.height,
        width: context.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CompleteTick(),
            48.verticalSpace,
            StandardText.headline4(
              context,
              'Congratulations !',
              fontSize: 30,
              color: DropAndGoColors.white,
            ),
            11.verticalSpace,
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 60,
              ),
              child: StandardText.headline6(
                context,
                'You are on your way to retraining your brain!',
                color: DropAndGoColors.white,
                align: TextAlign.center,
              ),
            ),
            22.verticalSpace,
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 60,
              ),
              child: StandardText.headline5(
                context,
                'How do you feel after this session?',
                fontSize: 20,
                color: DropAndGoColors.white,
                align: TextAlign.center,
                maxLines: 2,
              ),
            ),
            20.verticalSpace,
            RatingBar(
              filledIcon: DropAndGoIcons.starBold,
              emptyIcon: DropAndGoIcons.star,
              size: 25,
              onRatingChanged: (rating) async {
                debugPrint(
                  'Rating is $rating',
                );
                final sessionId = DateTime(now.year, now.month, now.day).millisecondsSinceEpoch.toString();
                context.read<SessionRatingCubit>().uploadSessionRating(
                      rating: rating,
                      sessionId: sessionId,
                    );
                getIt<NavigationService>().navigateBack(context: context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
