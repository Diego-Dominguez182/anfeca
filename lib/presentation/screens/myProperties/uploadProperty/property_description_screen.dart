import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; 
import 'package:resty_app/core/app_export.dart';
import 'package:resty_app/presentation/screens/myProperties/uploadProperty/property_price_screen.dart';
import 'package:resty_app/presentation/widgets/app_bar/custom_app_bar.dart';

final currentUser = FirebaseAuth.instance.currentUser;
final userId = currentUser?.uid;

class PropertyDescriptionScreen extends StatefulWidget {
  final String? idProperty;
  const PropertyDescriptionScreen({Key? key, this.idProperty}) : super(key: key);

  @override
  _PropertyDescriptionScreen createState() => _PropertyDescriptionScreen();
}


class _PropertyDescriptionScreen extends State<PropertyDescriptionScreen> {
  String? existingPropertyId;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: ListView(
          children: [
            SizedBox(height: 20),
            _buildMessage(context),
            SizedBox(height: 20),
            _buildRoomButton(context),
            SizedBox(height: screenHeight * .33),
            _buildAppBar(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      backgroundColor: Colors.white,
      leadingWidth: 48,
      leftText: "Atrás",
      rightText: "Siguiente",
      showBoxShadow: false,
      onTapLeftText: () {
        Navigator.pushNamed(context, AppRoutes.uploadPropertyScreen);
      },
      onTapRigthText: () {
        _saveProperty();
        Navigator.push(
          context, MaterialPageRoute(
            builder: (context) => PropertyPriceScreen(idProperty: widget.idProperty)));

      },
    );
  }

  Widget _buildMessage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        "Añade una descripción corta",
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildRoomButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              "Título:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: "Ingresa un título",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.green, width: 2),
                ),
              ),
              maxLength: 50,
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              "Descripción:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                hintText: "Ingresa una descripción corta",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.green, width: 2),
                ),
              ),
              maxLines: 4,
              keyboardType: TextInputType.multiline,
              maxLength: 200,
            ),
          ),
        ],
      ),
    );
  }

void _saveProperty() {
  String title = _titleController.text;
  String description = _descriptionController.text;

  if (title.isNotEmpty && description.isNotEmpty) {
    FirebaseFirestore.instance.collection('Property').doc(widget.idProperty).update({
      'title': title,
      'description': description,
    });
  } else {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text("Por favor, completa todos los campos."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
}