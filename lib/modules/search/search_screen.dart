
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/modules/search/cubit.dart';
import 'package:shopapp/modules/search/state.dart';
import 'package:shopapp/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  var formKey=GlobalKey<FormState>();
  var searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (BuildContext context)=>SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context,state) {},
        builder: (context,state)
        {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultTextFormField(
                        controller: searchController,
                        type: TextInputType.text,
                        validate: (value){
                          if(value!.isEmpty)
                            {
                              return 'Please Enter Text To Search';
                            }
                          return null;
                        },
                      onSubmit: (String text)
                      {
                        SearchCubit.get(context).search(text);
                      },
                        label: 'Search',
                        prefix: Icons.search,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if(state is ShopLoadingSearchState)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 10,
                    ),
                    if(state is ShopSuccessSearchState)
                    Expanded(
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => favItem(
                            SearchCubit.get(context)
                                .searchModel!
                                .data!
                                .data[index],
                            context,
                          isOldPrice: false,
                        ),
                        separatorBuilder: (context, index) => Container(
                          height: 1,
                          width: 1,
                          color: Colors.grey,
                        ),
                        itemCount:
                        SearchCubit.get(context).searchModel!.data!.data.length,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}