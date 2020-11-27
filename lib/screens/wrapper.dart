import 'package:flutter/material.dart';
import 'package:messenger/models/appuser.dart';
import 'package:messenger/screens/authentification/signin.dart';
import 'package:messenger/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);
    return user == null ? SignIn() : Home();
  }
}
