import 'package:flutter/material.dart';
import 'package:gerente_loja/widgets/orders_tile.dart';

class Orderstab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: ListView.builder(
        itemBuilder: (context, index){
          return OrderTile();
        },
        itemCount: 6,
      ),
    );
  }
}
