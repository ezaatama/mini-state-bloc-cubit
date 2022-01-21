import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_cubit/bloc/login_bloc.dart';
import 'package:state_cubit/screens/auth_screen.dart';
import 'package:state_cubit/shared/theme.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final LoginBloc authenticationBloc = BlocProvider.of<LoginBloc>(context);
    
    return Scaffold(
      body: SafeArea(
          child: Container(
        margin: EdgeInsets.all(defaultMargin),
        child: Column(
          children: [
            Text("Fetching BloC"),
            ElevatedButton(
                onPressed: () {
                  
                },
                child: Text("Nested API")),
            Text("Logout"),
            ElevatedButton(
                onPressed: () {
                  authenticationBloc.add(LoggedOut());
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => AuthScreen()), (route) => false);
                },
                child: Text("Logout"))
          ],
        ),
      )),
    );
  }
}
