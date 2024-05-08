import 'package:flutter/material.dart';

class FormButtonWidget extends StatefulWidget {
  final String? text;
  final Color backgroundColor;
  final Color textColor;
  final void Function()? onPressed;
  
  const FormButtonWidget({
    super.key,
    this.text,
    required this.backgroundColor,
    required this.textColor,
    this.onPressed,
  });

  @override
  // ignore: library_private_types_in_public_api
  _FormButtonWidgetState createState() => _FormButtonWidgetState();
}

class _FormButtonWidgetState extends State<FormButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ElevatedButton(
          onPressed: () {
            widget.onPressed!();
          },
          style: ButtonStyle(
            backgroundColor:
                MaterialStatePropertyAll<Color>(widget.backgroundColor),
            fixedSize: const MaterialStatePropertyAll<Size>(Size(270, 50)),
          ),
          child: Text(
            widget.text as String,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: widget.textColor,
            ),
          ),
        ),
      ),
    );
  }
}
