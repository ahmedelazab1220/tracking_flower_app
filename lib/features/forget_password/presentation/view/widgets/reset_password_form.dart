import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/l10n/locale_keys.g.dart';
import '../../view_model/reset_password/reset_password_cubit.dart';
import '../../view_model/reset_password/reset_password_state.dart';

class ResetPasswordForm extends StatelessWidget {
  final String email;

  const ResetPasswordForm({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final ResetPasswordCubit resetPasswordCubit =
        context.read<ResetPasswordCubit>();
    return Column(
      children: [
        Form(
          key: resetPasswordCubit.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: resetPasswordCubit.passwordController,
                decoration: InputDecoration(
                  labelText: LocaleKeys.NewPassword.tr(),
                  hintText: LocaleKeys.EnterYourNewPassword.tr(),
                ),
                validator:
                    (value) => resetPasswordCubit.validator.validatePassword(
                      value ?? '',
                    ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: resetPasswordCubit.confirmPasswordController,
                decoration: InputDecoration(
                  labelText: LocaleKeys.ConfirmPassword.tr(),
                  hintText: LocaleKeys.ConfirmPassword.tr(),
                ),
                validator:
                    (value) =>
                        resetPasswordCubit.validator.validateConfirmPassword(
                          value!,
                          resetPasswordCubit.passwordController.text,
                        ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: 48),
              SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    if (resetPasswordCubit.formKey.currentState?.validate() ??
                        false) {
                      resetPasswordCubit.doIntent(
                        ResetPasswordRequestAction(email),
                      );
                    }
                  },
                  child: Text(LocaleKeys.Confirm.tr()),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
