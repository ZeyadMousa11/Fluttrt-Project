

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/modules/login/login_screen.dart';
import 'package:shopapp/shared/bloc/cubit.dart';
import 'package:shopapp/shared/bloc/state.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/components/constantes.dart';
import 'package:shopapp/shared/network/local/cash_helper.dart';
import 'package:shopapp/shared/network/remoate/dio_helper.dart';
import 'package:shopapp/shared/network/remoate/end_point.dart';

class SettingScreen extends StatelessWidget
{
  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var phoneController=TextEditingController();
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopHomeCubit,ShopHomeStates>(
      listener: (context,state)
      {
      },
      builder: (context,state)
      {
        var model=ShopHomeCubit.get(context).profileModel;
        nameController.text=model!.data!.name!;
        emailController.text=model.data!.email!;
        phoneController.text=model.data!.phone!;
        return ConditionalBuilder(
          condition: ShopHomeCubit.get(context).profileModel!=null,
          builder: (context)=>
             Form(
              key: formKey,
              child: Scaffold(
                appBar: AppBar(),
                body: Column(
                  children:
                  [
                    if(state is LoadingUpdateUsersData)
                    LinearProgressIndicator(),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: defaultTextFormField(
                        controller: nameController,
                        type: TextInputType.name,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Your Name';
                          }
                        },
                        label: 'Name',
                        prefix: Icons.person,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: defaultTextFormField(
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
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: defaultTextFormField(
                        controller: phoneController,
                        type: TextInputType.phone,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Your phone';
                          }
                        },
                        label: 'Name',
                        prefix: Icons.phone,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: defaultButtons(
                        function: ()
                        {
                          if(formKey.currentState!.validate())
                            {
                              ShopHomeCubit.get(context).updateProfile(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text,
                              );
                            }
                        },
                        text: 'Update' ,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}