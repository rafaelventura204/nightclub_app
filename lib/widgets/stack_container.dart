import 'package:bar_pub/services/wrapper.dart';
import 'package:bar_pub/widgets/custom_clipper.dart';
import 'package:bar_pub/widgets/top_bar.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';

class StackContainer extends StatelessWidget {
  const StackContainer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      child: Stack(
        children: [
          Container(),
          ClipPath(
            clipper: MyCustomClipper(),
            child: Container(
              height: 300.0,
              color: Colors.purple,
            ),
          ),
          Align(
            alignment: Alignment(0, 1),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProfileAvatar(
                  "https://i.pravatar.cc/300",
                  borderWidth: 4.0,
                  radius: 60.0,
                ),
                SizedBox(
                  height: 4.0,
                ),
                Text(
                  finalName == null ? '' : finalName, //DA VISIONARE!
                  style: TextStyle(
                    fontSize: 21.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          TopBar(),
        ],
      ),
    );
  }
}
