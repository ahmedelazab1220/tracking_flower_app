import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../core/base/base_state.dart';
import '../../../../core/utils/l10n/locale_keys.g.dart';
import '../view_model/cubit/apply_cubit.dart';

class IdentityInputSection extends StatelessWidget {
  const IdentityInputSection({super.key});

  @override
  Widget build(BuildContext context) {
    var viewModel = context.read<ApplyCubit>();
    return ShowCaseWidget(
      builder:
          (context) => BlocListener<ApplyCubit, ApplyState>(
            listenWhen:
                (prev, curr) =>
                    prev.extractDataFromNationalIdState !=
                    curr.extractDataFromNationalIdState,
            listener: (context, state) {
              if (state.extractDataFromNationalIdState is BaseSuccessState) {
                viewModel.startShowcaseQueue(context, viewModel);
              }
            },
            child: Column(
              children: [
                Showcase(
                  onBarrierClick: viewModel.completeCurrentShowcase,
                  targetPadding: const EdgeInsets.all(8.0),
                  key: viewModel.firstLegalNameShowcaseKey,
                  targetBorderRadius: BorderRadius.circular(12.0),
                  showArrow: true,
                  description: LocaleKeys.PleaseEnsureYourFirstLegalName.tr(),
                  movingAnimationDuration: const Duration(seconds: 1),
                  child: TextFormField(
                    controller: viewModel.firstLegalNameController,
                    validator:
                        (value) =>
                            viewModel.validator.validateName(value ?? ''),
                    decoration: InputDecoration(
                      labelText: LocaleKeys.FirstLegalName.tr(),
                      hintText: LocaleKeys.EnterYourFirstLegalName.tr(),
                    ),
                    onTapOutside:
                        (_) => FocusManager.instance.primaryFocus?.unfocus(),
                  ),
                ),
                const SizedBox(height: 25.0),
                Showcase(
                  onBarrierClick: viewModel.completeCurrentShowcase,
                  targetPadding: const EdgeInsets.all(8.0),
                  key: viewModel.secondLegalNameShowcaseKey,
                  targetBorderRadius: BorderRadius.circular(12.0),
                  showArrow: true,
                  description: LocaleKeys.PleaseEnsureYourSecondLegalName.tr(),
                  movingAnimationDuration: const Duration(seconds: 1),
                  child: TextFormField(
                    controller: viewModel.secondLegalNameController,
                    validator:
                        (value) =>
                            viewModel.validator.validateName(value ?? ''),
                    decoration: InputDecoration(
                      labelText: LocaleKeys.SecondLegalName.tr(),
                      hintText: LocaleKeys.EnterYourSecondLegalName.tr(),
                    ),
                    onTapOutside:
                        (_) => FocusManager.instance.primaryFocus?.unfocus(),
                  ),
                ),
                const SizedBox(height: 25.0),
                Showcase(
                  onBarrierClick: viewModel.completeCurrentShowcase,
                  targetPadding: const EdgeInsets.all(8.0),
                  key: viewModel.idNumberShowcaseKey,
                  targetBorderRadius: BorderRadius.circular(12.0),
                  showArrow: true,
                  description: LocaleKeys.PleaseEnsureYourNationalIDNumber.tr(),
                  movingAnimationDuration: const Duration(seconds: 1),
                  child: TextFormField(
                    controller: viewModel.idNumberController,
                    decoration: InputDecoration(
                      labelText: LocaleKeys.IDNumber.tr(),
                      hintText: LocaleKeys.EnterYourIDNumber.tr(),
                    ),
                    onTapOutside:
                        (_) => FocusManager.instance.primaryFocus?.unfocus(),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
