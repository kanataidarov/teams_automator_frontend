import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:interview_automator_frontend/data/dynamic.dart';
import 'package:interview_automator_frontend/storage/model/qa.dart';
import 'package:interview_automator_frontend/widget/drawer.dart';
import 'package:interview_automator_frontend/widget/qa_modal.dart';
import 'package:provider/provider.dart';

class QaList extends StatefulWidget {
  const QaList({super.key});

  @override
  State<StatefulWidget> createState() => _QaListState();
}

class _QaListState extends State<QaList> {
  late final List<Qa> _items;

  @override
  void initState() {
    final qas = Qa.questions();
    _items = List<Qa>.generate(
        qas.length, (int i) => Qa(title: 'Q&A $i', ord: i, question: qas[i]));
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
      var data = context.read<TempData>();

      return List.generate(
          _items.length,
          (idx) => ReorderableDragStartListener(
              index: idx,
              key: Key('$idx'),
              child: Card(
                child: ListTile(
                    title: Text(_items[idx].title),
                    tileColor: idx.isOdd ? oddItemColor : evenItemColor,
                    leading: const Icon(Icons.drag_indicator),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outlined),
                      onPressed: () {
                        setState(() {
                          _items.removeAt(idx);
                        });
                      },
                    ),
                    onTap: () {
                      showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => QaModal(
                              getSetting: data.getQuestion,
                              idx: idx)).then((val) {
                        if (null != val) {
                          data.updateQuestion(idx, val);
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
