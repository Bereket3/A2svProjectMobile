import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/product_bloc.dart';
import '../widgets/components/header.dart';
import '../widgets/components/product_card.dart';
import '../widgets/components/searching_card.dart';
import '../widgets/route/route.dart';
import 'detail.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    BlocProvider.of<ProductBloc>(context).add(LoadAllProductEvent());  
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () async {
          await Navigator.pushNamed(context, '/add');
        },
        backgroundColor: const Color.fromARGB(255, 2, 113, 204),
        child:const IconButton(
          onPressed: null,
          icon: Stack(
            children: [
              Icon(
                Icons.add,
                color: Colors.white,
                size: 40,
              )
            ],
          ),
        ),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is LoadedAllProductState) {
            return SafeArea(
              child: SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Column(
                  children: [
                    NotificationCard(
                      data: state.products,
                    ),
                    const SearchCard(),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            await Navigator.push(context, MyAnimation.createRoute(Detail(product: state.products[index],)));
                          },
                          child: ShoeCard(
                            product: state.products[index],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }
          if(state is ErrorState) {
            return Center(
              child: Text(state.error)
            );
          } 
          if(state is DeletedProductState) {
            BlocProvider.of<ProductBloc>(context).add(LoadAllProductEvent());
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if(state is CreatedProductState) {
            BlocProvider.of<ProductBloc>(context).add(LoadAllProductEvent());
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else { 
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
