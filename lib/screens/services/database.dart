import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messenger/models/user_data.dart';

class DataBaseServices {
  final String uid;
  final CollectionReference _userListCollection =
      Firestore.instance.collection('users_list');
  final CollectionReference _messages =
      Firestore.instance.collection('messages');

  DataBaseServices({this.uid});

  // Update data for user
  Future updateData(String name) async {
    try {
      return await _userListCollection.doc(uid).set({
        'name': name,
        'uid': uid,
      });
    } catch (e) {
      print(e);
      return null;
    }
  }

  // create list of data

  List<UserData> createUserDataList(QuerySnapshot snapshot) {
    return snapshot.docs
        .map(((doc) => UserData(
              name: doc.data()['name'],
              uid: doc.data()['uid'],
            )))
        .toList();
  }
  // get data from the dataBase

  Stream<List<UserData>> get dataList {
    return _userListCollection.snapshots().map(createUserDataList);
  }

  // -- part for messages traitment -- //
  Future updateMessage(String toUID, String content) async {
    DateTime currentPhoneDate = DateTime.now(); //DateTime
    Timestamp myTimeStamp = Timestamp.fromDate(currentPhoneDate); //To TimeStamp

    try {
      await _messages.doc().set(
          {'from': uid, 'to': toUID, 'content': content, 'time': myTimeStamp});
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // create List of messages

  List<Message> createMessagesList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Message(
        from: doc.data()['from'],
        to: doc.data()['to'],
        message: doc.data()['content'],
        time: doc.data()['time'].toDate(),
      );
    }).toList();
  }

  // stream for messages

  Stream<List<Message>> messagesListSent(String toID) {
    return _messages
        .where('from', isEqualTo: uid)
        .where('to', isEqualTo: toID)
        .snapshots()
        .map(createMessagesList);
  }

  Stream<List<Message>> messagesListRecived(String toID) {
    return _messages
        .where('from', isEqualTo: toID)
        .where('to', isEqualTo: uid)
        .snapshots()
        .map(createMessagesList);
  }
}
