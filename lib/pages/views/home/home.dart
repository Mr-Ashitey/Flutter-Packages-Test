// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:packages_flutter/core/viewModels/auth_view_model.dart';
import 'package:packages_flutter/pages/views/home/tabs/resources.dart';
import 'package:packages_flutter/pages/views/home/tabs/users.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../core/services/api_request.dart';

class Home extends StatelessWidget {
  final RequestApi? requestApi;

  const Home({Key? key, this.requestApi}) : super(key: key);

  static const routeName = homeRoute;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          backgroundColor: Colors.black,
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
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.people_alt_rounded)),
              Tab(icon: Icon(Icons.inventory_rounded)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [Users(), Resources()],
        ),
      ),
    );
  }
}
