import 'package:flutter/material.dart';

class AddSizeDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(),
            Container(
              alignment: Alignment.centerRight,
              child: FlatButton(
                child: Text('Add'),
                textColor: Theme.of(context).primaryColor,
                onPressed: (){},
              ),
            )
          ],
        ),

      ),
    );
  }
}
