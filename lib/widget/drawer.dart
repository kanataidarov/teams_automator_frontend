import 'package:flutter/material.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<StatefulWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext ctx) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
              decoration: BoxDecoration(color: Colors.teal),
              child: Text('Menu')),
          ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Home'),
              onTap: () {
                navigate(ctx, '/');
              }),
          ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: const Text('Settings'),
              onTap: () {
                navigate(ctx, '/settings');
              }),
          ListTile(
              leading: const Icon(Icons.question_answer_outlined),
              title: const Text('Q&A'),
              onTap: () {
                navigate(ctx, '/qa');
              })
        ],
      ),
    );
  }

  navigate(BuildContext ctx, String routeName) {
    Future.delayed(Duration.zero, () {
      Navigator.pop(ctx);
      Navigator.pushNamed(ctx, routeName);
    });
  }
}
