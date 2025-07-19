import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/l10n/locale_keys.g.dart';
import '../../../../domain/auth/entity/country_entity.dart';
import '../view_model/cubit/apply_cubit.dart';

class CountryDropdownWidget extends StatefulWidget {
  const CountryDropdownWidget({super.key});

  @override
  State<CountryDropdownWidget> createState() => _CountryDropdownWidgetState();
}

class _CountryDropdownWidgetState extends State<CountryDropdownWidget> {
  @override
  Widget build(BuildContext context) {
    var viewModel = context.read<ApplyCubit>();
    return BlocBuilder<ApplyCubit, ApplyState>(
      buildWhen:
          (previous, current) =>
              previous.getCountriesState != current.getCountriesState,
      builder: (context, state) {
        return DropdownButtonFormField<CountryEntity>(
          value:
              viewModel.countries.contains(viewModel.selectedCountry)
                  ? viewModel.selectedCountry
                  : null,
          isExpanded: true,
          decoration: InputDecoration(
            labelText: LocaleKeys.Country.tr(),
            hintText: LocaleKeys.Country.tr(),
          ),
          items:
              viewModel.countries
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Row(
                        children: [
                          Text(viewModel.toFlag(e.flag!)),
                          const SizedBox(width: 8.0),
                          Text(e.name!),
                        ],
                      ),
                    ),
                  )
                  .toList(),
          onChanged: (value) {
            if (value != null) {
              viewModel.selectedCountry = value;
            }
          },
        );
      },
    );
  }
}
