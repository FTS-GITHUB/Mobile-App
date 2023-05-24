import 'dart:async';

import 'package:dropandgouser/domain/account/i_account_repository.dart';
import 'package:dropandgouser/domain/services/user_service.dart';
import 'package:dropandgouser/domain/signup/user_setting.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'account_setting_event.dart';
part 'account_setting_state.dart';

class AccountSettingBloc
    extends Bloc<AccountSettingEvent, AccountSettingState> {
  AccountSettingBloc({
    required IAccountRepository accountRepository,
  })  : _accountRepository = accountRepository,
        super(AccountSettingStateInitial()) {
    on<UpdateUserSetting>(_onUpdateUserSetting);
  }

  final IAccountRepository _accountRepository;

  Future<void> _onUpdateUserSetting(
      UpdateUserSetting event, Emitter<AccountSettingState> emit) async {
    final user = getIt<UserService>().userData;
    if (user?.id == null) {
      emit(
        AccountSettingStateError(
          message: 'Unauthorized',
        ),
      );
    } else {
      emit(AccountSettingStateLoading());
      final response = await _accountRepository.updateUserSetting(
        userId: user!.id!,
        userSetting: event.userSetting,
      );
      response.fold(
        (l) => emit(
          AccountSettingStateError(
            message: l.message ?? '',
          ),
        ),
        (r) => emit(
          AccountSettingStateLoaded(
            userSetting: event.userSetting,
          ),
        ),
      );
    }
  }
}
