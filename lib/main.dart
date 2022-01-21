import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_cubit/bloc/login_bloc.dart';
import 'package:state_cubit/cubit/bottom_nav_cubit.dart';
import 'package:state_cubit/cubit/counter_cubit.dart';
import 'package:state_cubit/cubit/movie_cubit.dart';
import 'package:state_cubit/cubit/quran_cubit.dart';
import 'package:state_cubit/repository/login_repository.dart';
import 'package:state_cubit/repository/movie_repository.dart';
import 'package:state_cubit/repository/quran_repository.dart';
import 'package:state_cubit/screens/auth_screen.dart';
import 'package:state_cubit/services/movie_services.dart';
import 'package:state_cubit/services/quran_services.dart';


void main() {
  runApp(const MyApp());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  WidgetsFlutterBinding.ensureInitialized();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return 
    // RepositoryProvider(create: (context) => LoginRepository(),
    MultiBlocProvider(
      providers: [
        // BlocProvider(create: (context) => AuthBloc(AuthInitial(), AuthRepository())),
        BlocProvider(create: (context) => LoginBloc(loginRepo: LoginRepository()),),
        BlocProvider(create: (context) => BottomNavCubit()),
        BlocProvider(create: (context) => MovieCubit(repository: MovieRepository(MovieService()))),
        BlocProvider(create: (context) => QuranCubit(repository: QuranRepository(QuranService()))),
        BlocProvider(create: (context) => CounterCubit())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: Mainpage(),
        home: AuthScreen(),
      ),
    );
  }
}
