import 'package:flutter/material.dart';

import 'package:my_movies_app/src/constants/colors.dart';

class GeneralInputWidget extends StatefulWidget {
  const GeneralInputWidget({
    Key? key,
    required this.padding,
    required this.hintText,
    this.isPassword = false,
    required this.validator,
    required this.onChange,
  }) : super(key: key);

  final EdgeInsetsGeometry padding;
  final String hintText;
  final bool isPassword;
  final Function(String) validator;
  final Function(String) onChange;

  @override
  State<GeneralInputWidget> createState() => _GeneralInputWidgetState();
}

class _GeneralInputWidgetState extends State<GeneralInputWidget> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Container(
        // height: 36,
        decoration: BoxDecoration(
          color: colors.kGreyColor.withOpacity(0.12),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: TextFormField(
                style: TextStyle(
                  color: colors.kWhiteColor.withOpacity(0.6),
                  fontSize: 17,
                  letterSpacing: -0.41,
                ),
                validator: (value) {
                  return widget.validator.call(value!);
                },
                onChanged: (value) => widget.onChange.call(value),
                obscureText: widget.isPassword ? !_showPassword : false,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  border: InputBorder.none,
                  isDense: true,
                  hintStyle: TextStyle(
                    color: colors.kWhiteColor.withOpacity(0.6),
                    fontSize: 17,
                    letterSpacing: -0.41,
                  ),
                  errorStyle: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                    letterSpacing: -0.41,
                  ),
                ),
              ),
            ),
            if (widget.isPassword)
              GestureDetector(
                onTap: () {
                  setState(() {
                    _showPassword = !_showPassword;
                  });
                },
                child: Icon(
                  !_showPassword ? Icons.remove_red_eye : Icons.hide_source,
                  color: colors.kWhiteColor,
                ),
              ),
            const SizedBox(
              width: 8,
            ),
          ],
        ),
      ),
    );
  }
}
