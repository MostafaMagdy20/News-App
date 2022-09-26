import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_course/shared/components/components.dart';
import 'package:flutter_course/shared/news_cubit/cubit.dart';
import 'package:flutter_course/shared/news_cubit/states.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<NewsCubit , NewsStates>(
      listener: (context , state){} ,
      builder: (context , state)
      {
        var article = NewsCubit.get(context).sports;

        return articleListBuilder(article , context);
      },
    );
  }
}
