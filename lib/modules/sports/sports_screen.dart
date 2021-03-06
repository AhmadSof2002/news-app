import 'package:application/layout/news_app/cubit.dart';
import 'package:application/layout/news_app/states.dart';
import 'package:application/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
          var list = NewsCubit.get(context).sports;
         return  articleBuilder(list);
      });
      
  }

  
}