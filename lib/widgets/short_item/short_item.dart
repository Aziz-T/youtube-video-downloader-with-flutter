
import 'package:flutter/material.dart';

class ShortItem extends StatelessWidget {
  final String? url;
  final String? title;
  final String? imageUrl;
  const ShortItem({Key? key, this.url, this.title, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      color: Colors.red,
      child: imageUrl != null ? Image.network(imageUrl!):Icon(Icons.network_cell),
    );
  }
}
