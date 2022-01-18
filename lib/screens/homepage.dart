import 'package:flutter/material.dart';
import 'package:state_cubit/shared/theme.dart';


class Homepage extends StatelessWidget {
  const Homepage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(defaultMargin),
          child: Column(
            children: [
              Text("Fetching BloC"),
              ElevatedButton(onPressed: (){;
              }, child: Text("Nested API"))
            ],
          ),
        )
      ),
    );
  }
}