// Create all Providers here
import 'package:provider/provider.dart' show ChangeNotifierProvider;
import 'package:provider/single_child_widget.dart';

import 'auth_provider/auth_view_model.dart';
import 'resource_provider/resources_view_model.dart';
import 'users_provider/users_view_model.dart';

// keep a list of all providers here
final List<SingleChildWidget> providers = [
  ChangeNotifierProvider.value(value: AuthViewModel()),
  ChangeNotifierProvider.value(value: UsersViewModel()),
  ChangeNotifierProvider.value(value: ResourcesViewModel()),
];
