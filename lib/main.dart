import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/modules/login/login_screen.dart';
import 'package:shopapp/shared/bloc/bloc_observer.dart';
import 'package:shopapp/shared/bloc/cubit.dart';
import 'package:shopapp/shared/bloc/state.dart';
import 'package:shopapp/shared/network/local/cash_helper.dart';
import 'package:shopapp/shared/network/remoate/dio_helper.dart';
import 'package:shopapp/shared/style/themes.dart';
import 'layout/home_layout.dart';
import 'modules/on_boarding/on_boarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CashHelper.init();
  bool onBoarding = CashHelper.getData(key: 'onBoard');
  String token = CashHelper.getData(key: 'token');
  print(token);

  Widget widget;
  if (onBoarding != null) {
    if (token != null) {
      widget = HomeScreen();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }
  BlocOverrides.runZoned(
    () {
      runApp(MyApp(
        startWidget: widget,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  MyApp({required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:
      [
        BlocProvider(
          create: (context)=> ShopHomeCubit()
        ..getHomData()
        ..getProfile()
        ..getFavorites()
        ..getCategoriesData(),
        ),
      ],
    child: BlocConsumer<ShopHomeCubit,ShopHomeStates>(
      listener: (context,state)=>{},
      builder: (context,state)=>MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        home: startWidget,
      ),
    ),
    );
  }
}
