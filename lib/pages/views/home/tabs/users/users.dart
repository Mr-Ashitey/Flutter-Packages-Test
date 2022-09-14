import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:packages_flutter/core/viewModels/users_provider/users_view_model.dart';

import 'package:provider/provider.dart';

import '../../../../../core/models/user_model.dart';

class Users extends StatefulWidget {
  const Users({Key? key}) : super(key: key);

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    final usersViewModel = context.read<UsersViewModel>();

    return Scaffold(
      body: LiquidPullToRefresh(
        onRefresh: () {
          setState(() {});
          return Future.microtask(() => null);
        },
        backgroundColor: Colors.white,
        color: Colors.black,
        showChildOpacityTransition: false,
        animSpeedFactor: 5,
        springAnimationDurationInMilliseconds: 500,
        child: FutureBuilder(
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      snapshot.error.toString(),
                      style: const TextStyle(fontSize: 20),
                    ),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.refresh_rounded),
                      onPressed: () => setState(() {}),
                      label: const Text('Retry again'),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              itemCount: context.watch<UsersViewModel>().users.length,
              itemBuilder: (context, index) {
                final User user = context.watch<UsersViewModel>().users[index];
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
                    leading: ClipOval(
                        child: Image.network(
                      user.avatar ?? '',
                      errorBuilder: (context, error, stackTrace) {
                        return Container();
                      },
                    )),
                    title: Text('${user.firstName!} ${user.lastName!}'),
                    subtitle: Text(user.email ?? ''),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
