import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountManagementPage extends StatefulWidget {
  const AccountManagementPage({super.key});

  @override
  State<StatefulWidget> createState() => _AccountManagementPageState();
}

class _AccountManagementPageState extends State<AccountManagementPage> {
  TextEditingController usernameController =  TextEditingController();
  TextEditingController passwordController =  TextEditingController();
  
  void setInformation() {
    //TODO set the information
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            const Text("User Name:"),
            Flexible(
              child: TextField(
                controller: usernameController,
              )
            )
          ],
        ),
        Row(
          children: [
            const Text("Password:"),
            Flexible(
              child: TextField(
                controller: passwordController,
              )
            )
          ],
        ),
        Flexible(
          child: ElevatedButton(
            onPressed: setInformation,
            child: const Text("Set Information"),
          ),
        ),
        Flexible(
          child: ElevatedButton(
            onPressed: signOut,
            child: const Text("Sign Out"),
          ),
        )
      ],
    );
  }
}