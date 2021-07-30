import 'package:flutter/material.dart';
import 'package:taranga_app/screens/auth/login.dart';
import 'package:taranga_app/services/auth.dart';
import 'package:taranga_app/shared/color.dart';
import 'package:taranga_app/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:taranga_app/shared/loading.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _repasswordController = TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
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
                      'Register',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 35),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Full Name'),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: _nameController,
                                  decoration: textInputDecoration.copyWith(
                                    // fillColor: Colors.grey[200],
                                    hintText: 'Full Name',
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
                                          ? 'Enter your name'
                                          : null,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
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
                                      Icons.mail_outline,
                                      // color: Colors.grey[400],
                                    ),
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                  validator: (val) =>
                                      _emailController.text.isEmpty
                                          ? 'Enter an email'
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
                                  validator: (val) => _passwordController
                                              .text.length <
                                          6
                                      ? 'Enter a password of lenght 6 or more'
                                      : null,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text('Confirm Password'),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: _repasswordController,
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
                                      _repasswordController.text ==
                                              _passwordController.text
                                          ? null
                                          : 'Password do not match',
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
                                    dynamic res = await _auth.register(
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                        fullName: _nameController.text);
                                    print(res);
                                    if (res == null) {
                                      setState(() {
                                        loading = false;
                                        print('Please supppy a valid email');
                                      });
                                    } else {
                                      Navigator.pop(context);
                                    }
                                  }
                                },
                                child: Text(
                                  'Register',
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
                                Text("Already have an account? "),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Login()));
                                  },
                                  child: Text(
                                    'Login',
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
