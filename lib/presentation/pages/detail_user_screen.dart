import 'package:clean_architecture/common/custom_error.dart';
import 'package:clean_architecture/common/custom_loading.dart';
import 'package:clean_architecture/domain/entities/detail_user_entity.dart';
import 'package:clean_architecture/presentation/cubit/detail_user/detail_user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:clean_architecture/injection.dart' as git;
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailUserScreen extends StatelessWidget {
  const DetailUserScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail User', style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black
        ),),
        backgroundColor: Colors.white70,
      ),
      body: BlocProvider(
          create: (_) => git.locator<DetailUserCubit>()..getUserDetail(id),
          child: BlocBuilder<DetailUserCubit, DetailUserState>(
            builder: (context, state) {
              if(state is DetailUserLoaded) {
                DetailUserEntity data = state.detailUserEntity;

                return Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
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
                                    Text(data.gender, style: TextStyle(
                                      fontSize: 16
                                    ),),
                                    Text(data.email, style: TextStyle(
                                      fontSize: 16
                                    ),),
                                    Text(data.dateOfBirth, style: TextStyle(
                                      fontSize: 16
                                    ),),
                                  ],
                                ))
                              ],
                            ),
                            SizedBox(height: 16,),
                            Text('Location', style: TextStyle(
                                      fontSize: 16
                                    ),),
                            Text(data.location.state, style: TextStyle(
                                      fontSize: 16
                                    ),),
                            Text(data.location.timezone, style: TextStyle(
                                      fontSize: 16
                                    ),),
                            Text(data.location.city, style: TextStyle(
                                      fontSize: 16
                                    ),),
                            Text(data.location.street, style: TextStyle(
                                      fontSize: 16
                                    ),),
                          ],
                        ),
                      );
              } else if(state is DetailUserError) {
                return CustomError(messsage: state.message);
              }
              return CustomLoading();
            },
          ),
      )
    );
  }
}