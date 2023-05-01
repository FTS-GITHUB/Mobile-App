import 'package:dropandgouser/application/search/cubit/is_seearch_active.dart';
import 'package:dropandgouser/presentation/search/search_found.dart';
import 'package:dropandgouser/presentation/search/search_history.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/widgets/standard_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final FocusNode _focus = FocusNode();

  final searchTextEditingController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    searchTextEditingController.dispose();
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
            labelStyle:
                const TextStyle(color: DropAndGoColors.white, fontSize: 12),
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
              return isSearchActive
                  ? const SearchHistory()
                  : const SearchFound();
                  // : const SearchNotFound();
            })),
      ),
    );
  }
}
