import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp/models/categories_model.dart';
import 'package:shopapp/models/home_model.dart';
import 'package:shopapp/shared/bloc/cubit.dart';
import 'package:shopapp/shared/bloc/state.dart';
import 'package:shopapp/shared/style/color.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit, ShopHomeStates>(
        listener: (context, state)
        {
          if(state is ShopSuccessChangeFavState)
          {
            if(!state.model.status!)
            {
              Fluttertoast.showToast(
                  msg: state.model.message!,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            }
          }
        },
        builder: (context, state) {
          return ConditionalBuilder(
            condition: ShopHomeCubit.get(context).homeModel != null &&
                ShopHomeCubit.get(context).categories != null,
            builder: (context) => productsBuilder(
                ShopHomeCubit.get(context).homeModel!,
                ShopHomeCubit.get(context).categories!,context),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        });
  }

  Widget productsBuilder(HomeModel model, CategoriesModel categories,context) =>
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model.data?.banners
                  ?.map((e) => Image(
                        image: NetworkImage('${e.image}'),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              options: CarouselOptions(
                height: 250,
                initialPage: 0,
                viewportFraction: 1,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
             Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Categories',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) =>
                      CateogriesItem(categories.data!.dataList![index]),
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 10,
                  ),
                  itemCount: categories.data!.dataList!.length,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Products',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                childAspectRatio: 1 / 1.72,
                children: List.generate(
                  model.data!.products!.length,
                  (index) => buildItem(model.data!.products![index],context),
                ),
              ),
            ),
          ],
        ),
      );

  Widget CateogriesItem(DataModel model) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage(
              '${model.image}',
            ),
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          Container(
            width: 100,
            color: Colors.black.withOpacity(0.8),
            child: Text(
              '${model.name}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      );

  Widget buildItem(ProductsModel model,context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image!),
                  width: double.infinity,
                  height: 200,
                ),
                if (model.discount != 0)
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
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                model.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(height: 1.3),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              child: Row(
                children: [
                  Text(
                    '${model.price.round()!}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: defaultColors,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  if (model.discount != 0)
                    Text(
                      '${model.oldPrice.round()!}',
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
                      backgroundColor: ShopHomeCubit.get(context).favorites[model.id]! ? defaultColors:Colors.grey[500],
                      child: const Icon(
                        Icons.favorite_outline,
                        size: 15,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: ()
                    {
                      ShopHomeCubit.get(context).changeFavorites(model.id!);
                      print(model.id);
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      );
}