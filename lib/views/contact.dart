import 'package:flutter/material.dart';
import '../models/drawner.dart';
import 'package:email_validator/email_validator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:mailgun_mailer/src/mailer.dart';
import 'package:mailgun_mailer/src/model/request.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const Contact());

class Contact extends StatelessWidget {
  const Contact({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Form Validation Demo';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        drawer: Drawner(),
        appBar: AppBar(
          title: const Text(appTitle)
        ),
        body: const MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.

  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    contentController.dispose();
    nameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form( 
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget> [
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 20, top: 10, bottom: 15),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "Enter Email",
                border: OutlineInputBorder(),
                helperText: '',
              ),
              validator: (value) {//validateur de l'email
                if (value == null || value.isEmpty) {//teste si la saisi est null
                  return 'Please enter an email';
                } else if (!EmailValidator.validate(value)) {//teste si la saisi est un mail
                  return 'Invalid email format';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 20, top: 10, bottom: 15),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "Enter Name",
                border: OutlineInputBorder(),
                helperText: '',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 20, top: 10, bottom: 15),
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: "Enter The content of the email",
                border: OutlineInputBorder(),
                helperText: '', // Réserve l'espace pour le message d'erreur
                //afin que le reste des champs ne bouge pas si le message apparait
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ElevatedButton(
              onPressed: () {
                Future sendEmail(String email, String content, String name) async {
                    final response = await http.post(
                      Uri.parse('https://api.mailgun.net/v3/sandboxe95c06f3b1c442daa9accd22c73de3af.mailgun.org/messages'),
                      headers: <String, String>{
                        'Content-Type': 'application/json; charset=UTF-8',
                      },
                      body: jsonEncode(<String, String>{
                        'api': '07675d62bd252f997cf58750f202e48c-f6202374-b014c4c8',
                        'content': content,
                        'to': email,
                        "from": "Mailgun Sandbox <postmaster@sandboxe95c06f3b1c442daa9accd22c73de3af.mailgun.org>",
                        "subject": "Hello "+name,
                        'text': content
                      }),
                    );

                    if (response.statusCode == 201) {
                      // If the server did return a 201 CREATED response,
                      // then parse the JSON.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Envoie réussie"))
                      );
                      //return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
                    } else {
                      // If the server did not return a 201 CREATED response,
                      // then throw an exception.
                      log('data: $response');
                      debugPrint(response.body);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("echec"))
                      );
                    }
                }
                void main(String emailE, String content, String name) async {
                  final apiKey = '07675d62bd252f997cf58750f202e48c-f6202374-b014c4c8';
                  final domain = 'sandboxe95c06f3b1c442daa9accd22c73de3af.mailgun.org';
                  try {
                    final mailService = MailgunMailer(
                      apiKey: apiKey,
                      domain: domain,
                    );

                    final email = MailRequest(
                      content: content,
                      from: 'postmaster@sandboxe95c06f3b1c442daa9accd22c73de3af.mailgun.org',
                      to: [emailE],
                      subject: 'Hola '+name,
                    );

                    await mailService.send(email);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Envoie réussie"))
                    );
                  } catch (e) {
                    log('Error: $e');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("echec"))
                    );
                  }
                }
                
                if (_formKey.currentState!.validate()) {
                  String email = emailController.text;
                  String content = contentController.text;
                  String name = nameController.text;
                  main(email, content, name);
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );

  }
}