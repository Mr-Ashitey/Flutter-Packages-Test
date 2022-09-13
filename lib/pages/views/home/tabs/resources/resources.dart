import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:packages_flutter/core/models/resource_model.dart';
import 'package:packages_flutter/core/viewModels/resources_view_model.dart';
import 'package:provider/provider.dart';

class Resources extends StatefulWidget {
  const Resources({Key? key}) : super(key: key);

  @override
  State<Resources> createState() => _ResourcesState();
}

class _ResourcesState extends State<Resources>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    final resourcesViewModel = context.read<ResourcesViewModel>();
    return Scaffold(
      body: LiquidPullToRefresh(
        onRefresh: () {
          setState(() {});
          return Future.microtask(() => null);
        },
        backgroundColor: Colors.white,
        showChildOpacityTransition: false,
        animSpeedFactor: 5,
        springAnimationDurationInMilliseconds: 500,
        color: Colors.black,
        child: FutureBuilder(
          future: resourcesViewModel.getResources(),
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
              itemCount: resourcesViewModel.resources.length,
              itemBuilder: (context, index) {
                final Resource resource = resourcesViewModel.resources[index];
                return Card(
                  elevation: 8,
                  shadowColor: Color(int.parse(
                      resource.color!.toString().replaceAll('#', '0xff'))),
                  margin: const EdgeInsets.all(20),
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: Color(int.parse(resource.color!
                              .toString()
                              .replaceAll('#', '0xff'))),
                          width: 1)),
                  child: ListTile(
                    title: Text(resource.name!),
                    trailing: Text(resource.year!.toString()),
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
