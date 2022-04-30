import 'package:flutter/material.dart';

import '../../widgets/short_item/short_item.dart';

class ShortListPage extends StatefulWidget {
  const ShortListPage({Key? key}) : super(key: key);

  @override
  State<ShortListPage> createState() => _ShortListPageState();
}

class _ShortListPageState extends State<ShortListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount: 2,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
          // Generate 100 widgets that display their index in the List.
          children: List.generate(100, (index) {
            return ShortItem(

            );
          }),
        ),
      ),
    );
  }
}
