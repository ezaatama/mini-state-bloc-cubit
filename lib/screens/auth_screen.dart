import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_cubit/bloc/form_submission_status.dart';
import 'package:state_cubit/bloc/login_bloc.dart';
import 'package:state_cubit/repository/login_repository.dart';
import 'package:state_cubit/screens/admin_page.dart';
import 'package:state_cubit/screens/user_page.dart';
import 'package:state_cubit/shared/theme.dart';

class AuthScreen extends StatefulWidget {
  AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController username = TextEditingController();

  TextEditingController password = TextEditingController();

  bool _isObscure = true;

  LoginBloc? authBloc;

  @override
  void initState() {
    authBloc = BlocProvider.of<LoginBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBackgroundColor,
      body: SafeArea(
          child: _loginForm(),
      ),
    );
  }

  Widget _loginForm() {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is AdminSubmissionSuccess) {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const AdminPage()), (route) => false);
        }else if(formStatus is UserSubmissionSuccess){           
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const UserPage()), (route) => false);
        }else if(formStatus is SubmissionFailed){           
          _showSnackBar(context, formStatus.exception.toString(), Colors.red);
        }
      },
      child: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.all(defaultMargin),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login with JWT Using BloC",
                style: blackTextStyle.copyWith(
                    fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                height: 350,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: kWhiteColor,
                    boxShadow: [
                      BoxShadow(
                          color: kGreyColor.withOpacity(0.4),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: const Offset(0, 3))
                    ]),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Center(
                        child: Icon(
                          Icons.lock,
                          size: 40,
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    _usernameField(),
                    const SizedBox(
                      height: 20,
                    ),
                    _passwordField(),
                    const SizedBox(
                      height: 30,
                    ),
                    _loginButton()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _usernameField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: TextFormField(
            controller: username,
            autofocus: false,
            validator: (value) =>
                state.isValidUsername ? null : "Username is too short",
            onChanged: (value) => context
                .read<LoginBloc>()
                .add(LoginUsernameChanged(username: value)),
            decoration: InputDecoration(
                hintText: "Username",
                filled: true,
                contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
        );
      },
    );
  }

  Widget _passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: TextFormField(
            controller: password,
            obscureText: _isObscure,
            autofocus: false,
            validator: (value) =>
                state.isValidPassword ? null : "Password is too short",
            onChanged: (value) => context
                .read<LoginBloc>()
                .add(LoginPasswordChanged(password: value)),
            decoration: InputDecoration(
                hintText: "Password",
                filled: true,
                suffixIcon: IconButton(
                  onPressed: (){
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                }, icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility)),
                contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
        );
      },
    );
  }

  Widget _loginButton() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state.formStatus is FormSubmitting
            ? const CircularProgressIndicator()
            : Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<LoginBloc>().add(LoggedIn(username: username.text, password: password.text));
                    }
                  },
                  child: Text(
                    "Submit",
                    style: whiteTextStyle.copyWith(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18))),
                ),
              );
      },
    );
  }

  void _showSnackBar(BuildContext context, String message, Color bgColor) {
    final snackBar = SnackBar(content: Text(message, textAlign: TextAlign.center,), backgroundColor: bgColor,);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
