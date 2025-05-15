import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/l10n/locale_keys.g.dart';
import '../view_model/cubit/apply_cubit.dart';

class EmailAndPhoneNumberFields extends StatelessWidget {
  const EmailAndPhoneNumberFields({super.key});

  @override
  Widget build(BuildContext context) {
    var viewModel = context.read<ApplyCubit>();
    return Column(
      children: [
        TextFormField(
          controller: viewModel.emailController,
          validator: (value) => viewModel.validator.validateEmail(value ?? ''),
          decoration: InputDecoration(
            labelText: LocaleKeys.Email.tr(),
            hintText: LocaleKeys.EnterYourEmail.tr(),
          ),
          onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
        ),
        const SizedBox(height: 25.0),
        TextFormField(
          controller: viewModel.phoneController,
          validator:
              (value) => viewModel.validator.validatePhoneNumber(value ?? ''),
          decoration: InputDecoration(
            labelText: LocaleKeys.PhoneNumber.tr(),
            hintText: LocaleKeys.EnterYourPhoneNumber.tr(),
          ),
          onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
        ),
      ],
    );
  }
}
