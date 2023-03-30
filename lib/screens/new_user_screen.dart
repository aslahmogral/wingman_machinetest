import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:wingman_machinetest/screens/homescreen.dart';

class NewUserScreen extends StatefulWidget {
  const NewUserScreen({super.key});

  @override
  State<NewUserScreen> createState() => _NewUserScreenState();
}

class _NewUserScreenState extends State<NewUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome'),),
      body: Column(
        children: [
          Text('welcom looks like your are new here'),
          TextField(

            decoration: InputDecoration(hintText: 'Enter Name'),

          ),
          TextField(

            decoration: InputDecoration(hintText: 'Enter Email'),

          ),
          ElevatedButton(onPressed: (){
            Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
          }, child: Text('submit'))
        ],
      ),
    );
  }
}