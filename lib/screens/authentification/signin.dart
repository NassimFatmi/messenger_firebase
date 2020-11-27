import 'package:flutter/material.dart';
import 'package:messenger/screens/authentification/signup.dart';
import 'package:messenger/screens/services/auth.dart';
import 'package:messenger/shared/constantces.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:messenger/shared/loading.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  var _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: colors),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: <Widget>[
                      FaIcon(
                        FontAwesomeIcons.facebookMessenger,
                        color: Colors.white,
                        size: 100,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Messenger',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                                onChanged: (value) => setState(() {
                                      _email = value;
                                    }),
                                validator: (value) => value.isEmpty
                                    ? 'type your email please'
                                    : null,
                                decoration: inputDecoration.copyWith(
                                  hintText: 'Email -or- Username',
                                  hintStyle: TextStyle(
                                    color: Colors.white.withOpacity(0.6),
                                    fontSize: 18.0,
                                  ),
                                )),
                            SizedBox(height: 20.0),
                            TextFormField(
                              onChanged: (value) => setState(() {
                                _password = value;
                              }),
                              validator: (value) => value.isEmpty
                                  ? 'type your password please'
                                  : null,
                              obscureText: true,
                              decoration: inputDecoration.copyWith(
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.6),
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              _error,
                              style:
                                  TextStyle(color: Colors.red, fontSize: 16.0),
                            ),
                            SizedBox(height: 20.0),
                            InkWell(
                              onTap: () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() {
                                    loading = true;
                                  });
                                  var result =
                                      await _auth.signinWithEmailandPass(
                                          _email, _password);
                                  if (result == null) {
                                    setState(() {
                                      _error = 'Invalid email or password';
                                      loading = false;
                                    });
                                  }
                                }
                              },
                              child: Container(
                                width: double.infinity,
                                alignment: Alignment.center,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  color: colors[2],
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                child: Text(
                                  'Sign in',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Register()));
                              },
                              child: Container(
                                width: double.infinity,
                                alignment: Alignment.center,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  color: colorblue,
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                child: Text(
                                  'Register',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ));
  }
}
