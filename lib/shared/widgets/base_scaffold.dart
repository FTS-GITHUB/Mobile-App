import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:flutter/material.dart';

//Global Menu drawer key
final GlobalKey<ScaffoldState> kNavDrawerGlobalKey = GlobalKey();

class BaseScaffold extends StatefulWidget {
  const BaseScaffold({
    Key? key,
    this.backgroundColor = DropAndGoColors.white,
    this.drawerIconColor,
    this.appBar,
    this.body,
    this.backgroundImageUrl,
    this.isEditPoi = false,
    this.extendBody= false,
  }) : super(key: key);

  final Widget? appBar;
  final Widget? body;
  final Color? backgroundColor;
  final Color? drawerIconColor;
  final String? backgroundImageUrl;
  final bool isEditPoi;
  final bool extendBody;

  @override
  State<BaseScaffold> createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      extendBodyBehindAppBar: widget.extendBody,
      appBar: widget.appBar != null
          ? PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: widget.appBar!,
            )
          : null,
      // drawer: _drawer(context),
      body: Container(
        decoration:widget.backgroundImageUrl!=null? BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  widget.backgroundImageUrl!,
                ),
              fit: BoxFit.cover,
            )
        ):null,
        child: Stack(
          children: <Widget>[
            if (widget.body != null) widget.body!,
          ],
        ),
      ),
    );
  }
}
