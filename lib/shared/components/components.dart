import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_course/modules/web%20view/web_view_screen.dart';
import 'package:flutter_course/shared/news_cubit/cubit.dart';
import 'package:flutter_course/shared/news_cubit/states.dart';
import 'package:hexcolor/hexcolor.dart';

Widget defaultButton({
  double width = double.infinity,
  required String text,
  bool isupper = true,
  Color color = Colors.green,
  required VoidCallback function,
  double radius = 0.0,
}) =>
    Container(
      height: 40.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
      ),
      width: width,
      child: MaterialButton(
        child: Text(
          isupper ? text.toUpperCase() : text,
          style: TextStyle(color: Colors.white),
        ),
        onPressed: function,
      ),
    );

Widget defaultTFF({
  Color tffColor = Colors.green,
  Color textColor = Colors.green,
  required TextEditingController controller,
  required TextInputType type,
  double borderRadius = 0.0,
  required String label,
  bool obscure = false,
  required IconData prefix,
  IconData? suffix,
  VoidCallback? suffixOnpressd,
  required Function(String?) validator,
  Function(String)? onchange,
  VoidCallback? onTap,
}) =>
    TextFormField(
      style: TextStyle(color: tffColor),
      validator: (String? value) => validator(value),
      onChanged: onchange,
      onTap: onTap,
      cursorColor: tffColor,
      controller: controller,
      keyboardType: type,
      obscureText: obscure,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: tffColor,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: tffColor),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: tffColor),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: tffColor),
            borderRadius: BorderRadius.circular(borderRadius)),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: tffColor),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        labelText: label,
        labelStyle: TextStyle(color: tffColor),
        prefixIcon: Icon(
          prefix,
          color: tffColor,
        ),
        suffixIcon: IconButton(
          onPressed: suffixOnpressd,
          icon: Icon(
            suffix,
            color: tffColor,
          ),
        ),
      ),
    );


Widget buildArticleItem(article, context) => BlocConsumer<NewsCubit , NewsStates>(
  listener: (context , state) {},
  builder: (context , state)
  {
    return GestureDetector(
      onTap: ()
      {
        navigateTo(context, WebViewScreen(article['url']));
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              width: 130.0,
              height: 130.0,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2 ,
                  color: NewsCubit.get(context).isDark? Colors.white : Colors.black,
                ),
                borderRadius: BorderRadius.circular(60.0),
                image: article['urlToImage'] != null
                    ? DecorationImage(
                  image: NetworkImage('${article['urlToImage']}'),
                  fit: BoxFit.cover,
                )
                    : const DecorationImage(
                  image: AssetImage('assets/images/Image_not_available.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Container(
                height: 130.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        style: Theme.of(context).textTheme.bodyLarge,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  },
);

Widget articleListBuilder(article , context , {isSearch = false})
{
  return BlocConsumer<NewsCubit , NewsStates>(
    listener: (context , state) {},
    builder: (context , state)
    {
      return ConditionalBuilder(
        condition: article.isNotEmpty,
        builder: (context) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildArticleItem(article[index], context),
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10.0),
              child: NewsCubit.get(context).isDark
                  ? Container(
                height: 1.0,
                color: Colors.white,
              )
                  : Container(
                height: 1.0,
                color: Colors.black,
              ),
            ),
            itemCount: article.length
        ),
        fallback: (context) => isSearch ? Container() : NewsCubit.get(context).isDark ? Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            )) : Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            )),
      );
    },
  );
}

void navigateTo(context , widget) => Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => widget
    )
);




