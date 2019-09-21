import 'package:flutter/material.dart';

class AcmanAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const AcmanAppBar({
    Key key,
    @required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 23),
      child: Container(
        color: Colors.blue,
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.verified_user),
              onPressed: () => null,
            )
          ]
        )
      )
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}