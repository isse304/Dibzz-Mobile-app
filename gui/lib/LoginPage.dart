import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'dibzznotifier.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  bool signup = false;

  TextEditingController emailCon = TextEditingController();
  TextEditingController passCon = TextEditingController();

  Future _signin() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailCon.text.trim(),
      password: passCon.text.trim(),
    );
  }

  @override
  void dispose() {
    emailCon.dispose();
    passCon.dispose();
    super.dispose();
  }

  void _skipSignin() {
    setState(() {
      Provider.of<DibzzNotifier>(context, listen: false).skipTheSignIn();
    });
  }

  void setSignUp() {
    setState(() {
      signup = true;
    });
  }

  Future _signUp() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailCon.text.trim(),
      password: passCon.text.trim(),
    );
  }

  Widget getWidget() {
    if (signup) {
      emailCon.clear();
      passCon.clear();
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              const Text(
                'Sign Up',
                style: TextStyle(fontSize: 30),
              ),
              const SizedBox(
                height: 50,
              ),
              TextField(
                controller: emailCon,
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: passCon,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Password',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  _signUp();
                },
                child: const Text('Sign Up'),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    signup = false;
                  });
                },
                child: const Text('Already have an account? Sign In'),
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Login Page"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 60.0),
                child: Center(
                  child: SizedBox(
                      width: 200,
                      height: 150,
                    
                ),
              )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: emailCon,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Enter valid email id as abc@gmail.com'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextField(
                  controller: passCon,
                  obscureText: true,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter secure password'),
                ),
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(20)),
                child: ElevatedButton(
                  onPressed: _signin,
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              const SizedBox(
                height: 130,
              ),
              ElevatedButton(
                onPressed: setSignUp,
                child: const Text('New User? Create Account')),
              ElevatedButton(
                onPressed: _skipSignin, 
                child: const Text("Skip login"))
            ],
          ),
        ),
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return getWidget();
  }
}