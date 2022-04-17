import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/shared/bloc/cubit.dart';
import 'package:shopapp/shared/bloc/state.dart';
import 'package:shopapp/shared/components/components.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<ShopHomeCubit, ShopHomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
            condition: state is! ShopLoadingFavState,
            builder:(context)=> ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => favItem(ShopHomeCubit.get(context).favModels!.data!.dataList[index].product,context),
              separatorBuilder: (context, index) =>
                  Container(
                    height: 1,
                    width: 1,
                    color: Colors.grey,
                  ),
              itemCount:ShopHomeCubit.get(context).favModels!.data!.dataList.length,
            ),
            fallback:(context)=> Center(child: CircularProgressIndicator()),
          );
        }
    );
  }
}