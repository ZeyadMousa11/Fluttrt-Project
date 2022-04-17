
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/modules/cateogries/cateogries_screen.dart';
import 'package:shopapp/modules/search/search_screen.dart';
import 'package:shopapp/modules/setting/setting_screen.dart';
import 'package:shopapp/shared/bloc/cubit.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/components/constantes.dart';
import 'package:shopapp/shared/style/color.dart';

import '../../layout/home_layout.dart';

class setting_1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var model = ShopHomeCubit
        .get(context)
        .profileModel!
        .data;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Hello, ${model!.name}',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Spacer(),
              IconButton(
                color: defaultColors,
                onPressed: () {
                  signOut(context);
                },
                icon: Icon(
                  Icons.logout,
                ),
              ),
            ],
          ),
        ),
        settingItem(
            Icons.person,
            'Update Profile',
            ()
          {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingScreen()));
          },
        ),
      ],
    );
  }
  Widget settingItem(IconData icon,String title,Function function)
  {
    return InkWell(
      onTap: ()=>function(),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          color: Colors.grey[200]!.withOpacity(0.2),
          child: Row(
            children: [
              CircleAvatar(
                child: Icon(
                  icon,
                  color: Colors.white,
                ),
                radius: 30,
                backgroundColor: defaultColors,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                title,
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),
              ),
              Spacer(),
              Icon(Icons.arrow_forward_ios_outlined)
            ],
          ),
        ),
      ),
    );
  }
}