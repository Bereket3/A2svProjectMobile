import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/card.dart';

class FlotingButton extends StatefulWidget {
  const FlotingButton({super.key});

  @override
  State<FlotingButton> createState() => _FlotingButtonState();
}

class _FlotingButtonState extends State<FlotingButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: const CircleBorder(),
      onPressed: () => Navigator.pushNamed(context,'/add'),
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
    );
  }
}

class ButtonPopUpPage extends StatefulWidget {
  const ButtonPopUpPage({super.key});

  @override
  State<ButtonPopUpPage> createState() => __BottumPopUpButtonStateState();
}

class __BottumPopUpButtonStateState extends State<ButtonPopUpPage> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          context: context,
          builder: (context) => Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: DraggableScrollableSheet(
              // initialChildSize: 0.6,
              maxChildSize: 1,
              expand: true,
              builder: (_, controller) {
                return OverflowBox(
                  minHeight: 200,
                  maxHeight: 400,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(0.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black45,
                          offset: Offset(0.0, 2.0),
                          blurRadius: 10.0,
                        ),
                      ],
                    ),
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: PageBottomClass(),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
      icon: const Icon(
        Icons.filter_list,
        color: Colors.white,
        size: 30,
      ),
      style: IconButton.styleFrom(
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }
}