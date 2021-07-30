import 'package:flutter/material.dart';
import 'package:taranga_app/models/user.dart';
import 'package:taranga_app/screens/auth/register.dart';
import 'package:taranga_app/services/auth.dart';
import 'package:taranga_app/shared/constants.dart';
import 'package:taranga_app/shared/color.dart';
import 'package:provider/provider.dart';
import 'package:taranga_app/shared/loading.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    // final firebaseUser = context.watch<UserModel?>();

    return loading
        ? Loading()
        : Scaffold(
            body: SingleChildScrollView(
            child: SafeArea(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: bgColor,
                ),
                padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 12.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Welcome',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 30),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Email'),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: _emailController,
                                  decoration: textInputDecoration.copyWith(
                                    // fillColor: Colors.grey[200],
                                    hintText: 'Email',
                                    prefixIcon: Icon(
                                      Icons.person_outline,
                                      // color: Colors.grey[400],
                                    ),
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                  validator: (val) =>
                                      _emailController.text.isEmpty
                                          ? 'Enter your email'
                                          : null,
                                ),
                                SizedBox(height: 20.0),
                                Text('Password'),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: _passwordController,
                                  obscureText: true,
                                  decoration: textInputDecoration.copyWith(
                                    prefixIcon: Icon(
                                      Icons.lock_outline,
                                    ),
                                    // fillColor: Colors.grey[200],
                                    hintText: 'Password',
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                  validator: (val) =>
                                      _passwordController.text.isEmpty
                                          ? 'Enter your password'
                                          : null,
                                ),
                                SizedBox(height: 40.0),
                              ],
                            ),
                            Container(
                              // alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              height: 45,
                              decoration: BoxDecoration(
                                color: selectedColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: MaterialButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      loading = true;
                                    });

                                    dynamic res = await _auth.signIn(
                                        _emailController.text,
                                        _passwordController.text);
                                    // print('User in sigIn is $firebaseUser');
                                    if (res == null && mounted) {
                                      setState(() {
                                        loading = false;
                                      });
                                    }
                                  }
                                },
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Don't have an account yet? "),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Register()));
                                  },
                                  child: Text(
                                    'Register',
                                    style: TextStyle(
                                        color: selectedColor,
                                        decoration: TextDecoration.underline),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ));
  }
}
