import 'dart:io';

import 'package:dropandgouser/shared/enums/alert_type.dart';
import 'package:dropandgouser/shared/widgets/toasts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

class ProfileFileCubit extends Cubit<File?> {
  ProfileFileCubit() : super(null);
  File? image;
  final _picker = ImagePicker();
  final _toast = Toasts();

  Future<void> getImage(BuildContext context) async {
    try{
      final pickedImage = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 40,
      );
      if (pickedImage != null) {
        image = File(pickedImage.path);
        emit(image);
      }
    }on PlatformException catch(e){
      _toast.showToast(context, type: AlertType.Info, title: 'Info', description: '${e.message}');
      if(e.code == 'camera_access_denied'){
        debugPrint("I am not allowed to take photos");
        await Geolocator.openAppSettings();
      }
      // print('ImageException is: ${e.toString()}');
    }

  }

  dispose(){
    emit(null);
  }
}
