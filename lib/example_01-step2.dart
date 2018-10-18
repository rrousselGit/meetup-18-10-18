import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meetup/localization.dart';

abstract class _UnicornState {
  Set<int> get selectedIndexes;

  void onFavoriteClick(int index);
}

typedef _UnicornBuilder = Widget Function(
    BuildContext context, _UnicornState state);

class _UnicornController extends StatefulWidget {
  final _UnicornBuilder builder;

  const _UnicornController({Key key, this.builder}) : super(key: key);

  @override
  _UnicornControllerState createState() => _UnicornControllerState();
}

class _UnicornControllerState extends State<_UnicornController>
    implements _UnicornState {
  Set<int> selectedIndexes = Set();

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, this);
  }

  @override
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
}

class Example01 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _UnicornController(
      builder: (context, unicornState) {
        return Scaffold(
          appBar: AppBar(
            title: Text('One widget = One feature'),
          ),
          body: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemBuilder: (context, index) {
              return UnicornItem(
                favorite: unicornState.selectedIndexes.contains(index),
                onFavoriteClick: () => unicornState.onFavoriteClick(index),
              );
            },
          ),
        );
      },
    );
  }
}

class UnicornItem extends StatelessWidget {
  final bool favorite;
  final VoidCallback onFavoriteClick;

  const UnicornItem({
    Key key,
    this.favorite = false,
    this.onFavoriteClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.circular(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset('assets/unicorn.jpg'),
            UnicornItemFooter(
              favorite: favorite,
              onFavoriteClick: onFavoriteClick,
            ),
          ],
        ),
        elevation: 8.0,
      ),
    );
  }
}

class UnicornItemFooter extends StatelessWidget {
  const UnicornItemFooter({
    Key key,
    @required this.favorite,
    @required this.onFavoriteClick,
  }) : super(key: key);

  final bool favorite;
  final VoidCallback onFavoriteClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            DemoLocalization.of(context).unicornTitle,
            style: Theme.of(context).textTheme.display1,
          ),
          IconButton(
            color: Colors.pink,
            splashColor: Colors.pinkAccent,
            icon: Icon(favorite ? Icons.favorite : Icons.favorite_border),
            onPressed: onFavoriteClick,
          )
        ],
      ),
    );
  }
}
