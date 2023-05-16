import 'dart:async';
import 'dart:io';

import 'package:dropandgouser/domain/account/i_account_repository.dart';
import 'package:dropandgouser/domain/signup/i_signup_repository.dart';
import 'package:dropandgouser/domain/signup/userdata.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'personal_info_event.dart';

part 'personal_info_state.dart';

class PersonalInfoBloc extends Bloc<PersonalInfoEvent, PersonalInfoState> {
  PersonalInfoBloc(
      {required IAccountRepository accountRepository,
      required ISignupRepository signupRepository})
      : _accountRepository = accountRepository,
        _signupRepository = signupRepository,
        super(PersonalInfoStateInitial()) {
    on<UpdatePersonalInfo>(_onUpdatePersonalInfo);
    on<UpdateProfilePic>(_onUpdateProfilePic);
  }

  final IAccountRepository _accountRepository;
  final ISignupRepository _signupRepository;

  Future<void> _onUpdatePersonalInfo(
    UpdatePersonalInfo event,
    Emitter<PersonalInfoState> emit,
  ) async {
    if (event.fileImage != null) {
      add(UpdateProfilePic(
        userData: event.userData,
        fileImage: event.fileImage!,
      ));
    } else {
      emit(PersonalInfoStateLoading());
      final response = await _accountRepository.updatePersonalInfo(
        userData: event.userData,
      );
      response.fold(
        (l) => emit(PersonalInfoStateError(
          message: l.message ?? 'Failed to connect',
        )),
        (r) => emit(
          PersonalInfoStateLoaded(
            userData: event.userData,
          ),
        ),
      );
    }
  }

  Future<void> _onUpdateProfilePic(
      UpdateProfilePic event, Emitter<PersonalInfoState> emit) async {
    final response =
        await _signupRepository.uploadUserProfilePic(file: event.fileImage);
    response.fold(
        (l) => emit(
              PersonalInfoStateError(
                message: l.message ?? '',
              ),
            ), (r) {
      event.userData = event.userData.copyWith(profilePicUrl: r);
      add(
        UpdatePersonalInfo(
          userData: event.userData,
        ),
      );
    });
  }
}
