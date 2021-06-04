import 'package:bar_pub/models/property.dart';
import 'package:bar_pub/screens/profilo.dart';
import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  // final List<Property> viewNightlife;
  final index;
  const CardItem({
    this.index,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 21.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
              ),
              child: Image.network(
                viewNightlife.elementAt(index).imagePath,
                //"https://lh5.googleusercontent.com/p/AF1QipNsI7OE7BIDmrVQoqczPxf3ul1D0CG_oMJcnMQn=w408-h271-k-no",
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            // SizedBox(
            //   height: 24.0,
            // ),
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      viewNightlife.elementAt(index).name,
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    // SizedBox(
                    //   height: 4.0,
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
                      child: Text(
                        // "this
                        //     .viewNightlife
                        //     .elementAt(index)
                        //     .categories
                        //     .toString()",
                        viewNightlife.elementAt(index).categories.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                        ),
                        maxLines: 1,
                      ),
                    ),
                    Text(
                      viewNightlife.elementAt(index).address,
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
