import 'package:dropandgouser/application/search/search_found_bloc/search_found_bloc.dart';
import 'package:dropandgouser/domain/search/search.dart';
import 'package:dropandgouser/domain/services/user_service.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/infrastructure/services/navigation_service.dart';
import 'package:dropandgouser/presentation/search/search_not_found.dart';
import 'package:dropandgouser/presentation/search/widgets/search_item.dart';
import 'package:dropandgouser/shared/widgets/button_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchFound extends StatelessWidget {
  const SearchFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userService = getIt<UserService>();
    return BlocBuilder<SearchFoundBloc, SearchFoundState>(
        builder: (context, state) {
      return (state is SearchFoundStateLoading)
          ? const DropAndGoButtonLoading()
          : (state is SearchFoundStateLoaded)
              ? state.categories.isEmpty
                  ? const SearchNotFound()
                  : ListView.builder(
                      padding: EdgeInsets.only(
                        left: 16.w,
                        right: 10.w,
                      ),
                      primary: false,
                      shrinkWrap: true,
                      itemCount: state.categories.length,
                      itemBuilder: (context, index) {
                        return SearchItem(
                          search: Search(
                            title: state.categories[index].name,
                            artistName: "Artist Name",
                            imageUrl: state.categories[index].imageUrl,
                            isFavorite: getIt<UserService>()
                                            .userData
                                            ?.likedCategories !=
                                        null &&
                                    userService.userData!.likedCategories!
                                        .contains(state.categories[index].id!)
                                ? false
                                : true,
                            onItemTapped: () {
                              getIt<NavigationService>().pushNamed(
                                context: context,
                                uri: NavigationService.categoryDetailRouteUri,
                                data: 'id',
                              );
                            },
                          ),
                        );
                      })
              : const SizedBox.shrink();
    });
  }
}
