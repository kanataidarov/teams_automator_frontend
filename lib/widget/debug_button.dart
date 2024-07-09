import 'package:flutter/material.dart';

class DebugButton extends StatelessWidget {
  final Function isDebugEnabled;
  final Function handle;

  const DebugButton(BuildContext context,
      {super.key, required this.isDebugEnabled, required this.handle});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: isDebugEnabled(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          Widget cnt = Container();
          if (snapshot.hasData) {
            bool isDebug = snapshot.data!;
            if (isDebug) {
              cnt = FloatingActionButton(
                  onPressed: () => handle(context),
                  tooltip: 'Debug',
                  child: const Icon(Icons.telegram_outlined));
            }
          }
          return cnt;
        });
  }
}
