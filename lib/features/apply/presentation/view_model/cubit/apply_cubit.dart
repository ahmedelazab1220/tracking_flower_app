import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../../core/base/base_state.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/datasource_excution/api_result.dart';
import '../../../../../core/utils/l10n/locale_keys.g.dart';
import '../../../../../core/utils/validator/validator.dart';
import '../../../../../domain/auth/entity/apply_request_entity.dart';
import '../../../../../domain/auth/entity/country_entity.dart';
import '../../../../../domain/auth/entity/national_id_entity.dart';
import '../../../../../domain/auth/entity/vehicle_license_entity.dart';
import '../../../../../domain/auth/entity/vehicles_entity.dart';
import '../../../../../domain/auth/use_case/apply_use_case.dart';
import '../../../../../domain/auth/use_case/extract_data_from_national_id_use_case.dart';
import '../../../../../domain/auth/use_case/extract_data_from_vehicle_license_use_case.dart';
import '../../../../../domain/auth/use_case/get_all_countries_use_case.dart';
import '../../../../../domain/auth/use_case/get_all_vehicles_use_case.dart';

part 'apply_state.dart';

@injectable
class ApplyCubit extends Cubit<ApplyState> {
  final GetAllCountriesUseCase _getAllCountriesUseCase;
  final GetAllVehiclesUseCase _getAllVehiclesUseCase;
  final ExtractDataFromVehicleLicenseUseCase
  _extractDataFromVehicleLicenseUseCase;
  final ExtractDataFromNationalIdUseCase _extractDataFromNationalIdUseCase;
  final ApplyUseCase _applyUseCase;
  final Validator validator;

  ApplyCubit(
    this._getAllVehiclesUseCase,
    this._getAllCountriesUseCase,
    this._extractDataFromVehicleLicenseUseCase,
    this._extractDataFromNationalIdUseCase,
    this._applyUseCase,
    this.validator,
  ) : super(const ApplyState());

  List<CountryEntity> countries = [];
  CountryEntity selectedCountry = CountryEntity();
  List<VehiclesEntity> vehicles = [];
  VehiclesEntity selectedVehicle = VehiclesEntity();
  Gender selectedGender = Gender.none;
  File? vehicleLicenseImage;
  File? nationalIdImage;
  final TextEditingController firstLegalNameController =
      TextEditingController();
  final TextEditingController secondLegalNameController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController idNumberController = TextEditingController();
  final TextEditingController vehicleNumberController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey vehicleNumberShowcaseKey = GlobalKey();
  final GlobalKey idNumberShowcaseKey = GlobalKey();
  final GlobalKey firstLegalNameShowcaseKey = GlobalKey();
  final GlobalKey secondLegalNameShowcaseKey = GlobalKey();
  final ValueNotifier<bool> valid = ValueNotifier<bool>(false);
  Completer? _currentShowcaseCompleter;
  Timer? _timeoutTimer;
  final ScrollController scrollController = ScrollController();

  Future<void> doIntent(ApplyAction action) async {
    switch (action) {
      case GetAllCountriesAction():
        {
          _getCountries();
        }
      case GetAllVehiclesAction():
        {
          _getVehicles();
        }
      case ExtractDataFromVehicleLicenseAction():
        {
          _getDataFromVehicleLicense();
        }
      case ExtractDataFromNationalIdAction():
        {
          _getDataFromNationalId();
        }
      case FormDataChangedAction():
        {
          _updateValidationState();
        }

      case ApplyRequestAction():
        {
          _apply();
        }
    }
  }

  _apply() async {
    if (formKey.currentState!.validate()) {
      emit(state.copyWith(applyState: BaseLoadingState()));
      var response = await _applyUseCase(
        ApplyRequestEntity(
          country: selectedCountry.name!,
          vehicleType: selectedVehicle.id!,
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          rePassword: confirmPasswordController.text.trim(),
          firstName: firstLegalNameController.text.trim(),
          lastName: secondLegalNameController.text.trim(),
          nid: idNumberController.text.trim(),
          nidImg: nationalIdImage!,
          vehicleLicense: vehicleLicenseImage!,
          vehicleNumber: vehicleNumberController.text.trim(),
          gender: selectedGender == Gender.male ? 'male' : 'female',
          phone: phoneController.text.trim(),
        ),
      );
      switch (response) {
        case SuccessResult<void>():
          {
            emit(state.copyWith(applyState: BaseSuccessState()));
          }
        case FailureResult<void>():
          {
            emit(
              state.copyWith(
                applyState: BaseErrorState(
                  errorMessage: response.exception.toString(),
                  exception: response.exception,
                ),
              ),
            );
          }
      }
    }
  }

  _getDataFromNationalId() async {
    emit(state.copyWith(extractDataFromNationalIdState: BaseLoadingState()));
    idNumberController.text = '';
    firstLegalNameController.text = '';
    secondLegalNameController.text = '';
    var response = await _extractDataFromNationalIdUseCase(nationalIdImage);
    switch (response) {
      case SuccessResult<NationalIdEntity>():
        {
          idNumberController.text = response.data.idNumber ?? '';
          List<String> fullName = response.data.name!.split(' ');
          secondLegalNameController.text = fullName[1];
          firstLegalNameController.text = fullName[0];
          emit(
            state.copyWith(extractDataFromNationalIdState: BaseSuccessState()),
          );
        }
      case FailureResult<NationalIdEntity>():
        {
          nationalIdImage = null;
          emit(
            state.copyWith(
              extractDataFromNationalIdState: BaseErrorState(
                errorMessage: response.exception.toString(),
                exception: response.exception,
              ),
            ),
          );
        }
    }
  }

