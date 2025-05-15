import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/base/base_state.dart';
import '../../../../core/utils/di/di.dart';
import '../../../../core/utils/dialogs/app_dialogs.dart';
import '../../../../core/utils/l10n/locale_keys.g.dart';
import '../view_model/cubit/apply_cubit.dart';
import 'apply_form.dart';
import 'scanning_overlay.dart';

class ApplyScreen extends StatefulWidget {
  const ApplyScreen({super.key});

  @override
  State<ApplyScreen> createState() => _ApplyScreenState();
}

class _ApplyScreenState extends State<ApplyScreen> {
  final viewModel = getIt<ApplyCubit>();

  @override
  void initState() {
    super.initState();
    viewModel.doIntent(GetAllVehiclesAction());
    viewModel.doIntent(GetAllCountriesAction());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: Stack(
        children: [
          BlocListener<ApplyCubit, ApplyState>(
            listener: (context, state) {
              if (state.applyState is BaseErrorState) {
                AppDialogs.showFailureDialog(
                  context,
                  message:
                      'Failed to apply on application please check your data',
                  description:
                      (state.applyState as BaseErrorState).errorMessage,
                );
              }
            },
            child: Scaffold(
              appBar: AppBar(title: Text(LocaleKeys.Apply.tr())),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomScrollView(
                  controller: viewModel.scrollController,
                  slivers: const [SliverToBoxAdapter(child: ApplyForm())],
                ),
              ),
            ),
          ),
          BlocBuilder<ApplyCubit, ApplyState>(
            buildWhen:
                (prev, curr) =>
                    prev.extractDataFromNationalIdState !=
                        curr.extractDataFromNationalIdState ||
                    prev.extractDataFromVehicleLicenseState !=
                        curr.extractDataFromVehicleLicenseState,
            builder: (context, state) {
              if (state.extractDataFromVehicleLicenseState
                  is BaseLoadingState) {
                return ScanningOverlay(
                  text: LocaleKeys.ScanningVehicleLicense.tr(),
                );
              }
              if (state.extractDataFromNationalIdState is BaseLoadingState) {
                return ScanningOverlay(
                  text: LocaleKeys.ScanningNationalID.tr(),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
