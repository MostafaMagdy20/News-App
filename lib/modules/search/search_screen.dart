import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_course/shared/components/components.dart';
import 'package:flutter_course/shared/news_cubit/cubit.dart';
import 'package:flutter_course/shared/news_cubit/states.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var searchController = TextEditingController();

    return BlocConsumer<NewsCubit , NewsStates>(
      listener: (context , state) {},
      builder: (context , state)
      {

        var searchList = NewsCubit.get(context).search;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Search'
            ),
          ),
          body: Column(
            children:
            [
              Padding(
                padding: const EdgeInsets.only(top: 25 ,left: 25 ,right: 25 , bottom: 15),
                child: defaultTFF(
                    controller: searchController,
                    type: TextInputType.text,
                    label: 'Search',
                    tffColor: NewsCubit.get(context).isDark? Colors.white60 : Colors.black,
                    borderRadius: 30.0,
                    onchange: (value)
                    {
                      NewsCubit.get(context).getSearchData(value);
                    },
                    prefix: Icons.search,
                    validator: (value)
                    {
                      if(value!.isEmpty)
                      {
                        return 'Enter a word to search';
                      }
                    }
                ),
              ),
              Expanded(child: articleListBuilder(searchList, context , isSearch: true)),
            ],
          ),
        );
      },

    );
  }
}
