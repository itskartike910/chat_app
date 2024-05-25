import 'package:chat_app/widgets/consts.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FormContainerWidget extends StatefulWidget {
  final TextEditingController? controller;
  final Key? fieldKey;
  final bool? isPasswordField;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputType? inputType;
  String? value;
  bool enabled;
  final IconData? icon;
  // ignore: prefer_const_constructors_in_immutables
  FormContainerWidget({
    super.key,
    this.controller,
    this.isPasswordField,
    this.fieldKey,
    this.hintText,
    this.labelText,
    this.helperText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
    this.inputType,
    this.value,
    this.enabled = true,
    this.icon,
  });

  @override
  // ignore: library_private_types_in_public_api
  _FormContainerWidgetState createState() => _FormContainerWidgetState();
}

class _FormContainerWidgetState extends State<FormContainerWidget> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: TextFormField(
          style: const TextStyle(color: Colors.black),
          controller: widget.controller,
          keyboardType: widget.inputType,
          key: widget.fieldKey,
          obscureText: widget.isPasswordField == true ? _obscureText : false,
          onSaved: widget.onSaved,
          validator: widget.validator,
          onFieldSubmitted: widget.onFieldSubmitted,
          onChanged: (text) {
            setState(() {
              widget.value = text;
            });
          },
          enabled: widget.enabled,
          decoration: InputDecoration(
            labelText: widget.labelText,
            border: const OutlineInputBorder(
              borderSide: BorderSide(width: 2),
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
            ),
            filled: true,
            fillColor: const Color.fromARGB(255, 192, 254, 224),
            hintText: widget.hintText,
            prefixIcon: Icon(
              widget.icon,
              color: blueColor,
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              child: widget.isPasswordField == true
                  ? Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: _obscureText == false ? Colors.blue : Colors.grey,
                    )
                  : const Text(""),
            ),
          ),
        ),
      ),
    );
  }
}
