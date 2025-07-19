import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/l10n/locale_keys.g.dart';
import '../../../../domain/auth/entity/vehicles_entity.dart';
import '../view_model/cubit/apply_cubit.dart';

class VehiclesDropdownWidget extends StatefulWidget {
  const VehiclesDropdownWidget({super.key});

  @override
  State<VehiclesDropdownWidget> createState() => _VehiclesDropdownWidgetState();
}

class _VehiclesDropdownWidgetState extends State<VehiclesDropdownWidget> {
  @override
  Widget build(BuildContext context) {
    var viewModel = context.read<ApplyCubit>();
    return BlocBuilder<ApplyCubit, ApplyState>(
      buildWhen:
          (previous, current) =>
              previous.getVehiclesState != current.getVehiclesState,
      builder: (context, state) {
        return DropdownButtonFormField<VehiclesEntity>(
          value:
              viewModel.vehicles.contains(viewModel.selectedVehicle)
                  ? viewModel.selectedVehicle
                  : null,
          isExpanded: true,
          decoration: InputDecoration(
            labelText: LocaleKeys.VehicleType.tr(),
            hintText: LocaleKeys.Country.tr(),
          ),
          items:
              viewModel.vehicles
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Row(
                        children: [
                          Image.network(e.image!, height: 50, width: 50),
                          const SizedBox(width: 8.0),
                          Text(e.type!),
                        ],
                      ),
                    ),
                  )
                  .toList(),
          onChanged: (value) {
            if (value != null) {
              viewModel.selectedVehicle = value;
            }
          },
        );
      },
    );
  }
}
