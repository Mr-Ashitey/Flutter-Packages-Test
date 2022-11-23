// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:packages_flutter/core/viewModels/auth_provider/auth_view_model.dart';
import 'package:packages_flutter/core/viewModels/resource_provider/resources_view_model.dart';
import 'package:packages_flutter/core/viewModels/users_provider/users_view_model.dart';
import 'package:packages_flutter/helpers/constants/route_names.dart';
import 'package:packages_flutter/pages/views/home/tabs/resources/resources.dart';
import 'package:packages_flutter/pages/views/home/tabs/users/users.dart';
import 'package:provider/provider.dart';

class Home extends HookWidget {
  const Home({Key? key}) : super(key: key);

  static const routeName = RouteNames.homeRoute;

  // @override
  // void initState() {
  //   tabController = TabController(initialIndex: 0, length: 2, vsync: this);
  //   tabController!.addListener(() {
  //     // do this to update tabController index on swipe and ontap
  //     setState(() {});
  //   });
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   tabController!.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final TabController tabController = useTabController(initialLength: 2);
    final currentIndex = useState(0);

    useEffect(() {
      tabController.addListener(() {
        // do this to update tabController index on swipe and ontap
        currentIndex.value = tabController.index;
      });
      return null;
    });
    // tabController.addListener(() {
    //   _index.value = _controller.index;
    // });

    final bool showFab = currentIndex.value == 0
        ? context.watch<UsersViewModel>().showFab
        : context.watch<ResourcesViewModel>().showFab;
    return Scaffold(
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
                        content: const Text('Are you sure you want to logout?'),
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
                              Navigator.pushNamedAndRemoveUntil(context,
                                  RouteNames.loginRoute, (route) => false);
                            },
                          ),
                        ],
                      );
                    });
              },
              icon: const Icon(Icons.logout_rounded))
        ],
        bottom: TabBar(
          controller: tabController,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(icon: Icon(Icons.people_alt_rounded)),
            Tab(icon: Icon(Icons.inventory_rounded)),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: const [Users(), Resources()],
      ),
      floatingActionButton: showFab
          ? FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                if (currentIndex.value == 0) {
                  Navigator.pushNamed(context, RouteNames.addUserRoute);
                  return;
                }
                Navigator.pushNamed(context, RouteNames.addResourceRoute);
              },
            )
          : null,
    );
  }
}
