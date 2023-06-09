import 'package:dropandgouser/application/download/download_bloc/download_bloc.dart';
import 'package:dropandgouser/application/main/cubit/main_navbar_cubit.dart';
import 'package:dropandgouser/domain/player_audio/audio.dart';
import 'package:dropandgouser/domain/search/search.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/infrastructure/services/navigation_service.dart';
import 'package:dropandgouser/presentation/search/widgets/search_item.dart';
import 'package:dropandgouser/shared/constants/assets.dart';
import 'package:dropandgouser/shared/extensions/extensions.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/widgets/button_loading.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DownloadsPage extends StatefulWidget {
  const DownloadsPage({Key? key}) : super(key: key);

  @override
  State<DownloadsPage> createState() => _DownloadsPageState();
}

class _DownloadsPageState extends State<DownloadsPage> {
  @override
  void initState() {
    context.read<DownloadBloc>().add(FetchDownloads());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          leading: IconButton(
            icon: SvgPicture.asset(
              DropAndGoIcons.arrowLeft,
            ),
            onPressed: () {
              context.read<MainNavBarCubit>().changeBottomNavBar(0);
              getIt<NavigationService>().navigateBack(context: context);
            },
          ),
          title: StandardText.headline2(
            context,
            "Downloads",
            fontSize: 30,
            color: DropAndGoColors.primary,
          ),
        ),
      ),
      body: BlocBuilder<DownloadBloc, DownloadState>(builder: (context, state) {
        print(state);
        return (state is DownloadStateLoading)
            ? const DropAndGoButtonLoading()
            : (state is DownloadStateLoaded)
                ? CustomScrollView(
                    primary: true,
                    slivers: [
                      SliverToBoxAdapter(
                        child: Visibility(
                          visible: state.audios.isNotEmpty,
                          child: ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.only(
                              left: 36.w,
                              right: 28.w,
                            ),
                            primary: false,
                            itemCount: state.audios.length ?? 0,
                            itemBuilder: (context, index) {
                              print('Audios: ${state.audios.length}');
                              Audio audio = state.audios[index];
                              // Uri uri = Uri.parse(audio.audioUrl!);
                              // print(uri.queryParameters["name"]);
                              return SearchItem(
                                search: Search(
                                    title: audio.title,
                                    artistName: audio.artist,
                                    imageUrl: DropAndGoImages.addictions,
                                    isFavorite: true,
                                    isDownloadPage: true,
                                    onItemTapped: () {
                                      getIt<NavigationService>()
                                          .pushNamed(
                                        context: context,
                                        uri: NavigationService
                                            .downloadDetailRouteUri,
                                        data: state.audios[index],
                                      );
                                      // if (state.audios != null &&
                                      //     state.audios.isNotEmpty) {
                                      //   FlutterDownloader.open(
                                      //     taskId: state.audios[index].taskId,
                                      //   );
                                      // }
                                    },
                                    onLongPress: () {
                                      showDialog(
                                          context: context,
                                          builder: (dialogContext) {
                                            return AlertDialog(
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  StandardText.headline6(
                                                    dialogContext,
                                                    'Do you want to delete this file?',
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      TextButton(
                                                        onPressed: () {
                                                          // FlutterDownloader.remove(taskId: state.audios[index].taskId);
                                                          getIt<NavigationService>()
                                                              .navigateBack(
                                                                  context:
                                                                      context);
                                                          context
                                                              .read<
                                                                  DownloadBloc>()
                                                              .add(DeleteDownload(
                                                                  downloadId: state
                                                                          .audios[
                                                                              index]
                                                                          .id ??
                                                                      ''));
                                                        },
                                                        child: StandardText
                                                            .headline5(
                                                          context,
                                                          "Yes",
                                                          color: DropAndGoColors
                                                              .red,
                                                        ),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          getIt<NavigationService>()
                                                              .navigateBack(
                                                                  context:
                                                                      context);
                                                        },
                                                        child: StandardText
                                                            .headline5(
                                                          context,
                                                          "No",
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            );
                                          });
                                    }),
                              );
                            },
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Visibility(
                          visible: state.audios.isEmpty,
                          child: Container(
                            width: context.width,
                            height: context.height - 150,
                            alignment: Alignment.center,
                            child: StandardText.headline5(
                              context,
                              "No downloads yet!",
                              color: DropAndGoColors.black,
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                : (state is DownloadStateError)
                    ? Container(
                        width: context.width,
                        height: context.height - 150,
                        alignment: Alignment.center,
                        child: StandardText.headline5(
                          context,
                          state.message,
                          color: DropAndGoColors.black,
                        ),
                      )
                    : const SizedBox.shrink();
      }),
    );
  }
}
