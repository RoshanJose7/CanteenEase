import 'package:flutter/material.dart';

class ClientNotificationsPage extends StatefulWidget {
  const ClientNotificationsPage({Key? key}) : super(key: key);

  @override
  _ClientNotificationsPageState createState() => _ClientNotificationsPageState();
}

class _ClientNotificationsPageState extends State<ClientNotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("No Orders!", style: TextStyle(color: Colors.black),),
    );
  }
}
