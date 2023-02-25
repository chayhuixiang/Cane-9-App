import 'package:flutter/material.dart';
import 'package:cane_9_app/services/safezone.dart';
import 'package:cane_9_app/components/edit_button.dart';
import 'package:cane_9_app/screens/edit_location_info_page.dart';

class SafezoneCard extends StatefulWidget {
  const SafezoneCard({super.key, required this.safezone});
  final Safezone safezone;

  @override
  State<SafezoneCard> createState() => _SafezoneCardState();
}

class _SafezoneCardState extends State<SafezoneCard> {
  bool _expanded = false;

  late final notes = [
    ...widget.safezone.frequencies?.map((frequency) {
          return {"type": "frequency", "note": frequency};
        }).toList() ??
        [],
    ...widget.safezone.details?.map((detail) {
          return {"type": "detail", "note": detail};
        }).toList() ??
        []
  ];

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
                          Text(
                              "${widget.safezone.address}${widget.safezone.postal == null || widget.safezone.postal == '' ? '' : (', ${widget.safezone.postal}')}",
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
                    EditButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext bctx) {
                          return EditLocationInfoPage(sz: widget.safezone);
                        }));
                      },
                    ),
                  ],
                ),
                Container(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _expanded = !_expanded;
                      });
                    },
                    child: Column(
                      children: [
                        _expanded
                            ? ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: notes.length,
                                itemBuilder: (BuildContext bct, int index) {
                                  Map<String, String> note = notes[index];
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        top: index == 0 ? 18 : 0,
                                        bottom:
                                            index >= notes.length - 1 ? 0 : 12),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Icon(
                                            note["type"] == "frequency"
                                                ? Icons.schedule_outlined
                                                : Icons.description_outlined,
                                            color: const Color.fromRGBO(
                                                112, 112, 112, 1),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(note['note'] ?? "",
                                              softWrap: true),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              )
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
