import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:packages_flutter/core/models/resource_model.dart';
import 'package:packages_flutter/core/viewModels/resources_view_model.dart';
import 'package:provider/provider.dart';

class Resources extends StatelessWidget {
  const Resources({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final resourcesViewModel = context.read<ResourcesViewModel>();
    return Scaffold(
      body: FutureBuilder(
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
              child: Text(snapshot.error.toString()),
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
    );
  }
}