  _getDataFromVehicleLicense() async {
    emit(
      state.copyWith(extractDataFromVehicleLicenseState: BaseLoadingState()),
    );
    vehicleNumberController.text = '';
    var response = await _extractDataFromVehicleLicenseUseCase(
      vehicleLicenseImage,
    );
    switch (response) {
      case SuccessResult<VehicleLicenseEntity>():
        {
          vehicleNumberController.text = response.data.licenseNumber ?? '';
          emit(
            state.copyWith(
              extractDataFromVehicleLicenseState: BaseSuccessState(),
            ),
          );
        }
      case FailureResult<VehicleLicenseEntity>():
        {
          vehicleLicenseImage = null;
          emit(
            state.copyWith(
              extractDataFromVehicleLicenseState: BaseErrorState(
                errorMessage: response.exception.toString(),
                exception: response.exception,
              ),
            ),
          );
        }
    }
  }

  _getVehicles() async {
    emit(state.copyWith(getVehiclesState: BaseLoadingState()));
    var response = await _getAllVehiclesUseCase();
    switch (response) {
      case SuccessResult<List<VehiclesEntity>>():
        {
          vehicles = response.data;
          selectedVehicle = vehicles[0];
          emit(state.copyWith(getVehiclesState: BaseSuccessState()));
        }
      case FailureResult<List<VehiclesEntity>>():
        {
          emit(
            state.copyWith(
              getVehiclesState: BaseErrorState(
                errorMessage: LocaleKeys.VehiclesNotFoundPleaseTryAgain.tr(),
              ),
            ),
          );
        }
    }
  }

  _getCountries() async {
    emit(state.copyWith(getCountriesState: BaseLoadingState()));
    var response = await _getAllCountriesUseCase();
    if (response.isNotEmpty) {
      countries = response;
      selectedCountry = countries[0];
      emit(state.copyWith(getCountriesState: BaseSuccessState()));
    } else {
      emit(
        state.copyWith(
          getCountriesState: BaseErrorState(
            errorMessage: LocaleKeys.CountriesNotFoundPleaseTryAgain.tr(),
          ),
        ),
      );
    }
  }

  String toFlag(String code) {
    return (code).toUpperCase().replaceAllMapped(
      RegExp(r'[A-Z]'),
      (match) => String.fromCharCode(
        match.group(0)!.codeUnitAt(0) + Constants.addNumberToConvertToFlag,
      ),
    );
  }

  void _updateValidationState() {
    final isValidForm = formKey.currentState?.validate() ?? false;

    final allFieldsFilled = [
      emailController,
      passwordController,
      confirmPasswordController,
      firstLegalNameController,
      secondLegalNameController,
      phoneController,
      idNumberController,
      vehicleNumberController,
    ].every((controller) => controller.text.isNotEmpty);

    final otherValidations = [
      selectedCountry.name!.isNotEmpty,
      selectedVehicle.type!.isNotEmpty,
      selectedGender != Gender.none,
      vehicleLicenseImage != null,
      nationalIdImage != null,
    ].every((condition) => condition);

    valid.value = isValidForm && allFieldsFilled && otherValidations;
  }

  Future<void> _ensureWidgetVisible(BuildContext context, GlobalKey key) async {
    await Future.delayed(const Duration(milliseconds: 50));

    final renderBox = key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null || !context.mounted) return;

    await Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      alignment: 0.3,
    );

    await Future.delayed(const Duration(milliseconds: 200));
  }

  void completeCurrentShowcase() {
    if (_currentShowcaseCompleter != null &&
        !_currentShowcaseCompleter!.isCompleted) {
      _currentShowcaseCompleter!.complete();
    }
  }

  Future<void> _showCaseWithTimeout(BuildContext context, GlobalKey key) async {
    _currentShowcaseCompleter = Completer();
    bool isCompleted = false;

    final timer = Timer(const Duration(seconds: 6), () {
      if (!isCompleted) {
        completeCurrentShowcase();
      }
    });

    try {
      await Future.delayed(const Duration(milliseconds: 100));
      if (!context.mounted) return;

      if (context.mounted) ShowCaseWidget.of(context).startShowCase([key]);
      await Future.delayed(const Duration(milliseconds: 300));

      await _currentShowcaseCompleter!.future;
    } finally {
      isCompleted = true;
      timer.cancel();
      if (context.mounted) {
        ShowCaseWidget.of(context).dismiss();
      }
    }
  }

  void startShowcaseQueue(BuildContext context, ApplyCubit viewModel) async {
    final showcaseKeys = [
      viewModel.firstLegalNameShowcaseKey,
      viewModel.secondLegalNameShowcaseKey,
      viewModel.idNumberShowcaseKey,
    ];

    for (final key in showcaseKeys) {
      if (!context.mounted) break;

      if (context.mounted) await _ensureWidgetVisible(context, key);
      if (!context.mounted) break;

      if (context.mounted) await _showCaseWithTimeout(context, key);

      await Future.delayed(const Duration(milliseconds: 200));
    }
  }

  @override
  Future<void> close() async {
    firstLegalNameController.dispose();
    secondLegalNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    idNumberController.dispose();
    vehicleNumberController.dispose();
    scrollController.dispose();
    _timeoutTimer?.cancel();
    valid.dispose();
    super.close();
  }
}
