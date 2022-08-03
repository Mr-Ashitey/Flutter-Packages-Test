import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '/core/viewModels/users_view_model.dart';

import '../../../../core/models/user_model.dart';

class Users extends StatelessWidget {
  const Users({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<User>>(
        future: UsersViewModel().getUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SpinKitDoubleBounce(
                color: Theme.of(context).primaryColor,
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
                shadowColor: Theme.of(context).primaryColor,
                margin: const EdgeInsets.all(20),
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1)),
                child: ListTile(
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
