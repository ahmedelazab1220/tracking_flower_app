import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/l10n/locale_keys.g.dart';
import '../../../../../core/assets/app_colors.dart';
import '../../view_model/forget_password_cubit/forget_password_cubit.dart';
import '../../view_model/forget_password_cubit/forget_password_state.dart';

class ForgetPasswordForm extends StatelessWidget {
  const ForgetPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    final ForgetPasswordCubit viewModel = context.read<ForgetPasswordCubit>();
    return Form(
      onChanged: () => viewModel.doIntent(FormDataChangedAction()),
      key: viewModel.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: viewModel.emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: LocaleKeys.Email.tr(),
              prefixIcon: const Icon(Icons.email),
            ),
            validator:
                (value) => viewModel.validator.validateEmail(value ?? ''),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
          ),
          const SizedBox(height: 48),
          ValueListenableBuilder(
            valueListenable: viewModel.valid,
            builder: (context, value, child) {
              return ElevatedButton(
                onPressed: () {
                  viewModel.doIntent(ForgetPasswordRequestAction());
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
    );
  }
}
