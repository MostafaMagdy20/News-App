import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_course/layout/News%20Home/News_home.dart';
import 'package:flutter_course/shared/bloc_observer.dart';
import 'package:flutter_course/shared/network/local/cache_helper.dart';
import 'package:flutter_course/shared/network/remote/dio_helper.dart';
import 'package:flutter_course/shared/news_cubit/cubit.dart';
import 'package:flutter_course/shared/news_cubit/states.dart';
import 'package:hexcolor/hexcolor.dart';


void main() async
{
  // بيتأكد ان كل حاجه ف ال main خلصت الاول وبعد كده يفتح الابليكيشن (يعنى يشغل runApp(MyApp))
  WidgetsFlutterBinding.ensureInitialized();
  //------------------------------------------------------------------------
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool isDark = CacheHelper.getDate(key: 'isDark');

  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget
{

  final bool isDark;

  MyApp(this.isDark);

  @override
  Widget build(BuildContext context)
  {
    return MultiBlocProvider(
      providers:
      [
        BlocProvider(create: (context) => NewsCubit()..getBusinessData()..getSportsData()..getScienceData()..changeAppMode(fromCache: isDark)),
      ],
      child: BlocConsumer<NewsCubit , NewsStates>(
        listener: (context , state) => {},
        builder: (context , state)
        {
          return MaterialApp(
              theme: ThemeData(
                textTheme: TextTheme(
                  bodyLarge: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: const AppBarTheme(
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                  ),
                  color: Colors.white,
                  titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                  ),
                  centerTitle: false,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(30),
                    ),
                  ),
                  iconTheme: IconThemeData(
                      color: Colors.black
                  ),
                ),
                // bottomNavigationBarTheme: BottomNavigationBarThemeData(
                //   backgroundColor: HexColor('D9B44A'),
                //   elevation: 50.0,
                //   type: BottomNavigationBarType.fixed,
                //   selectedItemColor: HexColor('4F6457'),
                //   unselectedItemColor: HexColor('4F6457'),
                //   showUnselectedLabels: false
                // ),
              ),
              darkTheme: ThemeData(
                textTheme: TextTheme(
                  bodyLarge: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                scaffoldBackgroundColor: Colors.black,
                appBarTheme: const AppBarTheme(
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.black,
                    ),
                    color: Colors.black,
                    titleTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                    ),
                    centerTitle: false,
                    elevation: 5.0,
                    shadowColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(30),
                      ),
                    ),
                    iconTheme: IconThemeData(
                        color: Colors.white
                    )
                ),
                // bottomNavigationBarTheme: BottomNavigationBarThemeData(
                //   backgroundColor: HexColor('D9B44A'),
                //   elevation: 50.0,
                //   type: BottomNavigationBarType.fixed,
                //   selectedItemColor: HexColor('4F6457'),
                //   unselectedItemColor: HexColor('4F6457'),
                //   showUnselectedLabels: false
                // ),
              ),
              themeMode: NewsCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
              debugShowCheckedModeBanner: false,
              home: NewsHome()
          );
        },
      ),
    );
  }

}


