import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_course/modules/business/business_screen.dart';
import 'package:flutter_course/modules/science/science_screen.dart';
import 'package:flutter_course/modules/sport/sports_screen.dart';
import 'package:flutter_course/shared/network/local/cache_helper.dart';
import 'package:flutter_course/shared/network/remote/dio_helper.dart';
import 'package:flutter_course/shared/news_cubit/states.dart';


class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 1;

  List<Widget> screens =
  [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen()
  ];

  void changeBottomNavBar(index)
  {
    currentIndex = index;

    emit(NewsBottomNavBarStates());
  }

  List<dynamic> business = [];

  void getBusinessData()
  {
    emit(NewsGetBusinessLoadingStates());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query:
        {
          'country':'eg',
          'category':'business',
          'apiKey':'9dfd9d9f852a49fd9b20c2b6b3f2d1cd'
        }
    ).then((value)
    {
      business = value.data['articles'];
      emit(NewsGetBusinessSuccessStates());
    }).catchError((error)
    {
      print(error.toString());
      emit(NewsGetBusinessErrorStates(error.toString()));
    });
  }

  List<dynamic> sports = [];

  void getSportsData()
  {

    emit(NewsGetSportsLoadingStates());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query:
        {
          'country':'eg',
          'category':'sports',
          'apiKey':'9dfd9d9f852a49fd9b20c2b6b3f2d1cd'
        }
    ).then((value)
    {
      sports = value.data['articles'];
      emit(NewsGetSportsSuccessStates());
    }).catchError((error)
    {
      print(error.toString());
      emit(NewsGetSportsErrorStates(error.toString()));
    });
  }

  List<dynamic> science = [];

  void getScienceData()
  {
    emit(NewsGetScienceLoadingStates());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query:
        {
          'country':'eg',
          'category':'science',
          'apiKey':'9dfd9d9f852a49fd9b20c2b6b3f2d1cd'
        }
    ).then((value)
    {
      science = value.data['articles'];
      emit(NewsGetScienceSuccessStates());
    }).catchError((error)
    {
      print(error.toString());
      emit(NewsGetScienceErrorStates(error.toString()));
    });
  }

  List<dynamic> search = [];

  void getSearchData(String value)
  {
    search = [];
    emit(NewsGetSearchLoadingStates());

    DioHelper.getData(
        url: 'v2/everything',
        query:
        {
          'q':value,
          'apiKey':'9dfd9d9f852a49fd9b20c2b6b3f2d1cd'
        }
    ).then((value)
    {
      search = value.data['articles'];
      emit(NewsGetSearchSuccessStates());
    }).catchError((error)
    {
      print(error.toString());
      emit(NewsGetSearchErrorStates(error.toString()));
    });
  }

  bool isDark = false;
  void changeAppMode({bool? fromCache})
  {
    if(fromCache != null)
    {
      isDark = fromCache;
      emit(ChangeAppMode());
    } else
    {
      isDark = !isDark;
      CacheHelper.putDate(key: 'isDark', value: isDark).then((value)
      {
        emit(ChangeAppMode());
      });
    }
  }


}