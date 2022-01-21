import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_cubit/cubit/bottom_nav_cubit.dart';
import 'package:state_cubit/shared/theme.dart';
import 'package:state_cubit/widgets/customBottomNav.dart';

import 'quran_page.dart';
import 'homepage.dart';
import 'movie_page.dart';
import 'settings_page.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({ Key? key }) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, int>(builder: (context, currentIndex){
        return Scaffold(
          backgroundColor: kBackgroundColor,
          body: Stack(
            children: [
              _buildContext(currentIndex), customBottomNav()
            ],
          ),
        );
    });
  }

  Widget _buildContext(int currentIndex){
    switch(currentIndex){
      case 0:
        return const Homepage();
      case 1:
        return const SettingPage();
      case 2:
        return  MoviePage();
      case 3:
        return const QuranPage();
      default:
        return const Homepage();
    }
  }

  Widget customBottomNav(){
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        height: 60,
        margin: EdgeInsets.only(
          bottom: 30, left: defaultMargin, right: defaultMargin 
        ),
        decoration: BoxDecoration(
          color: kWhiteColor, borderRadius: BorderRadius.circular(18)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            CustomBottomNavigation(index: 0, icon: Icons.home_outlined),
            CustomBottomNavigation(index: 1, icon: Icons.settings),
            CustomBottomNavigation(index: 2, icon: Icons.movie_creation_outlined),
            CustomBottomNavigation(index: 3, icon: Icons.bookmarks)
          ],
        ),
      ),
    );
  }
}