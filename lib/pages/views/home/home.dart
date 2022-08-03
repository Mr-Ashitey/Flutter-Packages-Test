// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:packages_flutter/core/viewModels/auth_view_model.dart';

import '../../../constants.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  static const routeName = homeRoute;
  @override
  Widget build(BuildContext context) {
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
                              child: const Text('Yes'),
                              onPressed: () async {
                                await AuthViewModel().logout();
                                Navigator.pushReplacementNamed(
                                    context, loginRoute);
                              },
                            ),
                          ],
                        );
                      });
                },
                icon: const Icon(Icons.logout_rounded))
          ],
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.people_alt_rounded)),
              Tab(icon: Icon(Icons.inventory_rounded)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Icon(Icons.directions_car),
            Icon(Icons.directions_transit),
          ],
        ),
      ),
    );
  }
}
