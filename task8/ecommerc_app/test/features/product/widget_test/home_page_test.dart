import 'package:ecommerc_app/features/product/domain/entities/product.dart';
import 'package:ecommerc_app/features/product/presentation/bloc/product_bloc.dart';
import 'package:ecommerc_app/features/product/presentation/pages/home.dart';
import 'package:ecommerc_app/features/product/presentation/widgets/components/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockProductBloc mockProductBloc;

  setUp(() {
    mockProductBloc = MockProductBloc();
  });

  tearDown(() {
    mockProductBloc.close();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<ProductBloc>(
        create: (context) => mockProductBloc,
        child: const Home(),
      ),
    );
  }

  testWidgets('displays CircularProgressIndicator when state is loading', (WidgetTester tester) async {
    when(mockProductBloc.state).thenReturn(LoadingState());

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('displays list of products when state is LoadedAllProductState', (WidgetTester tester) async {
    final products = [
      const ProductEntity(id: '1', name: 'Product 1', price: 100.0, description: 'Description 1', imageUrl: 'url1'),
      const ProductEntity(id: '2', name: 'Product 2', price: 200.0, description: 'Description 2', imageUrl: 'url2'),
    ];

    when(mockProductBloc.state).thenReturn(LoadedAllProductState(products: products));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(ShoeCard), findsNWidgets(products.length));
  });

  testWidgets('displays error message when state is ErrorState', (WidgetTester tester) async {
    const errorMessage = 'An error occurred';
    when(mockProductBloc.state).thenReturn(ErrorState(error: errorMessage));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text(errorMessage), findsOneWidget);
  });

  testWidgets('calls LoadAllProductEvent when state is DeletedProductState', (WidgetTester tester) async {
    when(mockProductBloc.state).thenReturn(const DeletedProductState(message: 'success'));

    await tester.pumpWidget(createWidgetUnderTest());

    verify(mockProductBloc.add(LoadAllProductEvent())).called(1);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('navigates to /add when floating action button is pressed', (WidgetTester tester) async {
    when(mockProductBloc.state).thenReturn(LoadingState());

    await tester.pumpWidget(createWidgetUnderTest());

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    expect(find.byType(FloatingActionButton), findsOneWidget);
  });
}
