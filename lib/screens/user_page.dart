import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_cubit/cubit/bottom_nav_cubit.dart';
import 'package:state_cubit/screens/homepage.dart';
import 'package:state_cubit/screens/movie_page.dart';
import 'package:state_cubit/screens/quran_page.dart';
import 'package:state_cubit/shared/theme.dart';
import 'package:state_cubit/widgets/customBottomNav.dart';

class UserPage extends StatefulWidget {
  const UserPage({ Key? key }) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
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
        return  MoviePage();
      case 2:
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
            CustomBottomNavigation(index: 2, icon: Icons.movie_creation_outlined),
            CustomBottomNavigation(index: 3, icon: Icons.bookmarks)
          ],
        ),
      ),
    );
  }
}