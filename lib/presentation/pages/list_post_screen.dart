import 'package:clean_architecture/common/custom_error.dart';
import 'package:clean_architecture/common/custom_loading.dart';
import 'package:clean_architecture/domain/entities/list_post_entity.dart';
import 'package:clean_architecture/presentation/cubit/list_post/list_post_cubit.dart';
import 'package:clean_architecture/presentation/cubit/list_post/list_post_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_architecture/injection.dart' as git;
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListPostScreen extends StatelessWidget {
  const ListPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Post', style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black
        ),),
        backgroundColor: Colors.white70,
      ),
      body: BlocProvider(
          create: (_) => git.locator<ListPostCubit>()..getPostList(),
          child: BlocBuilder<ListPostCubit, ListPostState>(
            builder: (context, state) {
              if(state is ListPostLoaded) {
                return SmartRefresher(
                  controller: ListPostCubit.controller,
                  enablePullDown: true,
                  enablePullUp: true,
                  onRefresh: () => context.read<ListPostCubit>()..getRefresh(),
                  onLoading: () => context.read<ListPostCubit>()..getLoadMore(),
                  child: ListView.builder(
                    itemCount: state.list.length,
                    itemBuilder: (context, index) {
                      ListPostEntity data = state.list[index];
                      return Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(6),
                        child: Row(
                          children: [
                            Image.network(
                              data.image,
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(width: 10,),
                            Expanded(child: Text(data.text))
                          ],
                        ),
                      );
                    }
                  ),
                );
              } else if(state is ListPostError) {
                return CustomError(messsage: state.message);
              }
              return CustomLoading();
            },
          ),
        ),
    );
  }
}