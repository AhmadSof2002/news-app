import 'package:application/layout/news_app/cubit.dart';
import 'package:application/layout/news_app/states.dart';
import 'package:application/modules/search/search_Screen.dart';
import 'package:application/shared/components/components.dart';
import 'package:application/shared/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit()
        ..getBusniess()
        ..getSports()
        ..getScience(),
      child: BlocConsumer<NewsCubit, NewsStates>(
          listener: (context, NewsStates) {},
          builder: (context, state) {
            var cubit = NewsCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                title: Text('News App'),
                actions: [
                  IconButton(icon: const Icon(Icons.search), onPressed: () {
                    navigateTo(context, SearchScreen());
                  }),
                  IconButton(icon: const Icon(Icons.brightness_4), onPressed: () {
                    AppCubit.get(context).changeMode();
                  })

                ], 
              ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.changeBottomNavBar(index);
                },
                items: cubit.bottomItems,
              ),
              body: cubit.screens[cubit.currentIndex],
            );
          }),
    );
  }
}
