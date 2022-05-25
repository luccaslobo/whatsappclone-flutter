import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/view/register.view.dart';

import 'chat.view.dart';
import 'login.view.dart';
import 'mensagem.view.dart';

class App extends StatelessWidget {
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      routes: {
        '/': (context) => LoginView(),
        '/mensagens': (context) => MensagemView(),
        '/register': (context) => RegisterView(),
        '/conversa': (context) => ChatView()
      },
      initialRoute: auth.currentUser == null ? '/' : '/mensagens'
    );
  }
}