import 'package:flutter/material.dart';
import 'package:safe_rh/utils/const.dart';

class GridItem extends StatelessWidget {
  final String status;
  final Color color;
    const GridItem(
  {Key? key,
    required this.status,
    required this.color,
  }) : super(key: key);

    // : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          shape: BoxShape.rectangle,
          color: Colors.white,
        ),
        child: Padding(
          padding:const EdgeInsets.fromLTRB (5,60,0,0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    status,
                    style: TextStyle(
                        fontSize: 20,
                         fontWeight: FontWeight.bold,
                         color: Constants.textPrimary
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
    );
  }
}