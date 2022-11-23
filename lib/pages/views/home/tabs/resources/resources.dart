import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:packages_flutter/core/models/resource_model.dart';
import 'package:packages_flutter/core/viewModels/resource_provider/resources_view_model.dart';
import 'package:provider/provider.dart';

class Resources extends StatefulHookWidget {
  const Resources({Key? key}) : super(key: key);

  @override
  State<Resources> createState() => _ResourcesState();
}

class _ResourcesState extends State<Resources>
    with AutomaticKeepAliveClientMixin {
  ResourcesViewModel? resourcesViewModel;

  @override
  void initState() {
    resourcesViewModel = context.read<ResourcesViewModel>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    ScrollController scrollController = useScrollController();

    useEffect(() {
      scrollController.addListener(() {
        if (scrollController.position.userScrollDirection ==
            ScrollDirection.forward) {
          if (!resourcesViewModel!.showFab) {
            resourcesViewModel!.changeFabVisibility();
          }
        }
        if (scrollController.position.userScrollDirection ==
            ScrollDirection.reverse) {
          if (resourcesViewModel!.showFab) {
            resourcesViewModel!.changeFabVisibility();
          }
        }
        // check to see if we are at the top item
        if (scrollController.offset == scrollController.initialScrollOffset) {
          if (!resourcesViewModel!.showFab) {
            resourcesViewModel!.changeFabVisibility();
          }
        }
      });
      return null;
    });
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
          future: resourcesViewModel!.getResources(),
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
              controller: scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: context.watch<ResourcesViewModel>().resources.length,
              itemBuilder: (context, index) {
                final Resource resource =
                    context.watch<ResourcesViewModel>().resources[index];
                // print(context.read<ResourcesViewModel>().resources.length);
                return Card(
                  elevation: 8,
                  shadowColor: Color(int.tryParse(
                      resource.color!.toString().replaceAll('#', '0xff'))!),
                  margin: const EdgeInsets.all(20),
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: Color(int.tryParse(resource.color!
                              .toString()
                              .replaceAll('#', '0xff'))!),
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
