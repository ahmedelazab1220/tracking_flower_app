import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/l10n/locale_keys.g.dart';
import '../view_model/cubit/apply_cubit.dart';

class PasswordFields extends StatelessWidget {
  const PasswordFields({super.key});

  @override
  Widget build(BuildContext context) {
    var viewModel = context.read<ApplyCubit>();
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: viewModel.passwordController,
            validator:
                (value) => viewModel.validator.validatePassword(value ?? ''),
            decoration: InputDecoration(
              labelText: LocaleKeys.Password.tr(),
              hintText: LocaleKeys.EnterYourPassword.tr(),
            ),
            onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: TextFormField(
            controller: viewModel.confirmPasswordController,
            validator:
                (value) => viewModel.validator.validateConfirmPassword(
                  value ?? '',
                  viewModel.passwordController.text,
                ),
            decoration: InputDecoration(
              labelText: LocaleKeys.ConfirmPassword.tr(),
              hintText: LocaleKeys.EnterYourPassword.tr(),
            ),
            onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
          ),
        ),
      ],
    );
  }
}
