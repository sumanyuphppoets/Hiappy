import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'custom_dropdown.dart'; // Import the CustomDropdown widget

class CustomInput extends StatefulWidget {
  final String? label;
  final String hint;
  final String? iconAsset;
  final double iconSize;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final int maxLines;
  final bool showError;
  final String? Function(String?)? validator;
  final List<String>? dropdownItems;
  final String? initialDropdownValue;
  final void Function(String?)? onChanged;

  const CustomInput({
    Key? key,
    this.label,
    required this.hint,
    this.iconAsset,
    this.iconSize = 20.0,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.maxLines = 1,
    this.showError = false,
    this.validator,
    this.dropdownItems,
    this.initialDropdownValue,
    this.onChanged,
  }) : super(key: key);

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    final isDropdown = widget.dropdownItems != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Text(
            widget.label!,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        const SizedBox(height: 8),

        // Use CustomDropdown for dropdown logic
        isDropdown
            ? CustomDropdown(
              items: widget.dropdownItems!,
              initialValue: widget.initialDropdownValue,
              onChanged: widget.onChanged,
              validator: widget.validator,
              hint: widget.hint,
            )
            : TextFormField(
              controller: widget.controller,
              obscureText: _obscure,
              keyboardType: widget.keyboardType,
              maxLines: widget.maxLines,
              validator: widget.validator,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: _inputDecoration(
                suffix:
                    widget.obscureText
                        ? IconButton(
                          icon: Icon(
                            _obscure ? Icons.visibility_off : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscure = !_obscure;
                            });
                          },
                        )
                        : null,
              ),
            ),
        const SizedBox(height: 16),
      ],
    );
  }

  InputDecoration _inputDecoration({Widget? suffix}) {
    return InputDecoration(
      hintText: widget.hint,
      prefixIcon:
          widget.iconAsset != null
              ? Padding(
                padding: const EdgeInsets.all(12.0),
                child: SvgPicture.asset(
                  widget.iconAsset!,
                  width: widget.iconSize,
                  height: widget.iconSize,
                ),
              )
              : null,
      suffixIcon: suffix,
      errorStyle: const TextStyle(height: 0), // Hide error text
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Color.fromRGBO(33, 33, 33, 0.1),
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Color.fromRGBO(33, 33, 33, 0.1),
          width: 1,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.red, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.red, width: 1),
      ),
    );
  }
}
