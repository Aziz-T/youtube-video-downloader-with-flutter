import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Color? color;
  final String? title;
  final double? height;
  final double? width;
  final double? fontSize;
  final bool? hasPadding;
  const MainButton(
      {Key? key,
      this.onTap,
      this.color,
      this.title,
      this.height,
      this.width,
      this.fontSize,
      this.hasPadding=true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width ?? _size.width * 0.5,
        height: height ?? _size.width * 0.2,
        padding: hasPadding == true ? const EdgeInsets.all(20) : null,
        decoration: BoxDecoration(
          color: color ?? Colors.red,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Center(
            child: Text(
          title ?? "-",
          style: TextStyle(
              fontSize: fontSize ?? 23,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}
