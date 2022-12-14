import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nike_snkrs_clone/features/authentication/authentication_repository_impl.dart';
import 'package:nike_snkrs_clone/features/database/database_repository_impl.dart';
import 'package:nike_snkrs_clone/models/user_model.dart';

part 'form_event.dart';
part 'form_state.dart';

class FormBloc extends Bloc<FormEvent, FormsValidate> {
  final AuthenticationRepository _authenticationRepository;
  final DatabaseRepository _databaseRepository;

  FormBloc(this._authenticationRepository, this._databaseRepository)
      : super(const FormsValidate(
          email: "example@snapspot.app",
          firstName: "Max",
          lastName: "Mustermann",
          dateOfBirth: "01.01.1999",
          gender: "Male",
          region: "Online",
          isEmailValid: true,
          isFirstNameValid: true,
          isLastNameValid: true,
          isDateOfBirthValid: true,
          isGenderValid: true,
          isRegionValid: true,
          isFormValid: false,
          isFormValidateFailed: false,
          isLoading: false,
          hasNewsletterSubscribed: false,
        )) {
    on<EmailChanged>(_onEmailChanged);
    on<FirstNameChanged>(_onFirstNameChanged);
    on<LastNameChanged>(_onLastNameChanged);
    on<DateOfBirthChanged>(_onDateOfBirthChanged);
    on<GenderChanged>(_onGenderChanged);
    on<RegionChanged>(_onRegionChanged);
    on<NewsletterSubscriptionChanged>(_onNewsletterSubscriptionChanged);
    on<FormSubmitted>(_onFormSubmitted);
    on<FormSucceeded>(_onFormSucceeded);
  }

  final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  bool _isEmailValid(String email) {
    return _emailRegExp.hasMatch(email);
  }

  bool _isFirstNameValid(String? firstName) {
    return firstName!.isNotEmpty;
  }

  bool _isLastNameValid(String? lastName) {
    return lastName!.isNotEmpty;
  }

  bool _isDateOfBirthValid(String? value) {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy');
    final String formatted = formatter.format(now);
    String str1 = value ?? "";
    List<String> str2 = str1.split('/');
    String month = str2.isNotEmpty ? str2[0] : '';
    String day = str2.length > 1 ? str2[1] : '';
    String year = str2.length > 2 ? str2[2] : '';

    bool state = false;

    if (value!.isEmpty) {
      return false;
    } else if (month.isNotEmpty && int.parse(month) > 13) {
      return false;
    } else if (day.isNotEmpty && int.parse(day) > 32) {
      return false;
    } else if (year.isNotEmpty && (int.parse(year) > int.parse(formatted))) {
      return false;
    } else if (year.isNotEmpty && (int.parse(year) < 1920)) {
      return false;
    }

    return state;
  }

  bool _isGenderValid(String? gender) {
    return gender!.toLowerCase() == "male" || gender.toLowerCase() == "female";
  }

  bool _isRegionValid(String? region) {
    return region!.isNotEmpty;
  }

  _onEmailChanged(EmailChanged event, Emitter<FormsValidate> emit) {
    emit(state.copyWith(
      isFormSuccessful: false,
      isFormValid: false,
      isFormValidateFailed: false,
      errorMessage: "",
      email: event.email,
      isEmailValid: _isEmailValid(event.email),
    ));
  }

  _onFirstNameChanged(FirstNameChanged event, Emitter<FormsValidate> emit) {
    emit(state.copyWith(
      isFormSuccessful: false,
      isFormValidateFailed: false,
      errorMessage: "",
      firstName: event.firstName,
      isFirstNameValid: _isFirstNameValid(event.firstName),
    ));
  }

  _onLastNameChanged(LastNameChanged event, Emitter<FormsValidate> emit) {
    emit(state.copyWith(
      isFormSuccessful: false,
      isFormValidateFailed: false,
      errorMessage: "",
      lastName: event.lastName,
      isLastNameValid: _isLastNameValid(event.lastName),
    ));
  }

  _onDateOfBirthChanged(DateOfBirthChanged event, Emitter<FormsValidate> emit) {
    emit(state.copyWith(
      isFormSuccessful: false,
      isFormValidateFailed: false,
      errorMessage: "",
      dateOfBirth: event.dateOfBirth,
      isDateOfBirthValid: _isDateOfBirthValid(event.dateOfBirth),
    ));
  }

