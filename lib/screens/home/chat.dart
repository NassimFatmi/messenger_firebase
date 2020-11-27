import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:messenger/models/appuser.dart';
import 'package:messenger/models/user_data.dart';
import 'package:messenger/screens/services/database.dart';
import 'package:messenger/shared/constantces.dart';

class Chat extends StatefulWidget {
  final AppUser to;
  final AppUser from;

  const Chat({Key key, this.to, this.from}) : super(key: key);
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  String _currentmessage;
  bool _sendBtnEnabled = false;

  List<Message> concatAndTrieLists(List<Message> list1, List<Message> list2) {
    list1.toList();

    list1.addAll(list2);
    list1.sort((msg1, msg2) => msg1.time.compareTo(msg2.time));
    return list1;
  }

  List<Message> chatMessages = List<Message>();

  @override
  Widget build(BuildContext context) {
    DataBaseServices _dataBase = DataBaseServices(uid: widget.from.uid);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          // Messages
          // List view builder !! here
          Expanded(
            child: StreamBuilder<List<Message>>(
              stream: _dataBase.messagesListSent(widget.to.uid),

              // Get messages sent by the logged user
              builder: (context, snapshotSent) {
                if (!snapshotSent.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  // if the data is avaible then get the messages recived
                  chatMessages.clear();
                  chatMessages =
                      concatAndTrieLists(chatMessages, snapshotSent.data);
                  return StreamBuilder<List<Message>>(
                    stream: _dataBase.messagesListRecived(widget.to.uid),
                    builder: (context, snapshotRecived) {
                      if (!snapshotRecived.hasData)
                        return Center(child: CircularProgressIndicator());
                      else {
                        chatMessages = concatAndTrieLists(
                            chatMessages, snapshotRecived.data);
                        return ListView.builder(
                          reverse: true,
                          itemCount: chatMessages.length,
                          itemBuilder: (context, index) {
                            return Container(
                              alignment: chatMessages[
                                              (chatMessages.length - index - 1)]
                                          .from ==
                                      widget.from.uid
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 12.0),
                              margin: EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 20.0),
                              decoration: BoxDecoration(
                                  color: chatMessages[(chatMessages.length -
                                                  index -
                                                  1)]
                                              .from ==
                                          widget.from.uid
                                      ? colors[1]
                                      : Colors.grey[600],
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: Text(
                                chatMessages[(chatMessages.length - index - 1)]
                                    .message,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18.0),
                              ),
                            );
                          },
                        );
                      }
                    },
                  );
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.camera),
                  onPressed: () {},
                ),
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      _currentmessage = value;
                      _sendBtnEnabled = value.isEmpty ? false : true;
                    },
                    decoration: InputDecoration(
                      hintText: 'Aa',
                      filled: true,
                      fillColor: Colors.grey[200].withOpacity(0.3),
                    ),
                  ),
                ),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.paperPlane),
                  onPressed: () async {
                    if (_sendBtnEnabled) {
                      // send the message

                      var result = await DataBaseServices(uid: widget.from.uid)
                          .updateMessage(widget.to.uid, _currentmessage);
                      if (!result) {
                        print('can t send this message');
                      }
                    }
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
