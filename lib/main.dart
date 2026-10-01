import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/network/dio_client.dart';
import 'features/shop/data/resources/product_datasource.dart';
import 'features/shop/domain/repositories/product_repository.dart';
import 'features/shop/presentation/bloc/product_bloc.dart';
import 'features/shop/presentation/bloc/product_event.dart';
import 'features/shop/presentation/screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final dioClient = DioClient();
  final datasource = ProductDataResource(dio: dioClient.dio);
  final repository = ProductRepository(datasource: datasource);

  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final ProductRepository repository;

  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc(repository: repository)..add(FetchProductsEvents()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'E-Commerce Application',
        theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
        home: const SplashScreen(),
      ),
    );
  }
}