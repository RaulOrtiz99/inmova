import 'package:flutter/material.dart';
import 'package:rennyproject/pages/consultas_form_page.dart';
import 'package:rennyproject/pages/contact_form_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MaterialButton(
            child: Text("Formulario de consulta"),
            color: Colors.amber,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>InquiryForm()));
            },
          ),
          MaterialButton(
            child: Text("Formulario de contacto"),
            color: Colors.blue,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ContactForm()));
            },
          ),
        ],
      )),
    );
  }
}
