import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _randomWords = <WordPair>[];
  final _savedWords = Set<WordPair>();
  Widget _buildList() {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, item) {
          if (item.isOdd) return Divider();

          final index = item ~/ 2;

          if (index >= _randomWords.length) {
            _randomWords.addAll(generateWordPairs().take(10));
          }

          return _buildRow(_randomWords[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _savedWords.contains(pair);

    return ListTile(
      title: Text(
        pair.asCamelCase,
        style: TextStyle(fontSize: 18.0),
      ),
      trailing: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.red : null),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _savedWords.remove(pair);
          } else {
            _savedWords.add(pair);
          }
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      final Iterable<ListTile> tiles = _savedWords.map((WordPair pair) {
        return ListTile(
          title: Text(
            pair.asCamelCase,
            style: TextStyle(fontSize: 16.0),
          ),
        );
      });

      final List<Widget> divide =
          ListTile.divideTiles(context: context, tiles: tiles).toList();
      return Scaffold(
        appBar: AppBar(title: Text('Saved Word Pairs')),
        body: ListView(
          children: divide,
        ),
      );
    }));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Word Pairs'),
        actions: <Widget>[
          IconButton(onPressed: _pushSaved, icon: Icon(Icons.list))
        ],
      ),
      body: _buildList(),
    );
  }
}
