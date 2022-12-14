import 'package:country/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_snkrs_clone/features/authentication/bloc/authentication_bloc.dart';
import 'package:nike_snkrs_clone/features/form-validation/bloc/form_bloc.dart';
import 'package:nike_snkrs_clone/ui/select_country_view.dart';
import 'package:nike_snkrs_clone/utils/birth_date_validator.dart';
import 'package:nike_snkrs_clone/utils/utils.dart';

var border =
    const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey));

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<FormBloc, FormsValidate>(
          listener: (context, state) {
            if (state.errorMessage.isNotEmpty) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: Text(state.errorMessage),
                ),
              );
            } else if (state.isFormValid && !state.isLoading) {
              context.read<AuthenticationBloc>().add(AuthenticationStarted());
              context.read<FormBloc>().add(const FormSucceeded());
            } else if (state.isFormValidateFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("error"),
                ),
              );
            }
          },
        ),
        BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationSuccess) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const Scaffold(backgroundColor: Colors.green),
                ),
              );
            }
          },
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/swoosh-logo-dark.png",
                      height: 18,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "BECOME A NIKE MEMBER",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Create your Nike Member profile and get first access to the very best of Nike products, inspiration and community.",
              style: TextStyle(color: Colors.grey.shade600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            _EmailField(),
            const SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                hintText: "Password",
              ),
            ),
            const SizedBox(height: 12),
            _FirstNameField(),
            const SizedBox(height: 12),
            _LastNameField(),
            const SizedBox(height: 12),
            _DateOfBirthField(),
            const SizedBox(height: 8),
            Text(
              "Get a Nike Member Reward every year on your Birthday.",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            _RegionField(),
            const SizedBox(height: 16),
            Text("Preferred Products"),
            const SizedBox(height: 12),
            Row(
              children: [
                _GenderField(true),
                SizedBox(width: 16),
                _GenderField(false),
              ],
            ),
            SizedBox(height: 20),
            _NewsletterSubscriptionField(),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: "By creating an account, you agree to Nike's "),
                    TextSpan(
                      text: "Privacy Policy",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    TextSpan(text: " and "),
                    TextSpan(
                      text: "Terms of Use",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    TextSpan(text: "."),
                  ],
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(
                  const Size(double.infinity, 48),
                ),
                backgroundColor: MaterialStateColor.resolveWith(
                  (states) => Colors.black,
                ),
              ),
              child: const Text("JOIN US"),
            ),
            const SizedBox(height: kBottomNavigationBarHeight),
          ],
        ),
      ),
    );
  }
}

class _EmailField extends StatelessWidget {
  const _EmailField();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormBloc, FormsValidate>(
      builder: (context, state) {
        return TextField(
          onChanged: (value) {
            context.read<FormBloc>().add(EmailChanged(value));
          },
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            border: border,
            hintText: "Email address",
            errorText: !state.isEmailValid
                ? "Please ensure the email entered is valid"
                : null,
          ),
        );
      },
    );
  }
}

class _FirstNameField extends StatelessWidget {
  const _FirstNameField();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormBloc, FormsValidate>(
      builder: (context, state) {
        return TextField(
          onChanged: (value) {
            context.read<FormBloc>().add(FirstNameChanged(value));
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            border: border,
            hintText: "First Name",
            errorText:
                !state.isFirstNameValid ? "First Name cannot be empty!" : null,
          ),
        );
      },
    );
  }
}

class _LastNameField extends StatelessWidget {
  const _LastNameField();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormBloc, FormsValidate>(
      builder: (context, state) {
        return TextField(
          onChanged: (value) {
            context.read<FormBloc>().add(LastNameChanged(value));
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            border: border,
            hintText: "Last Name",
            errorText:
                !state.isLastNameValid ? "Last Name cannot be empty!" : null,
          ),
        );
      },
    );
  }
}

class _DateOfBirthField extends StatelessWidget {
  const _DateOfBirthField();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormBloc, FormsValidate>(
      builder: (context, state) {
        return TextFormField(
          keyboardType: TextInputType.phone,
          validator: (value) => Utils.birthDateValidator(value),
          inputFormatters: [
            LengthLimitingTextInputFormatter(10),
            FilteringTextInputFormatter.singleLineFormatter,
            BirthTextInputFormatter(),
          ],
          onChanged: (value) {
            context.read<FormBloc>().add(DateOfBirthChanged(value));
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            border: border,
            hintText: "Date of Birth",
            errorText: !state.isDateOfBirthValid
                ? Utils.birthDateValidator(state.dateOfBirth)
                : null,
          ),
        );
      },
    );
  }
}

class _RegionField extends StatelessWidget {
  const _RegionField();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormBloc, FormsValidate>(
      builder: (context, state) {
        return InkWell(
          borderRadius: BorderRadius.circular(4),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SelectCountryView(),
              ),
            ).then((value) {
              if (value != null) {
                int index = value;
                Country country = Countries.values[index];

                context.read<FormBloc>().add(RegionChanged(country.alpha2));
              }
            });
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                width: 1,
                color: Colors.grey,
              ),
            ),
            child: Text(
              Utils.getCountryFromAlpha2(state.region)?.isoShortName ?? "None",
              style: const TextStyle(
                fontSize: 17,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _GenderField extends StatelessWidget {
  const _GenderField(this.isMen);

  final bool isMen;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormBloc, FormsValidate>(
      builder: (context, state) {
        return Expanded(
          child: InkWell(
            borderRadius: BorderRadius.circular(4),
            onTap: () {
              context
                  .read<FormBloc>()
                  .add(GenderChanged(isMen ? "men" : "women"));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(color: _getCorrectColor(state)),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                isMen ? "Men's" : "Women's",
                style: TextStyle(color: _getCorrectColor(state)),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      },
    );
  }

  Color _getCorrectColor(FormsValidate state) {
    return (state.gender == "men" && isMen) ||
            (state.gender == "women" && isMen == false)
        ? Colors.black
        : Colors.grey;
  }
}

class _NewsletterSubscriptionField extends StatelessWidget {
  const _NewsletterSubscriptionField();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormBloc, FormsValidate>(
      builder: (context, state) {
        return Row(
          children: [
            Checkbox(
              value: state.hasNewsletterSubscribed,
              onChanged: (value) {
                context
                    .read<FormBloc>()
                    .add(NewsletterSubscriptionChanged(value ?? false));
              },
            ),
            Expanded(
              child: Text(
                "Sign up for emails to get updates from Nike on products, offers, and your Member benefits",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
