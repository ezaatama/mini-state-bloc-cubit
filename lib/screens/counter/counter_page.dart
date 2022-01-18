import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_cubit/cubit/counter_cubit.dart';
import 'package:state_cubit/shared/theme.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        margin: EdgeInsets.all(defaultMargin),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_outlined)),
                const Spacer(),
                Container(
                  margin: EdgeInsets.all(defaultMargin),
                  child: Center(
                      child: Text(
                    "Counter State",
                    style: blackTextStyle.copyWith(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  )),
                ),
                const Spacer()
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            BlocBuilder<CounterCubit, CounterState>(
              builder: (context, state) {
                return Text(
                  (state is CounterFilled) ? "${state.value}" : "-",
                  style: blackTextStyle.copyWith(
                      fontSize: 30, fontWeight: FontWeight.bold),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      context.read<CounterCubit>().counterDecrement(1);
                    },
                    icon: const Icon(Icons.horizontal_rule_outlined)),
                IconButton(
                    onPressed: () {
                      context.read<CounterCubit>().counterIncrement(1);
                    },
                    icon: const Icon(Icons.add))
              ],
            )
          ],
        ),
      )),
    );
  }
}
