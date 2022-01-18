import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_cubit/bloc/auth_bloc.dart';
import 'package:state_cubit/screens/mainpage.dart';
import 'package:state_cubit/shared/theme.dart';

import 'homepage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  AuthBloc? authBloc;

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final msg = BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state is AuthError) {
        return Text(state.message!);
      } else if (state is AuthLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return Container();
      }
    });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBackgroundColor,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if(state is AuthSuccess){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Mainpage()), (route) => false);
          }else{
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: (Text("Login Failed"))));
          }
        },
        child: SafeArea(
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
                    Container(
                      child: msg,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        controller: username,
                        autofocus: false,
                        validator: (username) {
                          if(username!.isEmpty){
                            return "Username tidak boleh kosong";
                          }
                        },
                        decoration: InputDecoration(
                            hintText: "Username",
                            filled: true,
                            contentPadding:
                                const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        controller: password,
                        obscureText: true,
                        autofocus: false,
                        validator: (password) {
                          if(password!.isEmpty){
                            return "Password tidak boleh kosong";
                          }
                        },
                        decoration: InputDecoration(
                            hintText: "Password",
                            filled: true,
                            contentPadding:
                                const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          authBloc!.add(LoginButtonPressed(
                              username: username.text,
                              password: password.text));
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
                    )
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
