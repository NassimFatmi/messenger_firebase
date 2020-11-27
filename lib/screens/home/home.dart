import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:messenger/models/appuser.dart';
import 'package:messenger/models/user_data.dart';
import 'package:messenger/screens/home/chat.dart';
import 'package:messenger/screens/services/auth.dart';
import 'package:messenger/screens/services/database.dart';
import 'package:messenger/shared/constantces.dart';
import 'package:messenger/widgets/chathead.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<AppUser>(context);
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors[2],
        title: Text(
          'Messenger',
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: FaIcon(FontAwesomeIcons.cog),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: colors,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      'Users',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  StreamBuilder<List<UserData>>(
                    stream: DataBaseServices(uid: user.uid).dataList,
                    builder: (context, snapshot) {
                      return !snapshot.hasData
                          ? CircularProgressIndicator()
                          : Container(
                              height: size.height * 0.10,
                              width: size.width,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    return user.uid == snapshot.data[index].uid
                                        ? SizedBox.shrink()
                                        : ChatHead(user: snapshot.data[index]);
                                  }),
                            );
                    },
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: FloatingActionButton(
              backgroundColor: colors[2],
              tooltip: 'Logout',
              onPressed: () async {
                await _auth.logOut();
              },
              child: FaIcon(FontAwesomeIcons.signOutAlt),
            ),
          )
        ],
      ),
    );
  }
}
