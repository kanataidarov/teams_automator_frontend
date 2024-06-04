import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:interview_automator_frontend/storage/db.dart';
import 'package:interview_automator_frontend/storage/model/qa.dart';
import 'package:interview_automator_frontend/widget/drawer.dart';
import 'package:interview_automator_frontend/widget/qa_modal.dart';
import 'package:logger/logger.dart' show Level, Logger;
import 'package:sqflite/sqflite.dart';

Logger _logger = Logger(level: Level.debug);

class QaList extends StatefulWidget {
  const QaList({super.key});

  @override
  State<StatefulWidget> createState() => _QaListState();
}

class _QaListState extends State<QaList> {
  late Database _db;
  List<Qa> _items = List.empty();

  @override
  void initState() {
    DbHelper.instance.database.then((db) async {
      _db = db;
      final List<Map<String, dynamic>> maps = await db.query(Qa.tableName);
      _items = List.generate(maps.length, (i) => Qa.fromMap(maps[i]));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Questions & Answers')),
        drawer: const DrawerWidget(),
        body: SafeArea(
          child: qaList(context),
        ));
  }

  Widget qaList(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.secondary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.secondary.withOpacity(0.15);
    final Color draggableItemColor = colorScheme.secondary;

    Widget proxyDecorator(
        Widget child, int index, Animation<double> animation) {
      return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          final double animValue = Curves.easeInOut.transform(animation.value);
          final double elevation = lerpDouble(0, 6, animValue)!;
          return Material(
            elevation: elevation,
            color: draggableItemColor,
            shadowColor: draggableItemColor,
            child: child,
          );
        },
        child: child,
      );
    }

    List<Widget> generate(BuildContext context) {
      return List.generate(
          _items.length,
          (i) => ReorderableDragStartListener(
              index: i,
              key: Key('$i'),
              child: Card(
                child: ListTile(
                    title: Text(_items[i].title!),
                    tileColor: i.isOdd ? oddItemColor : evenItemColor,
                    leading: const Icon(Icons.drag_indicator),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outlined),
                      onPressed: () {
                        setState(() {
                          _items.removeAt(i);
                        });
                      },
                    ),
                    onTap: () {
                      showDialog<Qa>(
                              context: context,
                              builder: (BuildContext context) =>
                                  QaModal(qa: _items[i]))
                          .then((qa) {
                        if (null != qa) {
                          _logger.d(qa);
                        }
                      });
                    }),
              )));
    }

    return ReorderableListView(
      padding: const EdgeInsets.symmetric(horizontal: 33),
      proxyDecorator: proxyDecorator,
      children: generate(context),
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final Qa item = _items.removeAt(oldIndex);
          _items.insert(newIndex, item);
        });
      },
    );
  }
}
