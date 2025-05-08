import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking_flower_app/features/forget_password/presentation/view/widgets/forget_password_form.dart';
import 'package:tracking_flower_app/features/forget_password/presentation/view/widgets/shared_header_widget.dart';

import '../../../../../../core/utils/l10n/locale_keys.g.dart';
import '../../../../core/base/base_state.dart';
import '../../../../core/utils/di/di.dart';
import '../../../../core/utils/dialogs/app_dialogs.dart';
import '../../../../core/utils/routes/app_routes.dart';
import '../view_model/forget_password_cubit/forget_password_cubit.dart';
import '../view_model/forget_password_cubit/forget_password_state.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final ForgetPasswordCubit viewModel = getIt<ForgetPasswordCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.Password.tr())),
      body: BlocProvider(
        create: (context) => viewModel,
        child: BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
          listener: (context, state) {
            if (state.baseState is BaseLoadingState) {
              AppDialogs.showLoadingDialog(context);
            } else if (state.baseState is BaseSuccessState) {
              AppDialogs.hideLoading(context);
              Navigator.pushNamed(
                context,
                AppRoutes.emailVerificationRoute,
                arguments: {'email': viewModel.emailController.text},
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
                  title: LocaleKeys.ForgetPassword.tr(),
                  subtitle:
                      LocaleKeys
                          .PleaseEnterYourEmailAssociatedToYourAccount.tr(),
                ),
                const ForgetPasswordForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
