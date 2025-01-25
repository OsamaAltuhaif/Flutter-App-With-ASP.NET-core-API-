import 'package:flutter/material.dart';

class TuhaifButton extends StatelessWidget {
  final Function? onTab;
  final double? redus;
  final Widget? child;
  final Color? backgroundColor;
  final double? border;
  final double? margin;
  final double? padding;
  TuhaifButton({
    super.key,
    this.onTab,
    this.redus,
    this.child,
    this.backgroundColor,
    this.border,
    this.margin,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTab;
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: 40,
        padding: EdgeInsets.all(padding!),
        margin: EdgeInsets.all(margin!),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.deepPurple,
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(-1, 0))
          ],
          borderRadius: BorderRadius.circular(redus!),
          border: Border.all(
            style: BorderStyle.solid,
            width: 2,
            color: Colors.blue,
          ),
        ),
        child: child,
      ),
    );
  }
}
