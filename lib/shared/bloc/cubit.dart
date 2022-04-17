
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/changefavorites_model.dart';
import 'package:shopapp/models/home_model.dart';
import 'package:shopapp/models/login_model.dart';
import 'package:shopapp/models/profile_model.dart';
import 'package:shopapp/modules/cateogries/cateogries_screen.dart';
import 'package:shopapp/modules/proudects/proudcts_screen.dart';
import 'package:shopapp/modules/setting/setting%20_1.dart';
import 'package:shopapp/modules/setting/setting_screen.dart';
import 'package:shopapp/shared/bloc/state.dart';
import 'package:shopapp/shared/components/constantes.dart';
import 'package:shopapp/shared/network/local/cash_helper.dart';
import 'package:shopapp/shared/network/remoate/dio_helper.dart';
import 'package:shopapp/shared/network/remoate/end_point.dart';
import '../../models/categories_model.dart';
import '../../models/favorites_model.dart';
import '../../modules/favourites/favourites_screen.dart';


class ShopHomeCubit extends Cubit<ShopHomeStates> {
  ShopHomeCubit() : super(ShopHomeInitialState());

  static ShopHomeCubit get(context) => BlocProvider.of(context);

  int currentIndex=0;
  List<Widget>bottomScreens=
  [
    ProductsScreen(),
    CateoGriesScreen(),
    FavoritesScreen(),
    setting_1(),
  ];
  void changeBottom(int index)
  {
    currentIndex=index;
    emit(ChangeBottomNavState());
  }
     HomeModel? homeModel;
  Map<int,bool>favorites={};
  void getHomData()
  {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(url:HOME,token: token).then((value) {
      homeModel=HomeModel.fromJson(value.data);
      homeModel?.data?.products?.forEach((element) {
        favorites.addAll({
          element.id!:element.inFavorites!,
        });
        // print(favorites.toString());
      });
      emit(ShopSuccessHomeDataState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorHomeDataState(error.toString()));
    });
  }
  CategoriesModel? categories;
  void getCategoriesData()
  {
    emit(ShopLoadingCategoriesDataState());
    DioHelper.getData(url: GET_CATEORGIES,token: token).then((value)
    {
      categories=CategoriesModel.fromJson(value.data);
     // printFullText(categories?.data);
      emit(ShopSuccessCategoriesDataState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorCategoriesDataState(error.toString()));
    });
  }
  ChangeFavModel? changeFavModel;
  void changeFavorites(int productId)
  {
    favorites[productId]=!favorites[productId]!;
    emit(ShopChangeFavState());

    DioHelper.postData(
        url: FAVORITES, 
      data: {
          'product_id':productId,
      },
      token: CashHelper.getData(key: 'token'),
    ).then((value) {
      changeFavModel=ChangeFavModel.fromjson(value.data);
      print(value.data);
      if(!changeFavModel!.status!)
        {
          favorites[productId]=!favorites[productId]!;
        }else
          {
            getFavorites();
          }
      emit(ShopSuccessChangeFavState(changeFavModel!));
    }).catchError((error){
      favorites[productId]=!favorites[productId]!;
      emit(ShopErrorChangeFavState(error.toString()));
    });
  }

  FavModels? favModels;
  void getFavorites()
  {
    emit(ShopLoadingFavState());

    DioHelper.getData(
      url: FAVORITES,
      token:CashHelper.getData(key: 'token'),
    ).then((value)
    {
      favModels = FavModels.fromJson(value.data);
      //printFullText(favModels!.data!.data.toString());
      emit(ShopSuccessGetFavState());

    }).catchError((e)
    {
      print(e.toString());
      emit(ShopErrorGetFavState(e.toString()));
    });
  }

   ProfileModel? profileModel;
  void getProfile(){
    emit(LoadingGetProfilesData());
    DioHelper.getData(url: PROFILE, token:CashHelper.getData(key: 'token') ).then((value){
      profileModel = ProfileModel.fromJson(value.data);
      emit(SuccessGetProfileData(profileModel!));
    }).catchError((error){
      print(error.toString());
      emit(ErrorGetProfileData());
    });
  }

  void updateProfile({
  required String name,
  required String email,
  required String phone,
}){
    emit(LoadingUpdateUsersData());
    DioHelper.putData(
        url: UPDATE_PROFILE,
        token:CashHelper.getData(key: 'token'),
      data: {
          'name':name,
        'email':email,
        'phone':phone,
      }
    ).then((value){
      profileModel = ProfileModel.fromJson(value.data);
      emit(SuccessUpdateUserData(profileModel!));
    }).catchError((error){
      print(error.toString());
      emit(ErrorUpdateUserData());
    });
  }
}