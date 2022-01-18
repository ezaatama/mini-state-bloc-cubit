import 'package:flutter/material.dart';
import 'package:state_cubit/screens/counter/counter_page.dart';
import 'package:state_cubit/shared/theme.dart';

import 'countdown/countdown_page.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        margin: EdgeInsets.all(defaultMargin),
        width: double.infinity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///Countdown
                    _title("Countdown State"),
                    _button(
                        () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CountdownPage())),
                        "Countdown"),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///Counter
                    _title("Counter State"),
                    _button(
                        () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CounterPage())),
                        "Counter")
                  ],
                )
              ],
            )
          ],
        ),
      )),
    );
  }

  Widget _button(
    Function() onTap,
    String title,
  ) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(primary: kPrimaryColor),
        onPressed: onTap,
        child: Text(
          title,
          style: whiteTextStyle.copyWith(fontSize: 14),
        ));
  }

  Widget _title(String title) {
    return Container(
      child: Center(
          child: Text(
        title,
        style:
            blackTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.bold),
      )),
    );
  }
}
