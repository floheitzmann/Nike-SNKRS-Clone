part of 'form_bloc.dart';

abstract class FormState extends Equatable {
  const FormState();
}

class FormInitial extends FormState {
  @override
  List<Object?> get props => [];
}

class FormsValidate extends FormState {
  const FormsValidate({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.gender,
    required this.region,
    required this.isEmailValid,
    required this.isFirstNameValid,
    required this.isLastNameValid,
    required this.isDateOfBirthValid,
    required this.isGenderValid,
    required this.isRegionValid,
    required this.isFormValid,
    required this.isFormValidateFailed,
    required this.isLoading,
    required this.hasNewsletterSubscribed,
    this.isFormSuccessful = false,
    this.errorMessage = "",
  });

  final String email;
  final String firstName;
  final String lastName;
  final String dateOfBirth;
  final String gender;
  final String region;
  final bool isEmailValid;
  final bool isFirstNameValid;
  final bool isLastNameValid;
  final bool isDateOfBirthValid;
  final bool isGenderValid;
  final bool isRegionValid;
  final bool isFormValid;
  final bool isFormValidateFailed;
  final bool isLoading;
  final bool hasNewsletterSubscribed;
  final String errorMessage;
  final bool isFormSuccessful;

  FormsValidate copyWith({
    String? email,
    String? firstName,
    String? lastName,
    String? dateOfBirth,
    String? gender,
    String? region,
    bool? isEmailValid,
    bool? isFirstNameValid,
    bool? isLastNameValid,
    bool? isDateOfBirthValid,
    bool? isGenderValid,
    bool? isRegionValid,
    bool? isFormValid,
    bool? isFormValidateFailed,
    bool? isLoading,
    bool? hasNewsletterSubscribed,
    bool? isFormSuccessful,
    String? errorMessage,
  }) {
    return FormsValidate(
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      region: region ?? this.region,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isFirstNameValid: isFirstNameValid ?? this.isFirstNameValid,
      isLastNameValid: isLastNameValid ?? this.isLastNameValid,
      isDateOfBirthValid: isDateOfBirthValid ?? this.isDateOfBirthValid,
      isGenderValid: isGenderValid ?? this.isGenderValid,
      isRegionValid: isRegionValid ?? this.isRegionValid,
      isFormValid: isFormValid ?? this.isFormValid,
      isFormValidateFailed: isFormValidateFailed ?? this.isFormValidateFailed,
      isLoading: isLoading ?? this.isLoading,
      hasNewsletterSubscribed:
          hasNewsletterSubscribed ?? this.hasNewsletterSubscribed,
    );
  }

  @override
  List<Object?> get props => [
        email,
        firstName,
        lastName,
        dateOfBirth,
        gender,
        region,
        isEmailValid,
        isFirstNameValid,
        isLastNameValid,
        isDateOfBirthValid,
        isGenderValid,
        isRegionValid,
        isFormValid,
        isFormValidateFailed,
        isFormSuccessful,
        isLoading,
        hasNewsletterSubscribed,
        errorMessage,
      ];
}
