import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:dropandgouser/application/main/cubit/main_navbar_cubit.dart';
import 'package:dropandgouser/domain/search/search.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/infrastructure/services/navigation_service.dart';
import 'package:dropandgouser/presentation/home/widgets/home_rect_category.dart';
import 'package:dropandgouser/presentation/search/widgets/search_item.dart';
import 'package:dropandgouser/shared/constants/assets.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/widgets/standard_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadsPage extends StatefulWidget {
  const DownloadsPage({Key? key}) : super(key: key);

  @override
  State<DownloadsPage> createState() => _DownloadsPageState();
}

class _DownloadsPageState extends State<DownloadsPage> {
  List<DownloadTask>? tasks;

  @override
  void initState() {
    super.initState();

    // IsolateNameServer.registerPortWithName(
    //     _port.sendPort, 'downloader_send_port');
    // _port.listen((dynamic data) {
    //   String id = data[0];
    //   DownloadTaskStatus status = DownloadTaskStatus(data[1]);
    //   int progress = data[2];
    //   setState(() {});
    // });
    //
    // FlutterDownloader.registerCallback(downloadCallback);
    getDownloadedTasks();
    setState(() {

    });
  }

  getDownloadedTasks()async {
    tasks = await FlutterDownloader.loadTasks();
    tasks?.forEach((element) {
      print(element.url);
    });
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
      body: CustomScrollView(
        primary: true,
        slivers: [
          SliverToBoxAdapter(
            child: 20.h.verticalSpace,
          ),
          SliverToBoxAdapter(
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.only(
                left: 36.w,
                right: 28.w,
              ),
              primary: false,
              itemCount: tasks?.length??0,
              itemBuilder: (context, index) {
                return SearchItem(
                  search: Search(
                    title: "ANXIETY",
                    artistName: "Artist Name",
                    imageUrl: DropAndGoImages.addictions,
                    isFavorite: true,
                    isDownloadPage: true,
                    onItemTapped: () {
                      if(tasks!=null && tasks!.isNotEmpty){
                        FlutterDownloader.open(taskId: tasks![index].taskId);
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
