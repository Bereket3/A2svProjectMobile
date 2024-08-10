import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/card.dart';
import 'package:flutter_application_1/pages/add_product.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Product> data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed:() async {
          dynamic result = await Navigator.pushNamed(context, '/add');
          setState(() {
            if(result != null) {
              data.add(result);
            }
          });
        },
        backgroundColor: const Color.fromARGB(255, 2, 113, 204),
        child: const IconButton(
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
      body: SafeArea( 
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Column(
              children: [
                const NotificationCard(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 5, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                        child: Text(
                          "Available Products",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(0, 0, 0, 0.612)
                          ),
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          side:const BorderSide(
                            color: Color.fromARGB(255, 229, 229, 229),
                            width: 0.5,
                          ),
                        ),
                        color: Colors.white,
                        child: Center(
                          child: SizedBox(
                          width: 50, 
                          height: 50,
                          child: IconButton(
                            onPressed: () => {
                              Navigator.pushNamed(context, '/search', arguments: {
                                "data": data
                              })
                            },
                            icon: const Stack(
                              children: [
                                Icon(
                                  Icons.search_outlined,
                                  size: 40,
                                  color: Color.fromARGB(217, 216, 216, 216),
                                ),
                              ]
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
                const SizedBox(height: 20,),
                SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  child: Column(
                    children: [
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return  GestureDetector(
                            onTap: () async {
                              dynamic result = await Navigator.pushNamed(context, '/detail', arguments: {
                                "data": data[index],
                                "index": index
                              });
                              if(result["type"] == "delete"){
                                setState(() {
                                  data.remove(data[index]);
                                });
                              } else if (result["type"] == "update"){
                                setState(() {
                                  data[index] = result["data"];
                                });
                              }
                            },
                            child: ShoeCard(
                              product: data[index],
                            ),
                          );
                        },
                      ),
                    ]
                  ),
                ),
              ]
            ),
          )
        ),
      ),
    );
  }
}