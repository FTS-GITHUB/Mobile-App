import 'package:dropandgouser/application/search/cubit/is_seearch_active.dart';
import 'package:dropandgouser/application/search/search_found_bloc/search_found_bloc.dart';
import 'package:dropandgouser/application/search/search_history_bloc/search_bloc.dart';
import 'package:dropandgouser/domain/home/category.dart';
import 'package:dropandgouser/presentation/search/search_found.dart';
import 'package:dropandgouser/presentation/search/search_history.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/widgets/standard_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/widgets/button_loading.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    Key? key,
    required this.categories,
  }) : super(key: key);
  final List<Category> categories;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchTextEditingController = TextEditingController();

  @override
  void initState() {
    context.read<SearchBloc>().add(FetchPreviousSearches());
    super.initState();
  }

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
            controller: searchTextEditingController,
            textInputAction: TextInputAction.search,
            labelStyle:
                const TextStyle(color: DropAndGoColors.white, fontSize: 12),
            onTap: () {
              context.read<IsSearchActive>().activeSearch();
            },
            onFieldSubmitted: (_) {
              context.read<SearchFoundBloc>().add(
                    FetchSearch(
                      searchText: searchTextEditingController.text,
                      categories: widget.categories,
                    ),
                  );
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
      body: BlocListener<SearchFoundBloc, SearchFoundState>(
        listener: (context, searchFoundState){
          if(searchFoundState is SearchFoundStateLoaded){
            context.read<SearchBloc>().add(FetchPreviousSearches());
          }
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: 16.h,
              ),
              child: BlocBuilder<IsSearchActive, bool>(
                  builder: (context, isSearchActive) {
                return isSearchActive
                    ? BlocBuilder<SearchBloc, SearchState>(
                        builder: (context, state) {
                        return (state is SearchStateLoading)
                            ? const DropAndGoButtonLoading()
                            : (state is SearchStateLoaded)
                                ? SearchHistory(
                                    searches: state.previousSearches,
                                    categories: widget.categories,
                                  )
                                : const SizedBox.shrink();
                      })
                    : const SearchFound();
                // : const SearchNotFound();
              })),
        ),
      ),
    );
  }
}
