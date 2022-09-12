// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:packages_flutter/core/viewModels/auth_view_model.dart';
import 'package:packages_flutter/pages/views/home/tabs/resources/resources.dart';
import 'package:packages_flutter/pages/views/home/tabs/users/users.dart';
import 'package:provider/provider.dart';

import '../../../helpers/constants.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  static const routeName = homeRoute;
  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          actions: [
            IconButton(
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: const Text('Logout'),
                          content:
                              const Text('Are you sure you want to logout?'),
                          actions: [
                            TextButton(
                              child: const Text('No'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text('Yes',
                                  style: TextStyle(color: Colors.red)),
                              onPressed: () async {
                                await context.read<AuthViewModel>().logout();
                                Navigator.pushNamedAndRemoveUntil(
                                    context, loginRoute, (route) => false);
                              },
                            ),
                          ],
                        );
                      });
                },
                icon: const Icon(Icons.logout_rounded))
          ],
          bottom: TabBar(
            isScrollable: false,
            onTap: (index) => currentIndex = index,
            indicatorColor: Colors.white,
            tabs: const [
              Tab(icon: Icon(Icons.people_alt_rounded)),
              Tab(icon: Icon(Icons.inventory_rounded)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [Users(), Resources()],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            if (currentIndex == 0) {
              Navigator.pushNamed(context, addUserRoute);
              return;
            }
            Navigator.pushNamed(context, addResourceRoute);
          },
        ),
      ),
    );
  }
}
