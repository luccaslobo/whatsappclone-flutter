import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  String email = '';
  String senha = '';
  String nome = '';

  void save(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      var result = await auth.createUserWithEmailAndPassword(email: email, password: senha);
      
      await result.user!.updateDisplayName(nome);

      firestore.collection('usuarios').doc(result.user!.uid).set({
        "nome": result.user!.displayName,
        "email": result.user!.email,
        "uid": result.user!.uid,
        "photoUrl": ""
      });


      Navigator.of(context).pushNamed('/mensagens');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              onSaved: (value) => nome = value!,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Campo nome obrigatório";
                }
                return null;
              },
            ),
            TextFormField(
              onSaved: (value) => email = value!,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Campo e-mail obrigatório";
                }
                return null;
              },
            ),
            TextFormField(
              obscureText: true,
              onSaved: (value) => senha = value!,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Campo senha obrigatório";
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () => save(context),
              child: Text("Entrar"),
            )
          ],
        ),
      ),
    );
  }
}
