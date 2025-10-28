import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final InputBorder? enabledBorder;
  const MyTextField({
    super.key,
    required this.controller,
    this.labelText,
    this.hintText,
    this.enabledBorder,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d{1,5}\.?\d{0,3}')),
      ],
      style: TextStyle(
        fontSize: 0.02 * MediaQuery.of(context).size.height,
      ),
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 0.02 * MediaQuery.of(context).size.height,
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          fontSize: 0.018 * MediaQuery.of(context).size.height,
        ),
        contentPadding:
            EdgeInsets.all(0.02 * MediaQuery.of(context).size.height),
        enabledBorder: widget.enabledBorder,
        focusedBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(0.015 * MediaQuery.of(context).size.height),
          borderSide: BorderSide(
              color: const Color.fromARGB(255, 14, 44, 239),
              width: 0.003 * MediaQuery.of(context).size.height),
        ),
      ),
    );
  }
}
