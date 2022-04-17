import 'package:shopapp/modules/login/login_screen.dart';
import 'package:shopapp/shared/bloc/cubit.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/components/constantes.dart';
import 'package:shopapp/shared/network/local/cash_helper.dart';

void printFullText(String text)
{
  final pattern=RegExp('.{1800}');
  pattern.allMatches(text).forEach((match)=>print(match.group(0)));
}
String? token='';

void signOut(context) {
  CashHelper.removeData(key: 'token');
  token = null;
  var model = ShopHomeCubit
      .get(context)
      .profileModel;
  model!.data!.name = '';
  model.data!.phone = '';
  model.data!.email = '';
  navigateToAndFinish(context, LoginScreen());
  ShopHomeCubit.get(context).currentIndex=0;
}