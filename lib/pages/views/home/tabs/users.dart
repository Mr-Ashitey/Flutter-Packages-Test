import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:packages_flutter/core/services/api_request.dart';
import '/core/viewModels/users_view_model.dart';

import '../../../../core/models/user_model.dart';

class Users extends StatelessWidget {
  final RequestApi? requestApi;

  const Users({Key? key, this.requestApi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UsersViewModel usersViewModel = UsersViewModel(requestApi!);

    return Scaffold(
      body: FutureBuilder<List<User>>(
        future: usersViewModel.getUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SpinKitDoubleBounce(
                color: Colors.black,
                size: 50.0,
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final User user = snapshot.data![index];
              return Card(
                elevation: 8,
                shadowColor: Colors.black,
                margin: const EdgeInsets.all(20),
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Colors.black, width: 1)),
                child: ListTile(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: Image.network(
                              user.avatar!,
                              height: 100,
                              width: 100,
                            ),
                            content: Text(user.email!),
                            actions: [
                              TextButton(
                                child: const Text('Close'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
                  },
                  leading: ClipOval(child: Image.network(user.avatar!)),
                  title: Text('${user.firstName!} ${user.lastName!}'),
                  subtitle: Text(user.email!),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
