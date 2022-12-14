part of 'form_bloc.dart';

enum Status { signIn, signUp }

abstract class FormEvent extends Equatable {
  const FormEvent();

  @override
  List<Object?> get props => [];
}

class EmailChanged extends FormEvent {
  final String email;

  const EmailChanged(this.email);

  @override
  List<Object> get props => [];
}

class FirstNameChanged extends FormEvent {
  final String firstName;

  const FirstNameChanged(this.firstName);

  @override
  List<Object> get props => [];
}

class LastNameChanged extends FormEvent {
  final String lastName;

  const LastNameChanged(this.lastName);

  @override
  List<Object> get props => [];
}

class DateOfBirthChanged extends FormEvent {
  final String dateOfBirth;

  const DateOfBirthChanged(this.dateOfBirth);

  @override
  List<Object> get props => [];
}

class GenderChanged extends FormEvent {
  final String gender;

  const GenderChanged(this.gender);

  @override
  List<Object> get props => [];
}

class RegionChanged extends FormEvent {
  final String region;

  const RegionChanged(this.region);

  @override
  List<Object> get props => [];
}

class NewsletterSubscriptionChanged extends FormEvent {
  final bool hasSubscribed;

  const NewsletterSubscriptionChanged(this.hasSubscribed);

  @override
  List<Object> get props => [];
}

class FormSubmitted extends FormEvent {
  final Status value;
  const FormSubmitted({required this.value});

  @override
  List<Object> get props => [value];
}

class FormSucceeded extends FormEvent {
  const FormSucceeded();

  @override
  List<Object> get props => [];
}
