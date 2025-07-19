class NationalIdEntity {
  final String? idNumber;
  final String? dateOfBirth;
  final String? name;
  final bool isValidNationalId;
  final String? errorMessage;

  const NationalIdEntity({
    required this.idNumber,
    required this.dateOfBirth,
    required this.name,
    required this.isValidNationalId,
    required this.errorMessage,
  });
}
