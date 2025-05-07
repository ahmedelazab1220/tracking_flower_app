import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/assets/app_colors.dart';
import '../../../../../../core/utils/l10n/locale_keys.g.dart';
import '../../view_model/login_cubit.dart';
import '../../view_model/login_state.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    var viewModel = context.read<LoginCubit>();
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () {
            if (viewModel.validate) {
              viewModel.doIntent(LoginRequestAction());
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:
                viewModel.validate
                    ? AppColors.pink
                    : AppColors.black[AppColors.colorCode30],
          ),
          child: Text(LocaleKeys.Login.tr()),
        );
      },
    );
  }
}
