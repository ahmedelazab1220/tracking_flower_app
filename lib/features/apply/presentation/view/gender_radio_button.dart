import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/assets/app_colors.dart';
import '../../../../core/utils/l10n/locale_keys.g.dart';
import '../view_model/cubit/apply_cubit.dart';

class GenderRadioButton extends StatefulWidget {
  const GenderRadioButton({super.key});

  @override
  State<GenderRadioButton> createState() => _GenderRadioButtonState();
}

class _GenderRadioButtonState extends State<GenderRadioButton> {
  @override
  Widget build(BuildContext context) {
    var viewModel = context.read<ApplyCubit>();
    return Row(
      children: [
        Text(
          LocaleKeys.Gender.tr(),
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(color: AppColors.gray),
        ),
        const SizedBox(width: 48.0),
        GestureDetector(
          onTap: () {
            setState(() {
              viewModel.selectedGender = Gender.male;
            });
          },
          child: Row(
            children: [
              Radio<Gender>(
                activeColor: AppColors.pink,
                value: Gender.male,
                groupValue: viewModel.selectedGender,
                onChanged: (value) {
                  setState(() {
                    viewModel.selectedGender = value!;
                  });
                },
              ),
              Text(
                LocaleKeys.Male.tr(),
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: AppColors.gray),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16.0),
        GestureDetector(
          onTap: () {
            setState(() {
              viewModel.selectedGender = Gender.female;
            });
          },
          child: Row(
            children: [
              Radio<Gender>(
                activeColor: AppColors.pink,
                value: Gender.female,
                groupValue: viewModel.selectedGender,
                onChanged: (value) {
                  setState(() {
                    viewModel.selectedGender = value!;
                  });
                },
              ),
              Text(
                LocaleKeys.Female.tr(),
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: AppColors.gray),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
