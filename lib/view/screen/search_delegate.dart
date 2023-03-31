import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MySearchDelegate extends SearchDelegate<String> {
  // final List<String> data = [
  //   'apple',
  //   'banana',
  //   'cherry',
  //   'date',
  //   'elderberry',
  //   'fig',
  //   'grape'
  // ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    log(query);
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .where("name", isEqualTo: query.toString())
          .snapshots(),
      builder: (context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var data = snapshot.data!.docs[index];
                return ListTile(
                  title: Text(data['name']),
                );
              },
            );
          } else if (snapshot.hasError) {
            log(snapshot.error.toString());
          }
        }
        return Container();
      },
    );
    // final results = data.where((item) => item.contains(query)).toList();

    // return ListView.builder(
    //   itemCount: results.length,
    //   itemBuilder: (context, index) {
    //     return ListTile(
    //       title: Text(results[index]),
    //       onTap: () {
    //         close(context, results[index]);
    //       },
    //     );
    //   },
    // );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
    // final suggestionList = query.isEmpty
    //     ? data
    //     : data.where((item) => item.contains(query)).toList();

    // return ListView.builder(
    //   itemCount: suggestionList.length,
    //   itemBuilder: (context, index) {
    //     return ListTile(
    //       title: Text(suggestionList[index]),
    //       onTap: () {
    //         query = suggestionList[index];
    //         showResults(context);
    //       },
    //     );
    //   },
    // );
  }

  @override
  String get searchFieldLabel => 'Search';

  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      textTheme: TextTheme(
        headline6: TextStyle(
          color: Colors.black,
          fontSize: 18.0,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
          color: Colors.black,
          fontSize: 18.0,
        ),
      ),
    );
  }
}
