import 'package:flutter/material.dart';

class CustomExpansionTile extends StatefulWidget {
  final Widget title;
  final Widget subtitle;
  final List<Widget>? children;

  const CustomExpansionTile({
    Key? key,
    required this.title,
    required this.subtitle,
    this.children,
  }) : super(key: key);

  @override
  _CustomExpansionTileState createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: ListTile(
        title: widget.title,
        subtitle: widget.subtitle,
        onTap: () {
          setState(() {
            isExpanded = !isExpanded;
          });
        },
      ),
      children: [
        if (isExpanded && widget.children != null) ...widget.children!,
      ],
    );
  }
}