  _onGenderChanged(GenderChanged event, Emitter<FormsValidate> emit) {
    emit(state.copyWith(
      isFormSuccessful: false,
      isFormValidateFailed: false,
      errorMessage: "",
      gender: event.gender,
      isGenderValid: _isGenderValid(event.gender),
    ));
  }

  _onRegionChanged(RegionChanged event, Emitter<FormsValidate> emit) {
    emit(state.copyWith(
      isFormSuccessful: false,
      isFormValidateFailed: false,
      errorMessage: "",
      region: event.region,
      isRegionValid: _isRegionValid(event.region),
    ));
  }

  _onNewsletterSubscriptionChanged(
      NewsletterSubscriptionChanged event, Emitter<FormsValidate> emit) {
    emit(state.copyWith(
      isFormSuccessful: false,
      isFormValidateFailed: false,
      errorMessage: "",
      hasNewsletterSubscribed: event.hasSubscribed,
    ));
  }

  _onFormSubmitted(FormSubmitted event, Emitter<FormsValidate> emit) async {
    UserModel user = UserModel(
      userId: null,
      email: state.email,
      firstName: state.firstName,
      lastName: state.lastName,
      dateOfBirth: state.dateOfBirth,
      gender: state.gender,
      region: state.region,
    );

    if (event.value == Status.signUp) {
    } else if (event.value == Status.signIn) {}
  }

  _updateUIAndSignUp(FormSubmitted event, Emitter<FormsValidate> emit,
      UserModel user, String password) async {
    emit(state.copyWith(
      errorMessage: "",
      isFormValid: _isEmailValid(state.email) &&
          _isFirstNameValid(state.firstName) &&
          _isLastNameValid(state.lastName) &&
          _isDateOfBirthValid(state.dateOfBirth) &&
          _isGenderValid(state.gender) &&
          _isRegionValid(state.region),
      isLoading: true,
    ));

    if (state.isFormValid) {
      try {
        UserCredential? authUser =
            await _authenticationRepository.signUp(user, password);
        UserModel updatedUser = user.copyWith(
          userId: authUser!.user!.uid,
          isVerified: authUser.user!.emailVerified,
        );

        await _databaseRepository.saveUserData(updatedUser);

        if (updatedUser.isVerified) {
          emit(state.copyWith(isLoading: false, errorMessage: ""));
        } else {
          emit(state.copyWith(
            isFormValid: false,
            errorMessage:
                "Please Verify your email, by clicking the link sent to you by mail",
            isLoading: false,
          ));
        }
      } on FirebaseAuthException catch (e) {
        emit(state.copyWith(
            isLoading: false, errorMessage: e.message, isFormValid: false));
      }
    } else {
      emit(state.copyWith(
          isLoading: false, isFormValid: false, isFormValidateFailed: true));
    }
  }

  _authenticateUser(FormSubmitted event, Emitter<FormsValidate> emit,
      UserModel user, String password) async {
    emit(state.copyWith(
      errorMessage: "",
      isFormValid: _isEmailValid(state.email),
      isLoading: true,
    ));

    if (state.isFormValid) {
      try {
        UserCredential? authUser =
            await _authenticationRepository.signIn(user, password);
        UserModel updatedUser =
            user.copyWith(isVerified: authUser!.user!.emailVerified);

        if (updatedUser.isVerified) {
          emit(state.copyWith(isLoading: false, errorMessage: ""));
        } else {
          emit(state.copyWith(
            isFormValid: false,
            errorMessage:
                "Please Verify your email, by clicking the link sent to you by mail",
            isLoading: false,
          ));
        }
      } on FirebaseAuthException catch (e) {
        emit(state.copyWith(
            isLoading: false, errorMessage: e.message, isFormValid: false));
      }
    } else {
      emit(state.copyWith(
          isLoading: false, isFormValid: false, isFormValidateFailed: true));
    }
  }

  _onFormSucceeded(FormSucceeded event, Emitter<FormsValidate> emi) {
    emit(state.copyWith(isFormSuccessful: true));
  }
}
