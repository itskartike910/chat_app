import 'package:chat_app/helper/widgets/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormButtonWidget extends StatefulWidget {
  final String? text;
  final Color? backgroundColor;
  final Color? textColor;
  final String imagePath;
  final void Function()? onPressed;

  const FormButtonWidget({
    super.key,
    required this.text,
    this.backgroundColor,
    this.textColor,
    this.imagePath = "",
    required this.onPressed,
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
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
        child: InkWell(
          splashColor: blueColor,
          child: CupertinoButton(
            onPressed: () {
              widget.onPressed!();
            },
            borderRadius: const BorderRadius.all(Radius.circular(30.0)),
            color: widget.backgroundColor,
            disabledColor: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                (widget.imagePath != "")
                    ? Image.asset(
                        widget.imagePath,
                        height: 18,
                        width: 18,
                      )
                    : const Text(""),
                (widget.imagePath != "") ? sizeHor(10) : sizeHor(0),
                Text(
                  widget.text as String,
                  softWrap: true,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: widget.textColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
