import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/buttons.dart';
import 'package:flutter_application_1/pages/add_product.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List data = [];
  @override
  Widget build(BuildContext context) {
    dynamic result = ModalRoute.of(context)?.settings.arguments;
    setState(() {
      data = result["data"];
    });
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.blue,
            size: 25,
          ),
          style: IconButton.styleFrom(
            foregroundColor: Colors.white,
            shape: const CircleBorder(),
          ),
        ),
        title: const Text(
          "Search  Product",
          style: TextStyle(
            //fontWeight: FontWeight.w600,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black
          ),
        ),
        shadowColor: Colors.white,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Stack(
          children : [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: CustomInputBox(),
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
                              onTap: () {},
                              child: ShoeCard(
                                product: data[index],
                              ),
                            );
                          },
                        ),
                      ]
                    ),
                  ),
                ],
              ),
            ),
          ]
        ),
      ),
    );
  }
}

class CustomInputBox extends StatelessWidget {
  const CustomInputBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 270,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Leather',
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () {},
                color: Colors.blue,
                iconSize: 30,
              ),
            ],
          ),
        ),
        const ButtonPopUpPage(),
      ]
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
