import 'package:flutter/material.dart';

class UrlItem extends StatelessWidget {
  final String? url;
  final VoidCallback? copyTab;
  final VoidCallback? deleteTab;
  const UrlItem({Key? key, this.url, this.copyTab, this.deleteTab}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(7),
      decoration: BoxDecoration(color: Colors.grey.withOpacity(0.4),
      borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(child:  Padding(
            padding: const EdgeInsets.only(left: 7),
            child: Text(url ??""),
          )),
          Spacer(),
          IconButton(
              onPressed: copyTab,
              icon: const Icon(
                Icons.copy,
                color: Colors.blue,
              )),
          IconButton(
              onPressed: deleteTab,
              icon: Icon(
                Icons.delete,
                color: Colors.red.withOpacity(0.6),
              ))
        ],
      ),
    );
  }
}
