import 'dart:convert';
import 'dart:io';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:injectable/injectable.dart';

import '../../../core/utils/constants.dart';
import '../../../core/utils/datasource_excution/api_constants.dart';
import '../models/national_id_dto.dart';
import '../models/vehicle_license_dto.dart';

@injectable
class AiModelService {
  Future<NationalIdDto> extractDataFromNationalId(File? imageFile) async {
    if (imageFile == null) {
      return NationalIdDto(
        idNumber: null,
        dateOfBirth: null,
        name: null,
        isValidNationalId: false,
        errorMessage: 'No image provided',
      );
    }

    try {
      final model = GenerativeModel(
        model: Constants.aiModelVersion,
        apiKey: ApiConstants.aiModelApiKey,
      );

      const prompt = '''
      Analyze this image STRICTLY for a NATIONAL ID CARD only. Reject any other card type.

      NATIONAL ID IDENTIFICATION:
      - Must have "National ID", "Identity Card", or similar title
      - Must have a national emblem/government logo
      - Must have a long numeric ID (typically 10-14 digits)
      - Must have holder's photo

      REJECT IMMEDIATELY IF:
      - It's a university/student card
      - It's a driver's license
      - It's any other document type
      - Photo is blurry or text is unreadable

      FOR VALID NATIONAL IDs ONLY, extract:
      1. FULL NAME:
         - Combine multi-line names in order
         - Remove titles (Mr./Mrs.)
         - Must have 2-5 name parts
      2. NATIONAL ID NUMBER:
         - Must be numeric only (10-14 digits)
         - Ignore any alphanumeric codes
      3. DATE OF BIRTH (YYYY-MM-DD format)

      VALIDATION:
      - Reject if any field is missing
      - Reject if ID number isn't numeric
      - Reject if date isn't valid

      Return JSON:
      {
        "is_valid_id": true/false,
        "name": "full name if valid",
        "id_number": "id number if valid",
        "date_of_birth": "date if valid",
        "rejection_reason": "detailed reason if invalid"
      }
      ''';

      final imageBytes = await imageFile.readAsBytes();
      final content = [
        Content.multi([TextPart(prompt), DataPart('image/jpeg', imageBytes)]),
      ];

      final response = await model.generateContent(content);

      if (response.text == null) {
        return NationalIdDto(
          idNumber: null,
          dateOfBirth: null,
          name: null,
          isValidNationalId: false,
          errorMessage: 'No response from AI model',
        );
      }

      final jsonString =
          response.text!.replaceAll('```json', '').replaceAll('```', '').trim();

      final jsonData = json.decode(jsonString) as Map<String, dynamic>;

      if (jsonData['is_valid_id'] != true) {
        return NationalIdDto(
          idNumber: null,
          dateOfBirth: null,
          name: null,
          isValidNationalId: false,
          errorMessage:
              jsonData['rejection_reason'] ?? 'Not a valid national ID',
        );
      }

      // Additional validation for ID number
      final idNumber = jsonData['id_number']?.toString();
      if (idNumber == null ||
          idNumber.length < 10 ||
          !idNumber.contains(RegExp(r'^\d+$'))) {
        return NationalIdDto(
          idNumber: null,
          dateOfBirth: null,
          name: null,
          isValidNationalId: false,
          errorMessage: 'Invalid ID number format',
        );
      }

      // Process and validate extracted data
      final rawName = jsonData['name']?.toString();
      final processedName =
          rawName?.replaceAll('\n', ' ').replaceAll(RegExp(r'\s+'), ' ').trim();

      final dateOfBirth = jsonData['date_of_birth']?.toString();

      if (processedName == null || dateOfBirth == null) {
        return NationalIdDto(
          idNumber: null,
          dateOfBirth: null,
          name: null,
          isValidNationalId: false,
          errorMessage: 'Missing required fields',
        );
      }

      return NationalIdDto(
        idNumber: idNumber,
        dateOfBirth: dateOfBirth,
        name: processedName,
        isValidNationalId: true,
        errorMessage: null,
      );
    } catch (e) {
      return NationalIdDto(
        idNumber: null,
        dateOfBirth: null,
        name: null,
        isValidNationalId: false,
        errorMessage: 'Processing error: ${e.toString()}',
      );
    }
  }

