
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/categories_model.dart';
import 'package:shopapp/shared/bloc/cubit.dart';
import 'package:shopapp/shared/bloc/state.dart';
import 'package:shopapp/shared/components/components.dart';

class CateoGriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit,ShopHomeStates>(
      listener: (context, state)
      {},
      builder: (context,state)
      {
        return ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context,index)=> CategriosBuild(ShopHomeCubit.get(context).categories!.data!.dataList![index],),
            separatorBuilder: (context,index)=>myLine(),
            itemCount: ShopHomeCubit.get(context).categories!.data!.dataList!.length,
        );
      },
    );
  }

  Widget CategriosBuild(DataModel model,) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage(
              '${model.image}',
            ),
            height: 80,
            width: 80,
            fit: BoxFit.cover,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            '${model.name}',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios),
        ],
      ),
    );
  }
}
