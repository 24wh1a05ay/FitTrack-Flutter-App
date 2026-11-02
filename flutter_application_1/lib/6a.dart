import 'package:flutter/material.dart';
void main() {
 runApp(const MyApp());
}
class MyApp extends StatelessWidget {
 const MyApp({super.key});
 @override
 Widget build(BuildContext context) {
 return MaterialApp(
 debugShowCheckedModeBanner: false,
 home: Scaffold(
 appBar: AppBar(
 title: const Text("Custom Button - 24WH1A05BP"),
 ),
 body: Center(
 child: CustomButton(
 text: "Click Me",
 onPressed: () {
 print("Button Clicked");
 },
 ),
 ),
 ),
 );
 }
}
class CustomButton extends StatelessWidget {
 final String text;
 final VoidCallback onPressed;
 const CustomButton({
 super.key,
 required this.text,
 required this.onPressed,
 });
 @override
 Widget build(BuildContext context) {
 return ElevatedButton(
 onPressed: onPressed,
 child: Text(text),
 );
 }
}