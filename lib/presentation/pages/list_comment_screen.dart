import 'package:clean_architecture/common/custom_error.dart';
import 'package:clean_architecture/common/custom_loading.dart';
import 'package:clean_architecture/domain/entities/list_comment_entity.dart';
import 'package:clean_architecture/presentation/cubit/list_comment/list_comment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:clean_architecture/injection.dart' as git;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListCommentScreen extends StatelessWidget {
  const ListCommentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Comment', style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black
        ),),
        backgroundColor: Colors.white70,
      ),
      body: BlocProvider(
        create: (_) => git.locator<ListCommentCubit>()..getCommentList(),
        child: BlocBuilder<ListCommentCubit, ListCommentState>(
          builder: (context, state) {
            if(state is ListCommentLoaded) {
              return SmartRefresher(
                controller: ListCommentCubit.controller,
                enablePullDown: true,
                enablePullUp: true,
                onRefresh: () => context.read<ListCommentCubit>()..getRefresh(),
                onLoading: () => context.read<ListCommentCubit>()..getLoadMore(),
                child: ListView.builder(
                    itemCount: state.list.length,
                    itemBuilder: (context, index) {
                      ListCommentEntity data = state.list[index];
                      return Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '${data.owner.firstName} ${data.owner.lastName}', 
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Expanded(child: Text(data.publishDate))
                              ],
                            ),
                            Text(data.message, style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400
                            ),)
                          ],
                        ),
                      );
                    }
                  ),
              );
            } else if(state is ListCommentError) {
              return CustomError(messsage: state.message);
            }
            return CustomLoading();
          }
        ),
      ),
    );
  }
}