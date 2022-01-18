import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_cubit/cubit/bottom_nav_cubit.dart';
import 'package:state_cubit/shared/theme.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({ Key? key, required this.index, required this.icon }) : super(key: key);

  final int index;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.read<BottomNavCubit>().setPage(index);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          Icon(
            icon,
            size: 24,
            color: context.watch<BottomNavCubit>().state == index ? kPrimaryColor : kGreyColor,
          ),
          Container(
            width: 30,
            height: 2,
            decoration: BoxDecoration(
              color: context.watch<BottomNavCubit>().state == index ? kPrimaryColor : kTransparentColor, borderRadius: BorderRadius.circular(18)
            ),
          )
        ],
      ),
    );
  }
}