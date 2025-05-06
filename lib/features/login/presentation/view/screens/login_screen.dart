import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/utils/l10n/locale_keys.g.dart';
import '../../../../../core/base/base_state.dart';
import '../../../../../core/utils/di/di.dart';
import '../../../../../core/utils/dialogs/app_dialogs.dart';
import '../../view_model/login_cubit.dart';
import '../../view_model/login_state.dart';
import '../widgets/login_button.dart';
import '../widgets/login_form.dart';
import '../widgets/remember_me_and_forget_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final viewModel = getIt<LoginCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: Scaffold(
        appBar: AppBar(title: Text(LocaleKeys.Login.tr())),
        body: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state.loginState is BaseLoadingState) {
              AppDialogs.showLoadingDialog(context);
            }
            if (state.loginState is BaseSuccessState) {
              AppDialogs.hideLoading(context);
            }
            if (state.loginState is BaseErrorState) {
              AppDialogs.hideLoading(context);
              AppDialogs.showFailureDialog(
                context,
                message: (state.loginState as BaseErrorState).errorMessage,
              );
            }
          },
          child: SingleChildScrollView(
            child: Form(
              key: viewModel.formKey,
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    LoginForm(),
                    RememberMeAndForgotPassword(),
                    LoginButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
