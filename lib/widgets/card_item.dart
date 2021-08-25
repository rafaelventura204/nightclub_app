import 'package:bar_pub/services/load_data_user.dart';
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
      padding: const EdgeInsets.all(8.0),
      child: Card(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
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
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 190,
                      color: Colors.transparent,
                      child: Text(viewNightlife.elementAt(index).name,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis),
                    ),
                    Container(
                      width: 190,
                      color: Colors.transparent,
                      child: Text(
                        viewNightlife
                            .elementAt(index)
                            .categories
                            .toString()
                            .replaceAll('[', '')
                            .replaceAll(']', ''),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                    Container(
                      width: 190,
                      color: Colors.transparent,
                      child: Text(
                        viewNightlife.elementAt(index).address,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                        ),
                        overflow: TextOverflow.ellipsis,
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
