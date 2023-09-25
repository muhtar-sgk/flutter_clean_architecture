import 'package:clean_architecture/common/custom_error.dart';
import 'package:clean_architecture/common/custom_loading.dart';
import 'package:clean_architecture/common/my_route.dart';
import 'package:clean_architecture/domain/entities/list_user_entity.dart';
import 'package:clean_architecture/presentation/cubit/list_user/list_user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_architecture/injection.dart' as git;
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListUserScreen extends StatelessWidget {
  const ListUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List User', style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black
        ),),
        backgroundColor: Colors.white70,
      ),
      body: BlocProvider(
          create: (_) => git.locator<ListUserCubit>()..getUserList(),
          child: BlocBuilder<ListUserCubit, ListUserState>(
            builder: (context, state) {
              if(state is ListUserLoaded) {
                return SmartRefresher(
                  controller: ListUserCubit.controller,
                  enablePullDown: true,
                  enablePullUp: true,
                  onRefresh: () => context.read<ListUserCubit>()..getRefresh(),
                  onLoading: () => context.read<ListUserCubit>()..getLoadMore(),
                  child: ListView.builder(
                    itemCount: state.list.length,
                    itemBuilder: (context, index) {
                      ListUserEntity data = state.list[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context, 
                            MyRoute.detailUser,
                            arguments: {
                              'id': data.id
                            }
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(6),
                          child: Row(
                            children: [
                              Image.network(
                                data.picture,
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(width: 10,),
                              Expanded(child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data.title, style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600
                                  ),),
                                  Text('${data.firstName} ${data.lastName}', style: TextStyle(
                                    fontSize: 16
                                  ),),
                                ],
                              ))
                            ],
                          ),
                        ),
                      );
                    }
                  ),
                );
              } else if(state is ListUserError) {
                return CustomError(messsage: state.message);
              }
              return CustomLoading();
            },
          ),
      ),
    );
  }
}