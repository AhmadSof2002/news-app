import 'package:application/layout/news_app/cubit.dart';
import 'package:application/layout/news_app/states.dart';
import 'package:application/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var list = NewsCubit.get(context).search;
          return Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: defaultFormField(
                      controller: searchController,
                      type: TextInputType.text,
                      label: 'Search',
                      prefix: Icons.search,
                      onChanged: (value){
                        NewsCubit.get(context).getSearch(value);
                      },
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'must not be empty';
                        }
                        return null;
                      }),
                )
              ],
            ),
          );
        });
  }
}
