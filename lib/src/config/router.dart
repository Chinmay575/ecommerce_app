// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:ecommerce_app/src/presentation/views/home/bloc/home_bloc.dart';
import 'package:ecommerce_app/src/presentation/views/home/home_page.dart';
import 'package:ecommerce_app/src/presentation/views/product/bloc/product_bloc.dart';
import 'package:ecommerce_app/src/presentation/views/product/product_page.dart';
import 'package:ecommerce_app/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static List<AppRoute> routes() => [
        AppRoute(
          route: AppRouteStrings.home,
          view: const HomePage(),
          bloc: BlocProvider(
            create: (context) => HomeBloc(),
          ),
        ),
        AppRoute(
          route: AppRouteStrings.product,
          view: const ProductPage(),
          bloc: BlocProvider(
            create: (context) => ProductBloc(),
          ),
        ),
      ];

  static MaterialPageRoute onGenerateRoute(RouteSettings settings) {
    if (settings.name != null) {
      var result = routes().where((element) => element.route == settings.name);
      if (result.isNotEmpty) {
        return MaterialPageRoute(builder: (context) => result.first.view);
      }
      return MaterialPageRoute(builder: (context) => const NoRoute());
    }
    return MaterialPageRoute(builder: (context) => const NoRoute());
  }

  static List<dynamic> allBlocProviders() {
    List<dynamic> blocProviders = [];
    for (var i in routes()) {
      blocProviders.add(i.bloc);
    }
    return blocProviders;
  }
}

class NoRoute extends StatelessWidget {
  const NoRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}

class AppRoute {
  String route;
  Widget view;
  dynamic bloc;
  AppRoute({
    required this.route,
    required this.view,
    required this.bloc,
  });
}
