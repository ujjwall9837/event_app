import 'package:flutter/material.dart';

Container signInButton(BuildContext context, Function onTap, String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 25),
    child: RawMaterialButton(
      onPressed: () {
        onTap();
      },
      child: Container(
        padding: EdgeInsets.all(25),
        decoration: BoxDecoration(
            color: Colors.deepPurple, borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      ),
    ),
  );
}
