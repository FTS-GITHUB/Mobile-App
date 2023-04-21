import 'package:dropandgouser/application/search/cubit/is_seearch_active.dart';
import 'package:dropandgouser/shared/constants/assets.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:dropandgouser/shared/widgets/standard_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final FocusNode _focus = FocusNode();

  final searchTextEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
  }

  void _onFocusChange() {
    // if(_focus.hasFocus){
    //   context.read<IsSearchActive>().activeSearch();
    // }
    debugPrint("Focus: ${_focus.hasFocus.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          leadingWidth: 36.w,
          title: StandardTextField(
            focusNode: _focus,
            controller: searchTextEditingController,
            textInputAction: TextInputAction.search,
            labelStyle: const TextStyle(
              color: DropAndGoColors.white,
            ),
            onTap: () {
              context.read<IsSearchActive>().activeSearch();
            },
            onFieldSubmitted: (_) {
              context.read<IsSearchActive>().unActiveSearch();
            },
            cursorColor: DropAndGoColors.white,
            inputBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                10.h,
              ),
            ),
            prefixWidget: const Icon(
              Icons.search,
              color: DropAndGoColors.white,
            ),
            fillColor: DropAndGoColors.primary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 16.h,
          ),
          child: BlocBuilder<IsSearchActive, bool>(
                  builder: (context, isSearchActive) {
                  return
                    isSearchActive?

                    Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StandardText.headline6(
                        context,
                        'Previous Search',
                      ),
                      21.h.verticalSpace,
                      const Divider(
                        color: DropAndGoColors.primary,
                      ),
                      ListView.builder(
                        primary: false,
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        shrinkWrap: true,
                        itemCount: 25,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.only(bottom: 15.h),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                StandardText.headline6(
                                  context,
                                  'Previous Search',
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: SvgPicture.asset(
                                    DropAndGoIcons.backSpaceOutlined,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ): SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Image.asset(
                            DropAndGoImages.error,
                            width: 309.w,
                            height: 309.h,
                          ),
                          24.h.verticalSpace,
                          StandardText.headline4(
                            context,
                            "NOT FOUND TRY AGAIN",
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                    );
                })
        ),
      ),
    );
  }
}
