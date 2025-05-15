import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/l10n/locale_keys.g.dart';
import '../../../../../core/assets/app_colors.dart';
import '../../view_model/reset_password_cubit/reset_password_cubit.dart';
import '../../view_model/reset_password_cubit/reset_password_state.dart';

class ResetPasswordForm extends StatelessWidget {
  final String email;

  const ResetPasswordForm({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final ResetPasswordCubit viewModel = context.read<ResetPasswordCubit>();
    return Column(
      children: [
        Form(
          onChanged: () => viewModel.doIntent(FormDataChangedAction()),
          key: viewModel.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: viewModel.passwordController,
                decoration: InputDecoration(
                  labelText: LocaleKeys.NewPassword.tr(),
                  hintText: LocaleKeys.EnterYourNewPassword.tr(),
                ),
                validator:
                    (value) =>
                        viewModel.validator.validatePassword(value ?? ''),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onTapOutside:
                    (_) => FocusManager.instance.primaryFocus?.unfocus(),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: viewModel.confirmPasswordController,
                decoration: InputDecoration(
                  labelText: LocaleKeys.ConfirmPassword.tr(),
                  hintText: LocaleKeys.ConfirmPassword.tr(),
                ),
                validator:
                    (value) => viewModel.validator.validateConfirmPassword(
                      value!,
                      viewModel.passwordController.text,
                    ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onTapOutside:
                    (_) => FocusManager.instance.primaryFocus?.unfocus(),
              ),
              const SizedBox(height: 48),
              ValueListenableBuilder(
                valueListenable: viewModel.valid,
                builder: (context, value, child) {
                  return ElevatedButton(
                    onPressed: () {
                      viewModel.doIntent(ResetPasswordRequestAction(email));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          value
                              ? AppColors.pink
                              : AppColors.black[AppColors.colorCode30],
                    ),
                    child: Text(LocaleKeys.Confirm.tr()),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
