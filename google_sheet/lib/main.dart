import 'package:flutter/material.dart';
import 'package:google_sheet/controleur.dart';
import 'package:google_sheet/models/form.dart';
import 'package:http/http.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final _scafoldKey = GlobalKey<ScaffoldState>();

  //TextFieldController
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController feedbackController = TextEditingController();

  void submitForm() {
    if (_formKey.currentState.validate()) {
      FeedbackForm feedBackForm = FeedbackForm(
        nameController.text,
        emailController.text,
        phoneController.text,
        feedbackController.text,
      );
      FormController formController = FormController((String response) {
        //print("Response: $response");
        if (response == FormController.STATUS_SUCCESS) {
          //
          _showSnackBar("Feedback Submitted");
        } else {
          _showSnackBar("Error Occurred!");
        }
      });

      _showSnackBar("envoi en cours ...");
      formController.submitForm(feedBackForm);
    }
  }

  _showSnackBar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    _scafoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scafoldKey,
      body: Form(
        key: _formKey,
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 100, horizontal: 24),
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Entrez un nom valide";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(hintText: "Nom"),
                ),
                TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Entrez un email valide";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(hintText: "Email"),
                ),
                TextFormField(
                  controller: phoneController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Entrez un téléphone valide";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(hintText: "Telephone"),
                ),
                TextFormField(
                  controller: feedbackController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Entrez une remarque";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(hintText: "Remarques"),
                ),
                RaisedButton(
                  onPressed: () {
                    submitForm();
                  },
                  child: Text("Sauvegarder"),
                )
              ],
            )),
      ),
    );
  }
}
