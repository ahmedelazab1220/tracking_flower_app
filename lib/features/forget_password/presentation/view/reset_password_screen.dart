import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking_flower_app/features/forget_password/presentation/view/widgets/shared_header_widget.dart';
import 'package:tracking_flower_app/features/forget_password/presentation/view/widgets/reset_password_form.dart';

import '../../../../../../core/base/base_state.dart';
import '../../../../../../core/utils/dialogs/app_dialogs.dart';
import '../../../../../../core/utils/l10n/locale_keys.g.dart';
import '../../../../core/utils/di/di.dart';
import '../../../../core/utils/routes/app_routes.dart';
import '../view_model/reset_password_cubit/reset_password_cubit.dart';
import '../view_model/reset_password_cubit/reset_password_state.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  const ResetPasswordScreen({super.key, required this.email});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final ResetPasswordCubit viewModel = getIt<ResetPasswordCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.Password.tr())),
      body: BlocProvider(
        create: (context) => viewModel,
        child: BlocListener<ResetPasswordCubit, ResetPasswordState>(
          listener: (context, state) {
            if (state.baseState is BaseLoadingState) {
              AppDialogs.showLoadingDialog(context);
            } else if (state.baseState is BaseSuccessState) {
              AppDialogs.hideLoading(context);
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.loginRoute,
                (route) => false,
              );
            } else if (state.baseState is BaseErrorState) {
              AppDialogs.hideLoading(context);
              AppDialogs.showFailureDialog(
                context,
                message: '',
                description: (state.baseState as BaseErrorState).errorMessage,
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SharedHeaderWidget(
                  title: LocaleKeys.ResetPassword.tr(),
                  subtitle: LocaleKeys.PasswordRequirements.tr(),
                ),
                ResetPasswordForm(email: widget.email),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
