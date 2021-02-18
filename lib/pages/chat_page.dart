import 'package:clinic_app/models/chat_model.dart';
import 'package:clinic_app/models/users_model.dart';
import 'package:clinic_app/providers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatPage extends ConsumerWidget {
  final TextEditingController messageCtrl = TextEditingController();

  @override
  Widget build(BuildContext context, watch) {
    final MyUser patient = ModalRoute.of(context).settings.arguments;
    final String idDoctor = FirebaseAuth.instance.currentUser.uid;
    return Scaffold(
      // appBar: CommonAppBar('Chat'),
      appBar: AppBar(
        iconTheme: new IconThemeData(color: Colors.blueGrey),
        leading: IconButton(
            icon: Icon(FontAwesomeIcons.chevronCircleLeft,
                size: 25, color: Colors.blueGrey[500]),
            onPressed: () => Navigator.of(context).pop()),
        title: CircleAvatar(
          backgroundColor: Colors.blueGrey,
          maxRadius: 30,
          child: CircleAvatar(
            maxRadius: 27,
            backgroundImage: NetworkImage(patient.photo),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 60,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: watch(chatProvider).getMessages(idDoctor, patient.userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            final List<Chat> chatList = snapshot.data.docs
                .map((doc) => Chat.fromJson(doc.data()))
                .toList();
            if (chatList.length == 0) {
              return Center(child: Text('No messages yet'));
            }
            return ListView.builder(
              itemCount: chatList.length,
              itemBuilder: (context, index) {
                if (chatList[index].sender == idDoctor) {
                  return DoctorMessage(chatList[index].message);
                } else {
                  return PatientMessage(chatList[index].message);
                }
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error'));
          }
          return null;
        },
      ),
      bottomSheet: Row(
        children: [
          Expanded(
            flex: 8,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              height: 50,
              child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 5,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  controller: messageCtrl),
            ),
          ),
          Expanded(
            flex: 1,
            child: Consumer(
              builder: (context, watch, child) => Container(
                height: 50,
                child: Container(
                  margin: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Color(0xffE4E5E8),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      context
                          .read(chatProvider)
                          .insertMessageByIdDoctorAndIdPatient(idDoctor,
                              patient.userId, messageCtrl.text, DateTime.now());
                      messageCtrl.clear();
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PatientMessage extends StatelessWidget {
  final String message;
  const PatientMessage(this.message);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.only(
          bottom: 5,
          left: 10,
          right: 50,
        ),
        child: Text(
          message,
          style: TextStyle(color: Colors.black87),
        ),
        decoration: BoxDecoration(
          color: Color(0xffE4E5E8),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}

class DoctorMessage extends StatelessWidget {
  final String message;
  const DoctorMessage(this.message);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.only(
          bottom: 5,
          left: 50,
          right: 10,
        ),
        child: Text(
          message,
          style: TextStyle(color: Colors.white),
        ),
        decoration: BoxDecoration(
          color: Color(0xff4D9EF6),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
