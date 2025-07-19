import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/assets/app_colors.dart';
import '../../../../core/base/base_state.dart';
import '../../../../core/utils/l10n/locale_keys.g.dart';
import '../view_model/cubit/apply_cubit.dart';
import 'country_dropdown_widget.dart';
import 'email_and_phone_number_fields.dart';
import 'gender_radio_button.dart';
import 'identity_input_section.dart';
import 'national_id_field.dart';
import 'password_fields.dart';
import 'vehicle_license_field.dart';
import 'vehicle_number_field.dart';
import 'vehicles_dropdown_widget.dart';

class ApplyForm extends StatelessWidget {
  const ApplyForm({super.key});

  @override
  Widget build(BuildContext context) {
    var viewModel = context.read<ApplyCubit>();
    return Form(
      onChanged: () => viewModel.doIntent(FormDataChangedAction()),
      key: viewModel.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            LocaleKeys.Welcome.tr(),
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
          ),
          Text(
            LocaleKeys.YouWantToBeADeliveryManJoinOurTeam.tr(),
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: AppColors.gray),
          ),
          const SizedBox(height: 25.0),
          const CountryDropdownWidget(),
          const SizedBox(height: 25.0),
          const IdentityInputSection(),
          const SizedBox(height: 25.0),
          const VehiclesDropdownWidget(),
          const SizedBox(height: 25.0),
          const VehicleNumberField(),
          const SizedBox(height: 25.0),
          const VehicleLicenseField(),
          const SizedBox(height: 25.0),
          const EmailAndPhoneNumberFields(),
          const SizedBox(height: 25.0),
          const NationalIdField(),
          const SizedBox(height: 25.0),
          const PasswordFields(),
          const SizedBox(height: 25.0),
          const GenderRadioButton(),
          const SizedBox(height: 25.0),
          ValueListenableBuilder(
            valueListenable: viewModel.valid,
            builder: (context, value, child) {
              return BlocBuilder<ApplyCubit, ApplyState>(
                buildWhen:
                    (previous, current) =>
                        previous.applyState != current.applyState,
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () {
                      viewModel.doIntent(ApplyRequestAction());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          viewModel.valid.value
                              ? AppColors.pink
                              : AppColors.black[AppColors.colorCode30],
                    ),
                    child:
                        viewModel.state.applyState is BaseLoadingState
                            ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.white,
                                ),
                              ),
                            )
                            : Text(LocaleKeys.Apply.tr()),
                  );
                },
              );
            },
          ),
          const SizedBox(height: 50.0),
        ],
      ),
    );
  }
}
