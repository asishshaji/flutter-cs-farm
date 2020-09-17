import 'package:f2k/blocs/offersbloc/offers_bloc.dart';
import 'package:f2k/repos/OffersRepo.dart';
import 'package:f2k/repos/ProductRepo.dart';
import 'package:f2k/repos/UserRepo.dart';
import 'package:f2k/repos/firebase_auth_repo.dart';
import 'package:f2k/repos/model/Offers.dart';
import 'package:f2k/repos/model/Orders.dart';
import 'package:f2k/repos/model/Product.dart';
import 'package:f2k/ui/pages/AuthNav.dart';
import 'package:f2k/ui/pages/Home/Home.dart';
import 'package:f2k/ui/pages/Login.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'blocs/productbloc/products_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    final appDocumentDirectory =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
  }
  Hive.registerAdapter(OfferAdapter());
  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(OrderAdapter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  UserRepository userRepository = UserRepository();
  FirebaseAuthRepo authRepo = FirebaseAuthRepo();
  ProductRepository productRepository = ProductRepository();
  OffersRepo offersRepo = OffersRepo();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                ProductsBloc(productRepository: productRepository)),
        BlocProvider(create: (context) => OffersBloc(repo: offersRepo)),
      ],
      child: MaterialApp(
        title: "Mart to home",
        debugShowCheckedModeBanner: false,
        home: AuthNavigation(),
      ),
    );
  }
}
