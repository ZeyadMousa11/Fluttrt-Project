import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/home_layout.dart';
import 'package:shopapp/modules/register/cubit.dart';
import 'package:shopapp/modules/register/state.dart';
import 'package:shopapp/shared/bloc/cubit.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/components/constantes.dart';
import 'package:shopapp/shared/network/local/cash_helper.dart';
import 'package:shopapp/shared/style/color.dart';

class RegisterScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.registerModel.status!) {

              CashHelper.saveData(
                      key: 'token', value: state.registerModel.data?.token)
                  .then((value) {
                token=state.registerModel.data!.token!;
                ShopHomeCubit.get(context).getHomData();
                ShopHomeCubit.get(context).getCategoriesData();
                ShopHomeCubit.get(context).getFavorites();
                ShopHomeCubit.get(context).getProfile();
                navigateToAndFinish(context, HomeScreen());
                navigateToAndFinish(context, HomeScreen());
              });
            } else {
              print(state.registerModel.message);
              showToast(
                text: state.registerModel.message!,
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
                          'REGISTER',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: defaultColors,
                          ),
                        ),
                        const Text(
                          'register now to browse our ho offers',
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
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter your name';
                            }
                          },
                          label: 'User name',
                          prefix: Icons.person,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultTextFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your phone';
                            }
                          },
                          label: 'phone',
                          prefix: Icons.phone,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultTextFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter your Email';
                            }
                          },
                          label: 'Email',
                          prefix: Icons.email_outlined,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultTextFormField(
                          suffixPressed: () {
                            ShopRegisterCubit.get(context).changeIconPassword();
                          },
                          isPassword: ShopRegisterCubit.get(context).isPassword,
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter your Password';
                            }
                          },
                          label: 'password',
                          prefix: Icons.lock_open_outlined,
                          suffix: ShopRegisterCubit.get(context).suffix,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingStat,
                          builder: (context) => defaultButtons(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                ShopRegisterCubit.get(context).userRegister(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            text: 'REGISTER',
                          ),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 15,
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
