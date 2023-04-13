import 'dart:ui';

import 'package:dropandgouser/shared/extensions/number_extensions.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:flutter/material.dart';

class AppDialog extends StatelessWidget {
  const AppDialog({
    Key? key,
    this.children,
    // if children is not null ==> no more arguement is needed
    this.title,
    this.description,
    this.actions,
    this.header,
  }) : super(key: key);
  final List<Widget>? children;
  final String? title;
  final String? description;
  final List<Widget>? actions;
  final Widget? header;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: Dialog(
        child: Padding(
          padding: const EdgeInsets.all(35),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: children ??
                [
                  if(header!=null) header!,
                  if(header!=null) 26.verticalGap,
                  if (title != null)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: StandardText.headline5(
                        context,
                        title!,
                        fontSize: 20,
                      ),
                    ),
                  Visibility(
                    visible: description!=null,
                    child: 9.verticalGap,
                  ),
                  if (description != null)
                    StandardText.body2(
                      context,
                      description!,
                      align: TextAlign.justify,
                    ),
                  Visibility(
                    visible: actions!=null,
                    child: 30.verticalGap,
                  ),
                  if (actions != null) Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: actions!,
                  ),
                ],
          ),
        ),
      ),
    );
  }
}
