import 'dart:async';

import 'package:flutter/material.dart';
import 'package:state_cubit/shared/theme.dart';

class CountdownPage extends StatefulWidget {
  const CountdownPage({Key? key}) : super(key: key);

  @override
  State<CountdownPage> createState() => _CountdownPageState();
}

class _CountdownPageState extends State<CountdownPage> {
  int _counter = 59;
  Timer? _timer;

  void startTimer() {
    _counter = 59;

    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          _timer!.cancel();
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Spacer(),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_outlined)),
                Container(
                  margin: EdgeInsets.all(defaultMargin),
                  child: Center(
                      child: Text(
                    "Countdown State",
                    style: blackTextStyle.copyWith(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  )),
                ),
                const Spacer()
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("0 : $_counter"),
                const SizedBox(
                  width: 5,
                ),
                (_counter > 0)
                    ? const Text("")
                    : TextButton(
                        onPressed: () {
                          startTimer();
                        },
                        child: const Text("Kirim Kode"))
              ],
            )
          ],
        ),
      )),
    );
  }
}
