import 'package:flutter/material.dart';
import 'package:messenger/screens/services/auth.dart';
import 'package:messenger/shared/constantces.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  var _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _userName = '';
  String _error = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xFF201F40),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF201F40),
                    Color(0xFF2B1773),
                    Color(0xFF5259D9),
                    Color(0xFF04BFAD),
                  ]),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
            height: double.infinity,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Sign up to Messenger',
                        style: TextStyle(color: Colors.white, fontSize: 28.0),
                      ),
                      SizedBox(height: 40.0),
                      TextFormField(
                          onChanged: (value) => setState(() {
                                _email = value;
                              }),
                          validator: (value) =>
                              value.isEmpty ? 'type your email please' : null,
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
                          _userName = value;
                        }),
                        validator: (value) =>
                            value.isEmpty ? 'type your user name please' : null,
                        decoration: inputDecoration.copyWith(
                          hintText: 'User name',
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        onChanged: (value) => setState(() {
                          _password = value;
                        }),
                        validator: (value) =>
                            value.isEmpty ? 'type your password please' : null,
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
                        style: TextStyle(color: Colors.red, fontSize: 16.0),
                      ),
                      SizedBox(height: 20.0),
                      InkWell(
                        onTap: () async {
                          if (_formKey.currentState.validate()) {
                            var result = await _auth.createNewAccount(
                                _email, _password, _userName);
                            if (result == null) {
                              setState(() {
                                _error = 'Your informations are not valid';
                              });
                            }
                            Navigator.pop(context);
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          height: 60.0,
                          decoration: BoxDecoration(
                            color: Color(0xFF2B1773),
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
              ),
            ),
          )
        ],
      ),
    );
  }
}
