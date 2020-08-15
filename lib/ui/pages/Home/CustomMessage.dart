import 'package:f2k/repos/model/CustomMessageModel.dart';
import 'package:f2k/res/AppString.dart';
import 'package:f2k/ui/pages/BuildTextField.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class CustomMessage extends StatefulWidget {
  CustomMessage({Key key}) : super(key: key);

  @override
  _CustomMessageState createState() => _CustomMessageState();
}

class _CustomMessageState extends State<CustomMessage> {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _messageController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Send Message",
          style: TextStyle(
            fontFamily: "Merriweather",
            color: Colors.grey[700],
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            BuildTextField(
              width: MediaQuery.of(context).size.width,
              controller: _nameController,
              icon: Icons.person,
              hintText: "Name",
              textInputType: TextInputType.text,
            ),
            BuildTextField(
                width: MediaQuery.of(context).size.width,
                controller: _phoneController,
                icon: Icons.phone,
                hintText: "Phone number",
                textInputType: TextInputType.phone),
            BuildTextField(
                width: MediaQuery.of(context).size.width,
                controller: _messageController,
                icon: Icons.textsms,
                hintText: "Message",
                textInputType: TextInputType.text),
            SizedBox(
              height: 40,
            ),
            RaisedButton(
              color: Colors.green[400],
              onPressed: () async {
                if (_messageController.text.isNotEmpty &&
                    _nameController.text.isNotEmpty &&
                    _messageController.text.isNotEmpty) {
                  CustomMessageModel customMessageModel = CustomMessageModel(
                    _nameController.text,
                    _messageController.text,
                    _phoneController.text,
                  );

                  Toast.show("Sending message, wait...", context,
                      gravity: Toast.CENTER);
                  await http.get(
                    "https://csf2k.herokuapp.com/",
                  );

                  http.Response response = await http.post(
                    AppString.customOrder,
                    body: customMessageModel.toJson(),
                    headers: {
                      'Content-type': 'application/json',
                    },
                  );
                  Toast.show("Message send", context, gravity: Toast.CENTER);
                  Navigator.pop(context);
                }
              },
              child: Text("Send Message",
                  style: TextStyle(
                    fontFamily: "Merriweather",
                    color: Colors.white,
                  )),
            )
          ],
        ),
      )),
    );
  }
}
