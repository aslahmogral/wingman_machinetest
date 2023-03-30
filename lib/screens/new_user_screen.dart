import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wingman_machinetest/screens/homescreen.dart';
import 'package:http/http.dart' as http;

class NewUserScreen extends StatefulWidget {
  final String token;
  const NewUserScreen({super.key, required this.token});

  @override
  State<NewUserScreen> createState() => _NewUserScreenState();
}

class _NewUserScreenState extends State<NewUserScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  postNameAndEmail() async {
    var url = Uri.parse('https://test-otp-api.7474224.xyz/profilesubmit.php');
    Map data = {"name": nameController.text, "email": emailController.text};
    var body = json.encode(data);

    try {
      var response = await http.post(url,
          headers: {"Content-Type": "application/json", "Token": widget.token},
          body: body);
      print('responsebody : ${response.body}');
      var result = json.decode(response.body);
      print(result);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: Column(
        children: [
          Text('welcom looks like your are new here'),
          TextField(
            controller: nameController,
            decoration: InputDecoration(hintText: 'Enter Name'),
          ),
          TextField(
            controller: emailController,
            decoration: InputDecoration(hintText: 'Enter Email'),
          ),
          ElevatedButton(onPressed: postNameAndEmail, child: Text('submit'))
        ],
      ),
    );
  }
}
