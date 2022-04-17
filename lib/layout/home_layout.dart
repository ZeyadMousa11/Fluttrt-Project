
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/modules/search/search_screen.dart';
import 'package:shopapp/shared/bloc/state.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/style/color.dart';
import '../shared/bloc/cubit.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ShopHomeCubit, ShopHomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit=ShopHomeCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                      'Salla',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 30,
                      ),
                    ),
              actions: [
                IconButton(
                  onPressed: ()
                  {
                    navigateTo(context, SearchScreen());
                  },
                  icon: Icon(
                      Icons.search,
                  ),
                ),
              ],
            ),
            body: cubit.bottomScreens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index)
              {
                cubit.changeBottom(index);
              },
              currentIndex: cubit.currentIndex,
              items:const [
                BottomNavigationBarItem(
                    icon: Icon(
                        Icons.home,
                    ),
                  label: 'Home',
                  ),
                BottomNavigationBarItem(
                    icon: Icon(
                        Icons.apps,
                    ),
                  label: 'Cateogries',
                  ),
                BottomNavigationBarItem(
                    icon: Icon(
                        Icons.favorite,
                    ),
                  label: 'Favorites',
                  ),
                BottomNavigationBarItem(
                    icon: Icon(
                        Icons.settings,
                    ),
                  label: 'Setting',
                  ),
              ],
            ),
          );
        });
  }
}
