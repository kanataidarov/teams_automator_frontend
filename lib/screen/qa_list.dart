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
    super.initState();

    DbHelper.instance.database.then((db) {
      setState(() {
        _db = db;
        db.query(Qa.tableName, orderBy: 'ord').then((maps) {
          _items = List.generate(maps.length, (i) => Qa.fromMap(maps[i]));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Questions & Answers')),
      drawer: const DrawerWidget(),
      body: SafeArea(
        child: _qaList(context),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: _addQa, tooltip: 'New Q&A', child: const Icon(Icons.add)),
    );
  }

  Widget _qaList(BuildContext context) {
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
                        final rec = _items[i];
                        QaProvider.instance.delete(rec);
                        setState(() {
                          _items.removeAt(i);
                        });
                        _logger.d('$rec deleted');
                      },
                    ),
                    onTap: () {
                      showDialog<Qa>(
                          context: context,
                          builder: (BuildContext context) =>
                              QaModal(qa: _items[i])).then((qa) {
                        if (null != qa) {
                          QaProvider.instance.update(qa);
                          _logger.d('$qa updated');
                          setState(() {});
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

  void _addQa() {
    showDialog<Qa>(
        context: context,
        builder: (BuildContext context) {
          final emptyQa = Qa(question: '');
          return QaModal(qa: emptyQa);
        }).then((newQa) {
      if (null != newQa) {
        QaProvider.instance.insert(newQa).then((id) {
          newQa.id = id;
          setState(() {
            _items.add(newQa);
          });
        });
      }
    });
  }
}
