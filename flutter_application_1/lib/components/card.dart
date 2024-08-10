import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/pages/add_product.dart';

class NotificationCard extends StatefulWidget {
  final List<Product>? data;
  const NotificationCard({super.key, this.data});

  @override
  // ignore: no_logic_in_create_state
  State<NotificationCard> createState() => _TopPartState(data);
}

class _TopPartState extends State<NotificationCard> {
  List<Product>? data;
  _TopPartState(this.data);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: const Color.fromRGBO(204, 204, 204, 100),
          child: const SizedBox(width: 50, height: 50),
        ),
        const SizedBox(width: 10),
        const Padding(
          padding:  EdgeInsets.fromLTRB(0,10,0,0), 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "July 14, 2023",
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'Sora',
                  fontSize: 12,
                ),
              ),
              Row(
                children: [
                  Text(
                    "Hello, ",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      fontFamily: 'Sora',
                    ),
                  ),
                  Text(
                    "Yohannes",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Sora',
                    ),
                  ),
                ],
              )
            ],
          ),
        ),  
        const SizedBox(width: 60,),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side:const BorderSide(
              color: Colors.grey,
              width: 0.4,
            ),
          ),
          color: Colors.white,
          child: const SizedBox(
            width: 50, 
            height: 50,
            child:IconButton(
              onPressed: null,
              icon: Stack(
                children: [
                  Icon(IconData(0xf3e1, fontFamily: CupertinoIcons.iconFont, fontPackage: CupertinoIcons.iconFontPackage), color: Colors.black,),
                  Positioned(
                    left: 13,
                    child: Icon(
                      Icons.brightness_1,
                      size: 9.0,
                      color: Colors.blue,
                    ),
                  ),
                ]
              ),
            ),
          ),
        ),
      ], 
    );
  }
}


class ShoeCard extends StatefulWidget {
  final Product? product;
  const ShoeCard({super.key, this.product});

  @override
  // ignore: no_logic_in_create_state
  State<ShoeCard> createState() => _ShoeCardState(product!);
}

class _ShoeCardState extends State<ShoeCard> {

  Product product;

  _ShoeCardState(this.product);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
      child: Card(
        color: Colors.white,
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius:  const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.file(
                product.image!,
                width: MediaQuery.of(context).size.width,
                height: 300,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 12, 10, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style:const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins'
                        ),
                      ),
                      const SizedBox(height: 5,),
                      const Text(
                        "Men's shoe",
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 10,),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "\$${product.price}",
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 5,),
                        const Row(
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
                              color: Colors.grey,
                              fontFamily: 'Sora'
                            )),
                          ]
                        ),
                      ],
                    )
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class PageBottomClass extends StatefulWidget {
  const PageBottomClass({super.key});

  @override
  State<PageBottomClass> createState() => _PageBottomClassState();
}

class _PageBottomClassState extends State<PageBottomClass> {
  var priceMaxValue = 300.00;
  var priceMinValue = 0.0;
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 30,),
          const Text(
            "Catagory",
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10,),
          TextFormField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Colors.white,
                  )
                ),
              //labelText: 'name',
              fillColor:const Color(0xFFF3F3F3),
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Colors.white
                ),
              ),
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Price',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w700,
            ),
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 7,
              thumbShape: SliderComponentShape.noThumb,
            ),
            child:RangeSlider(
              activeColor: const Color(0xff3F51F3),
              inactiveColor: const Color(0xffD9D9D9),
              min: 0,
              max: 500,
              values: RangeValues(priceMinValue, priceMaxValue),
              onChanged: (values) {
                setState(() {
                  priceMaxValue = values.end;
                  priceMinValue = values.start;
                });
              },
            ),
          ),
          const SizedBox(height: 18),
          TextButton(
            onPressed: null,
            style: TextButton.styleFrom(
                elevation: 2,
                backgroundColor: const Color.fromARGB(255, 11, 120, 210),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
                ),
                fixedSize:const Size.fromWidth(340.0), // Button width and height
            ),
            child: const Text(
              "APPLY",
              style: TextStyle(
                fontSize: 15,
                color: Colors.white
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
    );
  }
}
