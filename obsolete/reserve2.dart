import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:parkway/map.dart';

void main() {
  runApp(ReserveList());
}

class ReserveList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ParkWay',
      theme: new ThemeData(
          fontFamily: 'Raleway',
          primaryColor: Colors.blue,
          accentColor: Colors.white),
      home: RandomWords(),
    );
  }
}

class RandomWordsState extends State<RandomWords> {
//this class saves the generated word pairs
  final List<WordPair> _suggestions = <WordPair>[];
  final Set<WordPair> _saved = new Set<WordPair>();
  final TextStyle _biggerFont =
      const TextStyle(fontSize: 18.0); //underscore enforces privacy
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MapPage()),
          ),
        ),
        title: new Text("Select a location"),
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    //function that will build the list(table)View
    return ListView.builder(
        padding: const EdgeInsets.all(16.0), //padding of 16 points on all sides
        itemBuilder: (context, i) {
          //1
          if (i.isOdd) return Divider(); //2
          final index = i ~/ 2; //3
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); //4
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(
        pair); //check word pair has not already been added to favorites
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
            (WordPair pair) {
              return new ListTile(
                title: new Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();
          return new Scaffold(
            appBar: AppBar(
              title: const Text("Saved Suggestions"),
            ),
            body: new ListView(children: divided),
          );
        },
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  //creates its state class
  @override
  RandomWordsState createState() => RandomWordsState();
}
