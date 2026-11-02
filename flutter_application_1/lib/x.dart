import 'package:flutter/material.dart';
void main() {
  runApp(const AnimationApp());
}
class AnimationApp extends StatelessWidget {
  const AnimationApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Animation Types-24wh1a05ay',
      theme: ThemeData(
        fontFamily: 'Arial',
        scaffoldBackgroundColor: const Color(0xFFFFFBFD),
      ),
      home: const AnimationPage(),
    );}}
class AnimationPage extends StatefulWidget {
  const AnimationPage({super.key});
  @override
  State<AnimationPage> createState() => _AnimationPageState();
}
class _AnimationPageState extends State<AnimationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool fadeSelected = false;
  bool rotateSelected = false;
  bool slideSelected = false;
  bool scaleSelected = false;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
  }
  void toggleAnimation(String type) {
    setState(() {




      if (type == 'Fade') {
        fadeSelected = !fadeSelected;
      }
      if (type == 'Rotate') {
        rotateSelected = !rotateSelected;
      }
      if (type == 'Slide') {
        slideSelected = !slideSelected;
      }
      if (type == 'Scale') {
        scaleSelected = !scaleSelected;
      }
    });
    _controller.forward(from: 0);
  }
  Widget animatedCard() {
    Widget card = const Icon(
      Icons.favorite,
      color: Colors.pink,
      size: 100,
    );
    if (scaleSelected) {
      card = ScaleTransition(
        scale: Tween<double>(
          begin: 0.5,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOutBack,
          ),),
        child: card,
      );}
    if (slideSelected) {
      card = SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-1.0, 0),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOut,
          ),),




        child: card,
      );}
    if (rotateSelected) {
      card = RotationTransition(
        turns: Tween<double>(
          begin: 0,
          end: 1,
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeInOut,
          ),),
        child: card,
      );}
    if (fadeSelected) {
      card = FadeTransition(
        opacity: CurvedAnimation(
          parent: _controller,
          curve: Curves.easeIn,
        ),
        child: card,
      );}
    return card;
  }
  Widget animationButton(String title) {
    bool selected = false;
    if (title == 'Fade') {
      selected = fadeSelected;
    } else if (title == 'Rotate') {
      selected = rotateSelected;
    } else if (title == 'Slide') {
      selected = slideSelected;
    } else if (title == 'Scale') {
      selected = scaleSelected;
    }
    return ElevatedButton(
      onPressed: () {
        toggleAnimation(title);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: selected ? Colors.pink : Colors.white,
        foregroundColor: selected ? Colors.white : Colors.pink,
        side: const BorderSide(




          color: Colors.pink,
        ),),
      child: Text(title),
    );}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation Types-24wh1a05ay'),

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            animatedCard(),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                animationButton('Fade'),
                const SizedBox(width: 8),
                animationButton('Rotate'),
                const SizedBox(width: 8),
                animationButton('Slide'),
                const SizedBox(width: 8),
                animationButton('Scale'),
              ],),],),),);}
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

