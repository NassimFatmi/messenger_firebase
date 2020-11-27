import 'package:flutter/material.dart';
import 'package:messenger/models/appuser.dart';
import 'package:messenger/models/user_data.dart';
import 'package:messenger/screens/home/chat.dart';
import 'package:messenger/shared/constantces.dart';
import 'package:provider/provider.dart';

class ChatHead extends StatelessWidget {
  final UserData user;

  const ChatHead({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var from = Provider.of<AppUser>(context);
    var size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Chat(
                      to: AppUser(uid: user.uid),
                      from: AppUser(uid: from.uid),
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(right: 10.0),
        alignment: Alignment.center,
        height: size.height * 0.1,
        width: size.height * 0.1,
        decoration: BoxDecoration(shape: BoxShape.circle, color: colors[2]),
        child: Text(
          user.name,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
