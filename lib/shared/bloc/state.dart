import 'package:shopapp/models/changefavorites_model.dart';
import 'package:shopapp/models/profile_model.dart';

abstract class ShopHomeStates {}

class ShopHomeInitialState extends ShopHomeStates {}

class ChangeBottomNavState extends ShopHomeStates {}

class ShopLoadingHomeDataState extends ShopHomeStates {}

class ShopSuccessHomeDataState extends ShopHomeStates {}

class ShopErrorHomeDataState extends ShopHomeStates
{
  final String error;
  ShopErrorHomeDataState(this.error);
}
class ShopLoadingCategoriesDataState extends ShopHomeStates {}

class ShopSuccessCategoriesDataState extends ShopHomeStates {}

class ShopErrorCategoriesDataState extends ShopHomeStates
{
  final String error;
  ShopErrorCategoriesDataState(this.error);
}


class ShopSuccessChangeFavState extends ShopHomeStates
{
   ChangeFavModel model;
  ShopSuccessChangeFavState(this.model);
}
class ShopChangeFavState extends ShopHomeStates{}
class ShopErrorChangeFavState extends ShopHomeStates
{
  String e;
  ShopErrorChangeFavState(this.e);
}

class ShopLoadingFavState extends ShopHomeStates{}
class ShopSuccessGetFavState extends ShopHomeStates {}
class ShopErrorGetFavState extends ShopHomeStates {
  String e;
  ShopErrorGetFavState(this.e);
}

class LoadingGetProfilesData extends ShopHomeStates{}
class SuccessGetProfileData extends ShopHomeStates
{
  final ProfileModel profileModel;
  SuccessGetProfileData(this.profileModel);
}
class ErrorGetProfileData extends ShopHomeStates{}

class LoadingUpdateUsersData extends ShopHomeStates{}
class SuccessUpdateUserData extends ShopHomeStates
{
  final ProfileModel profileModel;
  SuccessUpdateUserData(this.profileModel);
}
class ErrorUpdateUserData extends ShopHomeStates{}