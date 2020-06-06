import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductsSizes extends FormField<List> {
  ProductsSizes({
    List initialValue,
    FormFieldSetter<List> onSaved,
    FormFieldValidator<List> validator,
  }) : super(
            initialValue: initialValue,
            onSaved: onSaved,
            validator: validator,
            builder: (state) {
              return SizedBox(
                height: 34.0,
                child: GridView(
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                  scrollDirection: Axis.horizontal,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.5),
                  children: state.value.map((s) {
                    return GestureDetector(
                      onLongPress: () {
                        state.didChange(state.value..remove(s));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                            border: Border.all(color: Colors.lightBlueAccent)),
                        alignment: Alignment.center,
                        child: Text(
                          s,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  }).toList()
                    ..add(GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                            border: Border.all(color: Colors.lightBlueAccent)),
                        alignment: Alignment.center,
                        child: Text(
                          '+',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )),
                ),
              );
            });
}
