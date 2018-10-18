import 'package:flutter/material.dart';
import 'package:meetup/localization.dart';

class Example01 extends StatefulWidget {
  @override
  Example01State createState() {
    return new Example01State();
  }
}

class Example01State extends State<Example01> {
  Set<int> selectedIndexes = Set();

  void onFavoriteClick(int index) {
    if (selectedIndexes.contains(index)) {
      setState(() {
        selectedIndexes = Set.from(selectedIndexes)..remove(index);
      });
    } else {
      setState(() {
        selectedIndexes = Set.from(selectedIndexes)..add(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('One widget = One feature'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset('assets/unicorn.jpg'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          DemoLocalization.of(context).unicornTitle,
                          style: Theme.of(context).textTheme.display1,
                        ),
                        IconButton(
                          icon: Icon(selectedIndexes.contains(index)
                              ? Icons.favorite
                              : Icons.favorite_border),
                          onPressed: () => onFavoriteClick(index),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              elevation: 8.0,
            ),
          );
        },
        padding: const EdgeInsets.all(8.0),
      ),
    );
  }
}