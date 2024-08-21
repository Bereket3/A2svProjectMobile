
import 'package:flutter/material.dart';

class SearchCard extends StatelessWidget {
  const SearchCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 20, 5, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
            child: Text(
              'Available Products',
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
            child:const Center(
              child: SizedBox(
              width: 50, 
              height: 50,
              child: IconButton(
                onPressed: null,
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
    );
  }
}