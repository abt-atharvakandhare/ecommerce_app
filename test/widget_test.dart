import 'package:dio/dio.dart';
import 'package:ecommerce_app/features/shop/data/resources/product_datasource.dart';
import 'package:ecommerce_app/features/shop/domain/repositories/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ecommerce_app/main.dart';

void main() {
  testWidgets('E-Commerce app smoke test', (WidgetTester tester) async {
    // 1. Create the required real or mock dependencies for the repository
    final dio = Dio();
    final dataSource = ProductDataResource(dio: dio);
    final repository = ProductRepository(datasource: dataSource);

    // 2. Build our app and trigger a frame by passing the repository instance
    await tester.pumpWidget(MyApp(repository: repository));

    // 3. Verify that the app builds successfully
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}