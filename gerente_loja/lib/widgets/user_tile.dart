import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final textStyle = TextStyle(color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        'title',
        style: textStyle,
      ),
      subtitle: Text(
        'subititle',
        style: textStyle,
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            'Pedidos: 0',
            style: textStyle,
          ),
          Text(
            'Gastos: 0',
            style: textStyle,
          ),
        ],
      ),
    );
  }
}
