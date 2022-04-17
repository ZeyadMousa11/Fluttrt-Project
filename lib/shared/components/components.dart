import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp/shared/bloc/cubit.dart';
import 'package:shopapp/shared/style/color.dart';

void navigateTo(context, Widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Widget,
    ));

void navigateToAndFinish(context, Widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => Widget,
    ),
      (route)
    {
      return false;
    }
);

Widget defaultTextFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function(String)? onSubmit,
  Function? onChange,
  Function()? onTap,
  bool isPassword = false,
  required String? Function(String?) validate,
  required String? label,
  required IconData? prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onFieldSubmitted: onSubmit as void Function(String)?,
      onChanged: onChange as void Function(String)?,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        helperStyle: TextStyle(color: Colors.grey),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Colors.grey[300]! ,
          )
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
              color: Colors.grey[300]! ,
        width: 2.0,
          ),
        ),
        contentPadding: EdgeInsets.all(0),
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: () {
            suffixPressed!();
          },
          icon: Icon(
            suffix,
          ),
        )
            : null,
        enabled: isClickable,
      ),
    );
Widget defaultButtons({
  double width = double.infinity,
 // Color color=HexColor('333739'),
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 0,
        ),
        child: MaterialButton(
          color: defaultColors,
          onPressed: () {
            function();
          },
          child: Text(
            text.toUpperCase(),
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );

void showToast({
  required String text,
  required ToastStates state,
})=>
Fluttertoast.showToast(
msg: text,
toastLength: Toast.LENGTH_LONG,
gravity: ToastGravity.BOTTOM,
timeInSecForIosWeb: 5,
backgroundColor: choseToastColor(state),
textColor: Colors.white,
fontSize: 16.0,
);
enum ToastStates {success,error,warning}
Color choseToastColor(ToastStates state)
{
  Color color;
  switch(state)
  {
    case ToastStates.success:
      color=Colors.green;
      break;
    case ToastStates.warning:
      color=Colors.amber;
      break;
    case ToastStates.error:
      color=Colors.red;
      break;
  }
  return color;
}
Widget myLine() => Padding(
  padding: const EdgeInsets.symmetric(
    horizontal: 10,
  ),
  child: Container(
    width: double.infinity,
    height: 1,
    color: Colors.grey,
  ),
);

Widget favItem(models, context, {bool isOldPrice = true}) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(models.image!),
                  width: 120,
                  height: 120,
                ),
                if (models.discount != 0&&isOldPrice)
                  Container(
                    color: Colors.red,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        'Discount',
                        style: TextStyle(
                          fontSize: 8,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    models.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(height: 1.3),
                  ),
                  Row(
                    children: [
                      Text(
                        '${models.price.toString()}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: defaultColors,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      if (models.discount != 0&&isOldPrice)
                        Text(
                          '${models.oldPrice.toString()}',
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const Spacer(),
                      IconButton(
                        icon: CircleAvatar(
                          radius: 15,
                          backgroundColor:
                              ShopHomeCubit.get(context).favorites[models.id]!
                                  ? defaultColors
                                  : Colors.grey[500],
                          child: const Icon(
                            Icons.favorite_outline,
                            size: 15,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          ShopHomeCubit.get(context)
                              .changeFavorites(models.id!);

                          print(models.id);
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );