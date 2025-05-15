import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../core/base/base_state.dart';
import '../../../../core/utils/l10n/locale_keys.g.dart';
import '../view_model/cubit/apply_cubit.dart';

class VehicleNumberField extends StatelessWidget {
  const VehicleNumberField({super.key});

  @override
  Widget build(BuildContext context) {
    var viewModel = context.read<ApplyCubit>();
    return ShowCaseWidget(
      builder:
          (context) => BlocListener<ApplyCubit, ApplyState>(
            listenWhen:
                (prev, curr) =>
                    prev.extractDataFromVehicleLicenseState !=
                    curr.extractDataFromVehicleLicenseState,
            listener: (context, state) {
              if (state.extractDataFromVehicleLicenseState
                  is BaseSuccessState) {
                ShowCaseWidget.of(
                  context,
                ).startShowCase([viewModel.vehicleNumberShowcaseKey]);
              }
            },
            child: Showcase(
              targetPadding: const EdgeInsets.all(8.0),
              key: viewModel.vehicleNumberShowcaseKey,
              targetBorderRadius: BorderRadius.circular(12.0),
              showArrow: true,
              description: 'Please ensure your vehicle number',
              movingAnimationDuration: const Duration(seconds: 1),
              child: TextFormField(
                controller: viewModel.vehicleNumberController,
                decoration: InputDecoration(
                  labelText: LocaleKeys.VehicleNumber.tr(),
                  hintText: LocaleKeys.EnterYourVehicleNumber.tr(),
                ),
                onTapOutside:
                    (_) => FocusManager.instance.primaryFocus?.unfocus(),
              ),
            ),
          ),
    );
  }
}