  Future<VehicleLicenseDto> extractDataFromVehicleLicense(
    File? imageFile,
  ) async {
    if (imageFile == null) {
      return VehicleLicenseDto(
        isValidLicense: false,
        errorMessage: 'No image provided',
      );
    }

    try {
      final model = GenerativeModel(
        model: Constants.aiModelVersion,
        apiKey: ApiConstants.aiModelApiKey,
      );

      const prompt = '''
      DOCUMENT VALIDATION INSTRUCTIONS:
      1. FIRST determine if this is a DRIVING LICENSE (not ID card, passport, or other document)
      2. ONLY proceed if you can clearly identify standard driving license features:
         - "Driving License" or similar title
         - License number field
         - Expiry date field
         - Driver photo area
         - Issuing authority markings
      3. REJECT immediately if:
         - Document says "National ID", "Passport", or other non-license text
         - No clear driving license features visible
         - Image is blurry or unreadable

      IF CONFIRMED AS DRIVING LICENSE, extract:
      - Driver's full name (in Arabic or English)
      - License number (8+ alphanumeric chars)
      - Expiry date (Gregorian format YYYY-MM-DD)
      - Issuing authority

      STRICT OUTPUT FORMAT (JSON):
      {
        "is_driving_license": boolean, // MUST be true to proceed
        "document_type": "driving_license" | "national_id" | "other",
        "driver_name": string | null,
        "license_number": string | null,
        "expiry_date": string | null,
        "issuing_authority": string | null,
        "rejection_reason": string // if rejected
      }

      IMPORTANT:
      - Return "is_driving_license": false for any non-license document
      - Be strict about document type verification
      ''';

      final imageBytes = await imageFile.readAsBytes();
      final content = [
        Content.multi([TextPart(prompt), DataPart('image/jpeg', imageBytes)]),
      ];

      final response = await model.generateContent(content);

      if (response.text == null) {
        return VehicleLicenseDto(
          isValidLicense: false,
          errorMessage: 'No response from AI model',
        );
      }

      final jsonString =
          response.text!.replaceAll('```json', '').replaceAll('```', '').trim();

      final jsonData = json.decode(jsonString) as Map<String, dynamic>;

      // First check if it's actually a driving license
      if (jsonData['is_driving_license'] != true) {
        return VehicleLicenseDto(
          isValidLicense: false,
          errorMessage:
              jsonData['rejection_reason'] ??
              'Document is not a driving license (detected as ${jsonData['document_type'] ?? 'unknown'})',
        );
      }

      // Additional validation
      final name = jsonData['driver_name']?.toString();
      final number = jsonData['license_number']?.toString();
      final expiry = jsonData['expiry_date']?.toString();

      if (name == null || number == null || expiry == null) {
        return VehicleLicenseDto(
          isValidLicense: false,
          errorMessage: 'Missing required license fields',
        );
      }

      // Validate license number format
      if (number.length < 6) {
        return VehicleLicenseDto(
          isValidLicense: false,
          errorMessage: 'Invalid license number (too short)',
        );
      }

      // Validate date format (basic check)
      if (!RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(expiry)) {
        return VehicleLicenseDto(
          isValidLicense: false,
          errorMessage: 'Invalid date format (required: YYYY-MM-DD)',
        );
      }

      return VehicleLicenseDto(
        isValidLicense: true,
        driverName: name,
        licenseNumber: number,
        dateOfExpiry: expiry,
        issuingAuthority: jsonData['issuing_authority']?.toString(),
      );
    } catch (e) {
      return VehicleLicenseDto(
        isValidLicense: false,
        errorMessage: 'Processing error: ${e.toString().split('\n').first}',
      );
    }
  }
}
