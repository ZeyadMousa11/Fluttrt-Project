import 'dart:ui';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/home_layout.dart';
import 'package:shopapp/modules/login/cubit_login/cubit.dart';
import 'package:shopapp/modules/login/cubit_login/state.dart';
import 'package:shopapp/shared/bloc/cubit.dart';
import 'package:shopapp/shared/components/constantes.dart';
import 'package:shopapp/shared/network/local/cash_helper.dart';
import 'package:shopapp/shared/style/color.dart';
import '../../shared/components/components.dart';
import '../register/reggister_screen.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state)
        {
          if(state is ShopLoginSuccessState)
            {
              if(state.loginModel.status!)
                {
                  CashHelper.saveData(key: 'token', value: state.loginModel.data!.token!).then((value)
                  {
                    token=state.loginModel.data!.token!;
                    ShopHomeCubit.get(context).getHomData();
                    ShopHomeCubit.get(context).getCategoriesData();
                    ShopHomeCubit.get(context).getFavorites();
                    ShopHomeCubit.get(context).getProfile();
                    navigateToAndFinish(context, HomeScreen());
                  });
                }else
                  {
                    print(state.loginModel.message);
                    showToast(
                        text: state.loginModel.message!,
                        state: ToastStates.error,
                    );
                  }
            }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text(
                          'LOGIN',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: defaultColors,
                          ),
                        ),
                        const Text(
                          'login now to browse our ho offers',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultTextFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Email Address';
                            }
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultTextFormField(
                          suffixPressed: () {
                            ShopLoginCubit.get(context).changeIconPassword();
                          },
                          isPassword: ShopLoginCubit.get(context).isPassword,
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter your Password';
                            }
                          },
                          label: 'password',
                          prefix: Icons.lock_open_outlined,
                          suffix: ShopLoginCubit.get(context).suffix,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingStat,
                          builder: (context) => defaultButtons(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            text: 'LOGIN',
                          ),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have an account?'),
                            TextButton(
                              onPressed: () {
                                navigateTo(context,  RegisterScreen());
                              },
                              child: const Text(
                                'register',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
