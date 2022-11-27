import 'package:flutter/material.dart';

class PrivacyPage extends StatefulWidget {
  const PrivacyPage({super.key});

  @override
  State<StatefulWidget> createState() => _PrivacyPageState();
  
}

class _PrivacyPageState extends State<PrivacyPage>{
  @override
  Widget build(BuildContext context) {
    return const Text("We are not responsible for anything and we have full right to sell your data");
  }
}