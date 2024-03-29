import 'package:flutter/material.dart';
import 'package:mqtt_app/mqtt/message.dart';
import "package:mqtt_app/main.dart";

class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage>{

  ScrollController messageScrollController = ScrollController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Messages"),),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              controller: messageScrollController,
              children: _buildMessageList(),
            ),
          ),
        ],
      )
    );
  }

  List<Widget> _buildMessageList(){
    _checkListLen(messages);
    return messages
        .map((Message message) => Card(
              color: Colors.white70,
              child: ListTile(
                trailing: CircleAvatar(
                    radius: 14.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'QoS',
                          style: TextStyle(fontSize: 8.0),
                        ),
                        Text(
                          message.qos.index.toString(),
                          style: TextStyle(fontSize: 8.0),
                        ),
                      ],
                    )),
                title: Text(message.topic),
                subtitle: Text(message.message),
                dense: true,
              ),
            ))
        .toList()
        .reversed
        .toList();
  }

  void _checkListLen(List<Message> message) {
    if(message.length > 5){
      message.remove(message[0]);
    }
  }
}