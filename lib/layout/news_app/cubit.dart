import 'package:application/layout/news_app/states.dart';
import 'package:application/modules/bussiness/bussiness_screen.dart';
import 'package:application/modules/science/science_screen.dart';
import 'package:application/modules/settings_screen/settings_screen.dart';
import 'package:application/modules/sports/sports_screen.dart';
import 'package:application/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Busniess'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    SettingsScreen()
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;

    emit(NewsChangeBottomNavState());
  }

  List<dynamic> busniess = [];

  void getBusniess() {
    if (busniess.length == 0) {
      emit(NewsGetBusniessLoadingState());
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'us',
        'category': 'business',
        'apiKey': '8e0e8ffe13c34df0a4eb1870ce325b03',
      }).then((value) {
        busniess = value.data['articles'];
        print(busniess[0]['title']);

        emit(NewsGetBusniessSuccessState());
      }).catchError((onError) {
        print(onError.toString());
        emit(NewsGetBusniessErrorState(onError.toString()));
      });
    } else {
      emit(NewsGetBusniessSuccessState());
    }
  }

  List<dynamic> sports = [];

  void getSports() {
    if (sports.length == 0) {
      emit(NewsGetSportsLoadingState());
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'us',
        'category': 'sports',
        'apiKey': '8e0e8ffe13c34df0a4eb1870ce325b03',
      }).then((value) {
        sports = value.data['articles'];
        print(sports[0]['title']);
        emit(NewsGetSportsSuccessState());
      }).catchError((onError) {
        print(onError.toString());
        emit(NewsGetSportsErrorState(onError.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> science = [];

  void getScience() {
    if (science.length == 0) {
      emit(NewsGetScienceLoadingState());
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'us',
        'category': 'science',
        'apiKey': '8e0e8ffe13c34df0a4eb1870ce325b03',
      }).then((value) {
        science = value.data['articles'];
        print(sports[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((onError) {
        print(onError.toString());
        emit(NewsGetScienceErrorState(onError.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  List<dynamic> search = [];

  void getSearch(String value) {
    emit(NewsGetSearchLoadingState());
    search = [];

    DioHelper.getData(url: 'v2/everything', query: {
      'q': '$value',
      'apiKey': '8e0e8ffe13c34df0a4eb1870ce325b03',
    }).then((value) {
      search = value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(NewsGetSearchErrorState(onError.toString()));
    });
  }
}
