import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../domain/entities/product.dart';

class NotificationCard extends StatelessWidget {

  final List<ProductEntity>? data;

  NotificationCard({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: const Color.fromRGBO(204, 204, 204, 100),
            child: const SizedBox(width: 50, height: 50),
          ),
          const Padding(
            padding:  EdgeInsets.fromLTRB(0,10,0,0), 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'July 14, 2023',
                  style: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Sora',
                    fontSize: 12,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Hello, ',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                        fontFamily: 'Sora',
                      ),
                    ),
                    Text(
                      'Yohannes',
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
      ),
    );
  }
}