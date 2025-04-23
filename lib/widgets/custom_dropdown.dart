import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> items;
  final String? initialValue;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final String hint;
  final String? label;
  final String? prefixIconAsset; // Path to left-side SVG icon asset
  final double? prefixIconWidth; // Dynamic width for the prefix icon
  final double? prefixIconHeight; // Dynamic height for the prefix icon
  final Color? arrowColor; // Right-side arrow color

  const CustomDropdown({
    Key? key,
    required this.items,
    this.initialValue,
    this.onChanged,
    this.validator,
    required this.hint,
    this.label,
    this.prefixIconAsset, // Path to left-side SVG icon asset
    this.prefixIconWidth, // Dynamic width for the prefix icon
    this.prefixIconHeight, // Dynamic height for the prefix icon
    this.arrowColor, // Right-side arrow color
  }) : super(key: key);

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue =
        widget.initialValue ??
        widget.items.first; // Ensure there's a default value
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Optional label
        if (widget.label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              widget.label!,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),

        DropdownButtonFormField<String>(
          value: _selectedValue,
          isExpanded: true,
          decoration: InputDecoration(
            hintText: widget.hint,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 18,
              horizontal: 16,
            ),
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
            // Left side icon
            prefixIcon:
                widget.prefixIconAsset != null
                    ? Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset(
                        widget.prefixIconAsset!,
                        width: widget.prefixIconWidth,
                        height: widget.prefixIconHeight,
                      ),
                    )
                    // ? SvgPicture.asset(
                    //     widget.prefixIconAsset!,
                    //     width: widget.prefixIconWidth ?? 15, // Default width
                    //     height: widget.prefixIconHeight ?? 15, // Default height
                    //   )
                    : null,
          ),
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: widget.arrowColor ?? Colors.black, // Right side arrow color
          ),
          items:
          
              widget.items
                  .map(
                    (item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    ),
                  )
                  .toList(),
          validator: widget.validator,
          
          onChanged: (value) {
            setState(() {
              _selectedValue = value;
            });
            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
          },
        ),
      ],
    );
  }
}
