import 'package:flutter/material.dart';
import 'package:cane_9_app/services/safezone.dart';
import 'package:cane_9_app/components/edit_button.dart';

class SafezoneCard extends StatefulWidget {
  const SafezoneCard({super.key, required this.safezone});
  final Safezone safezone;

  @override
  State<SafezoneCard> createState() => _SafezoneCardState();
}

class _SafezoneCardState extends State<SafezoneCard> {
  bool _expanded = false;
  bool _animationDone = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(widget.safezone.url),
                      radius: 23,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.safezone.name ?? "",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(widget.safezone.address ?? "",
                              softWrap: true,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12,
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    EditButton(onPressed: () {}),
                  ],
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  onEnd: () {
                    setState(() {
                      _animationDone = !_animationDone;
                    });
                  },
                  height: _expanded ? 41 : 24,
                  curve: Curves.easeInOut,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _expanded = !_expanded;
                      });
                    },
                    child: Column(
                      children: [
                        _animationDone && _expanded
                            ? const Text("CB!")
                            : const SizedBox.shrink(),
                        SizedBox(
                          width: double.infinity,
                          child: AnimatedRotation(
                            duration: const Duration(milliseconds: 200),
                            turns: _expanded ? 0.5 : 1,
                            child: const Icon(
                              Icons.expand_more,
                            ),
                          ),
                        ),
                      ],
                    ),
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
