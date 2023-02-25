import 'package:flutter/material.dart';
import 'package:cane_9_app/components/label_title.dart';

class LabelInputCombinedExpanded extends StatefulWidget {
  final String hintText;
  final double height;
  final int maxLines;
  final TextEditingController controller;

  const LabelInputCombinedExpanded({
    super.key,
    required this.hintText,
    required this.height,
    required this.maxLines,
    required this.controller,
  });

  @override
  State<LabelInputCombinedExpanded> createState() =>
      _LabelInputCombinedExpandedState();
}

class _LabelInputCombinedExpandedState
    extends State<LabelInputCombinedExpanded> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        LabelTitle(widget.hintText),
        const SizedBox(height: 2),
        Flexible(
          child: TextField(
            maxLines: 2,
            minLines: 1,
            keyboardType: TextInputType.multiline,
            controller: widget.controller,
            textAlign: TextAlign.left,
            decoration: InputDecoration(
              border: InputBorder.none,
              // focusedBorder: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
              isDense: true,
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
