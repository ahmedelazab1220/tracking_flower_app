part of 'apply_cubit.dart';

class ApplyState extends Equatable {
  final BaseState? getCountriesState;
  final BaseState? getVehiclesState;
  final BaseState? extractDataFromVehicleLicenseState;
  final BaseState? extractDataFromNationalIdState;
  final BaseState? applyState;

  const ApplyState({
    this.getCountriesState,
    this.getVehiclesState,
    this.extractDataFromVehicleLicenseState,
    this.extractDataFromNationalIdState,
    this.applyState,
  });

  ApplyState copyWith({
    BaseState? getCountriesState,
    BaseState? getVehiclesState,
    BaseState? extractDataFromVehicleLicenseState,
    BaseState? extractDataFromNationalIdState,
    BaseState? applyState,
  }) {
    return ApplyState(
      getCountriesState: getCountriesState ?? this.getCountriesState,
      getVehiclesState: getVehiclesState ?? this.getVehiclesState,
      extractDataFromVehicleLicenseState:
          extractDataFromVehicleLicenseState ??
          this.extractDataFromVehicleLicenseState,
      extractDataFromNationalIdState:
          extractDataFromNationalIdState ?? this.extractDataFromNationalIdState,
      applyState: applyState ?? this.applyState,
    );
  }

  @override
  List<Object?> get props => [
    getCountriesState,
    getVehiclesState,
    extractDataFromVehicleLicenseState,
    extractDataFromNationalIdState,
    applyState,
  ];
}

sealed class ApplyAction {}

final class GetAllCountriesAction extends ApplyAction {}

final class GetAllVehiclesAction extends ApplyAction {}

final class ExtractDataFromVehicleLicenseAction extends ApplyAction {}

final class ExtractDataFromNationalIdAction extends ApplyAction {}

final class FormDataChangedAction extends ApplyAction {}

final class ApplyRequestAction extends ApplyAction {}

enum Gender { none, male, female }
