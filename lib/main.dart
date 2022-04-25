import 'package:application/layout/news_app/news_layout.dart';
import 'package:application/shared/cubit/cubit.dart';
import 'package:application/shared/cubit/states.dart';
import 'package:application/shared/network/local/cache_helper.dart';
import 'package:application/shared/network/remote/dio_helper.dart';
import 'package:application/styles/bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getBoolean(key: 'isDark');
  isDark = false;
  runApp(MyApp(isDark!));
}

class MyApp extends StatelessWidget {
  bool isDark = false;
  MyApp(this.isDark, {Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          AppCubit()..changeMode(fromShared: isDark),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            themeMode: cubit.isDark == true ? ThemeMode.dark : ThemeMode.light,
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                  titleSpacing: 20.0,
                  iconTheme: IconThemeData(color: Colors.black),
                  backwardsCompatibility: false,
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  systemOverlayStyle:
                      SystemUiOverlayStyle(statusBarColor: Colors.white),
                  titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              primarySwatch: Colors.deepOrange,
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  elevation: 20.0,
                  backgroundColor: Colors.white),
              textTheme: TextTheme(
                  bodyText1: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600)),
            ),
            darkTheme: ThemeData(
              scaffoldBackgroundColor: Colors.black,
              appBarTheme: AppBarTheme(
                  titleSpacing: 20.0,
                  iconTheme: IconThemeData(color: Colors.white),
                  backwardsCompatibility: false,
                  backgroundColor: Colors.black,
                  elevation: 0.0,
                  systemOverlayStyle:
                      SystemUiOverlayStyle(statusBarColor: Colors.black),
                  titleTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              primarySwatch: Colors.deepOrange,
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  unselectedItemColor: Colors.grey,
                  backgroundColor: Colors.black,
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  elevation: 20.0),
              textTheme: TextTheme(
                  bodyText1: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600)),
            ),
            home: NewsLayout(),
          );
        },
      ),
    );
  }
}
