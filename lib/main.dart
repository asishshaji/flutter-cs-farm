import 'package:f2k/blocs/offersbloc/offers_bloc.dart';
import 'package:f2k/repos/OffersRepo.dart';
import 'package:f2k/repos/ProductRepo.dart';
import 'package:f2k/repos/UserRepo.dart';
import 'package:f2k/repos/model/Offers.dart';
import 'package:f2k/repos/model/Orders.dart';
import 'package:f2k/repos/model/Product.dart';
import 'package:f2k/ui/pages/Login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'blocs/authbloc/auth_bloc.dart';
import 'blocs/productbloc/products_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(OfferAdapter());
  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(OrderAdapter());
  runApp(MyApp());
  SystemChrome.setEnabledSystemUIOverlays([]);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  UserRepository userRepository = UserRepository();
  ProductRepository productRepository = ProductRepository();
  OffersRepo offersRepo = OffersRepo();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(userRepository: userRepository),
        ),
        BlocProvider(
            create: (context) =>
                ProductsBloc(productRepository: productRepository)),
        BlocProvider(create: (context) => OffersBloc(repo: offersRepo)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Login(),
      ),
    );
  }
}
