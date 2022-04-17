

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/search_model.dart';
import 'package:shopapp/shared/components/constantes.dart';
import '../../shared/network/remoate/dio_helper.dart';
import '../../shared/network/remoate/end_point.dart';
import 'state.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;
  void search(String text)
  {
    emit(ShopLoadingSearchState());
    DioHelper.postData(
      url: SEARCH,
      token:token,
      data: {
        'text':text,
      },
    ).then((value) {
      searchModel=SearchModel.fromJson(value.data);
      emit(ShopSuccessSearchState());
    }).catchError((error){
      emit(ShopErrorSearchState(error.toString()));
      print(error.toString());
    });
  }
}