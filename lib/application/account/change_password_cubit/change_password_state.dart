part of 'change_password_cubit.dart';

class ChangePasswordCubitState {
  ChangePasswordCubitState({
    this.isOldPasswordObscure = true,
    this.isNewPasswordObscure = true,
    this.isConfirmNewPasswordObscure = true,
  });

  bool isOldPasswordObscure;
  bool isNewPasswordObscure;
  bool isConfirmNewPasswordObscure;

  ChangePasswordCubitState copyWith({
    bool? isOldPasswordObscure,
    bool? isNewPasswordObscure,
    bool? isConfirmNewPasswordObscure,
  }) =>
      ChangePasswordCubitState(
        isOldPasswordObscure: isOldPasswordObscure ?? this.isOldPasswordObscure,
        isNewPasswordObscure: isNewPasswordObscure ?? this.isNewPasswordObscure,
        isConfirmNewPasswordObscure:
            isConfirmNewPasswordObscure ?? this.isConfirmNewPasswordObscure,
      );
}
