import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'models/form.dart';

class FormController {
  // Callback function to give response of status of current request.
  final void Function(String) callback;

  // Google App Script Web URL
  static const String URL =
      "https://script.google.com/macros/s/AKfycbzQqcyz3eoN6PjteSu1TrO9xEIJfVnMlXNyT6IFz8Y9v60PZKY/exec";
  //https://script.google.com/macros/s/AKfycbyUpuMSKhvqSQQ0HeHQj2KOa9sXawYSN_z22bYK6bUt6Bvc_oa-/exec

  static const STATUS_SUCCESS = "SUCCESS";

  FormController(this.callback);

  void submitForm(FeedbackForm feedbackForm) async {
    try {
      await http.get(URL + feedbackForm.toParams()).then((response) {
        callback(convert.jsonDecode(response.body)['status']);
      });
    } catch (e) {
      print(e);
    }
  }
}
