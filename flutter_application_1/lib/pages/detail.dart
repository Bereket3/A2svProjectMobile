import 'package:flutter/material.dart';


class DeleteId {
  late int id;
}

class Detail extends StatefulWidget {
  const Detail({super.key});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  int selectedSize = 3;
  List<int> sizes = List.generate(20, (i) => i + 30);
  
  @override
  Widget build(BuildContext context) {
    dynamic obj = ModalRoute.of(context)?.settings.arguments;
    dynamic product = obj["data"];
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: [
                ClipRRect(
                  borderRadius:  const BorderRadius.vertical(top: Radius.circular(19)),
                  child: Image.file(
                    product.image!,
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 20,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Colors.blue,
                      size: 30,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: const CircleBorder(),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Men's shoe",
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                      // SizedBox(width: 140,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                          Icons.star,
                            color: Color.fromARGB(255, 250, 227, 18),
                          ),
                          Text(
                            " (4.0)",
                            style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Color.fromARGB(255, 171, 171, 171),
                            fontSize: 18,
                            fontFamily: 'Sora'
                          )),
                        ]
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 25,
                          color: Color.fromARGB(255, 88, 87, 87),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      //SizedBox(width: 60,),
                      Text(
                        "\$${product.price}",
                        style:const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                    ]
                  ),
                  const SizedBox(height: 20,),
                  const Text(
                    "Size:",
                    style: TextStyle(
                      fontSize: 23,
                      //color: Color.fromARGB(255, 88, 87, 87),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20,),
                  SizedBox(
                    height: 70,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: sizes.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedSize = index;
                            });
                          },
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            color: selectedSize == index ? Colors.blue.shade700 : Colors.white,
                            child:  SizedBox(
                              width: 60, 
                              height: 60,
                              child: Center(
                                child: Text(
                                  (sizes[index]).toString(),
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                    color: selectedSize == index ? Colors.white : Colors.black 
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Text(
                    style:const TextStyle(
                      fontSize: 15,
                    ),
                    product.description
                  ),
                  const SizedBox(height: 40,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () => {
                          Navigator.pop(context, 
                            {
                              "type":"delete",
                            }
                          ),
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              closeIconColor: Colors.white,
                              showCloseIcon: true,
                              backgroundColor: Colors.red,
                              content: Text('New Item was Deleted'),
                            ),
                          ),
                        },
                        style: TextButton.styleFrom(
                            elevation: 2,
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)
                            ),
                            side: const BorderSide(
                              color: Colors.red
                            ),
                            fixedSize : const Size.fromHeight(50,), // Button width and height
                        ),
                        child: const Text(
                          "        DELETE        ",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.red
                          ),
                        ),
                      ),
                      // const SizedBox(height: 10,),
                      TextButton(
                        onPressed: () async {
                          var result = await Navigator.pushNamed(context, '/update', arguments: product);
                          if(result != null) {
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context, {
                              "type": "update",
                              "data": result
                            });
                          }
                        },
                        style: TextButton.styleFrom(
                            elevation: 2,
                            backgroundColor: const Color.fromARGB(255, 17, 116, 198),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            fixedSize:const Size.fromHeight(50), // Button width and height
                        ),
                        child: const Text(
                          "        UPDATE        ",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30,)
                ],
              ),
            )
          ],
        ),
      ),
    ),
    );
  }
}
