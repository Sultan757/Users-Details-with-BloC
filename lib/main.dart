import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:users_response_with_bloc/blocs/app_bloc.dart';
import 'package:users_response_with_bloc/blocs/user_events.dart';
import 'package:users_response_with_bloc/blocs/user_states.dart';
import 'package:users_response_with_bloc/repos/repositories.dart';

import 'models/user_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RepositoryProvider(
        create: (context) => UserRepository(),
        child: const Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            UserBloc(RepositoryProvider.of<UserRepository>(context))
              ..add(LoadUserEvent()),
        child: Scaffold(
            appBar: AppBar(title: const Text('Bloc Pattern')),
            body: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
              if (state is UserLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is UserLoadedState) {
                List<UserModel> userList = state.users;

                return ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Card(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: ListTile(
                                title: Text(userList[index].firstname),
                                subtitle: Text(userList[index].lastname),
                                trailing: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(userList[index].avatar),
                                ))),
                      );
                    });
              }
              return Container();
            })));
  }
}
