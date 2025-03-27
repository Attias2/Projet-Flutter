import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class EmailInputField extends StatelessWidget {

  EmailInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        labelText: "Enter Email",
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter an email';
        } else if (!EmailValidator.validate(value)) {
          return 'Invalid email format';
        }
        return null;
      },
    );
  }
}
