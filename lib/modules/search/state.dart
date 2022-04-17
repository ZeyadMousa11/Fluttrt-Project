abstract class SearchStates{}
class SearchInitialState extends SearchStates{}

class ShopLoadingSearchState extends SearchStates{}
class ShopSuccessSearchState extends SearchStates {}
class ShopErrorSearchState extends SearchStates
{
   final error;
  ShopErrorSearchState(this.error);
}