import 'package:dropandgouser/application/search/cubit/is_seearch_active.dart';
import 'package:dropandgouser/application/search/search_found_bloc/search_found_bloc.dart';
import 'package:dropandgouser/application/search/search_history_bloc/search_bloc.dart';
import 'package:dropandgouser/domain/home/category.dart';
import 'package:dropandgouser/domain/search/previous_searches.dart';
import 'package:dropandgouser/shared/constants/assets.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchHistory extends StatelessWidget {
  const SearchHistory({
    Key? key,
    required this.searches,
    required this.categories,
  }) : super(key: key);

  final List<PreviousSearches> searches;
  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    return Column(
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
          reverse: true,
          primary: false,
          padding: EdgeInsets.symmetric(vertical: 15.h),
          shrinkWrap: true,
          itemCount: searches.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                FocusScope.of(context).unfocus();
                context.read<SearchFoundBloc>().add(
                      FetchSearch(
                        searchText: searches[index].name ?? '',
                        categories: categories,
                      ),
                    );
                context.read<IsSearchActive>().unActiveSearch();
              },
              child: Container(
                padding: EdgeInsets.only(bottom: 15.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StandardText.headline6(
                      context,
                      searches[index].name ?? '',
                    ),
                    IconButton(
                      onPressed: () {
                        deletionConfirmationDialog(
                          context,
                          onConfirm: () {
                            context.read<SearchBloc>().add(
                              DeleteSearch(
                                docId: searches[index].id!,
                              ),
                            );
                          },
                        );
                      },
                      icon: SvgPicture.asset(
                        DropAndGoIcons.backSpaceOutlined,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  deletionConfirmationDialog(
    BuildContext context, {
    required VoidCallback onConfirm,
  }) {
    return showDialog(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: StandardText.headline5(
              dialogContext,
              'Are you sure you want to delete this search?',
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: (){
                    Navigator.pop(dialogContext);
                    onConfirm();
                  },
                  child: StandardText.headline6(
                    dialogContext,
                    'Yes',
                    color: DropAndGoColors.red,
                  ),
                ),
                6.horizontalSpace,
                TextButton(
                  onPressed: (){
                    Navigator.pop(dialogContext);
                  },
                  child: StandardText.headline6(
                    dialogContext,
                    'No',
                    color: DropAndGoColors.primary,
                  ),
                ),
              ],
            ),
          );
        });
  }
}
