import 'package:flutter/material.dart';
import 'package:cane_9_app/components/label_title.dart';

class LabelInputCombinedExpanded extends StatefulWidget {
  final String hintText;
  final double height;
  final int maxLines;
  final String value;
  final TextEditingController controller;

  const LabelInputCombinedExpanded({
    super.key,
    required this.hintText,
    required this.height,
    required this.maxLines,
    required this.value,
    required this.controller,
  });

  @override
  State<LabelInputCombinedExpanded> createState() =>
      _LabelInputCombinedExpandedState();
}

class _LabelInputCombinedExpandedState
    extends State<LabelInputCombinedExpanded> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.controller.text = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const LabelTitle("Name of Place"),
        const SizedBox(height: 2),
        SizedBox(
          height: widget.height,
          width: double.infinity,
          child: TextField(
            maxLines: widget.maxLines,
            controller: widget.controller,
            textAlign: TextAlign.left,
            decoration: InputDecoration(
              border: InputBorder.none,
              // focusedBorder: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.5, horizontal: 4),
              // isDense: true,
              hintText: widget.hintText,
              hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
              filled: true,
              fillColor: const Color(0XFFD9D9D9),
            ),
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              fontFamily: "Inter",
            ),
          ),
        ),
      ],
    );
  }
}
