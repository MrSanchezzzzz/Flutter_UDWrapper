import 'package:flutter/material.dart';
import 'package:urban_dictionary_wrapper/Widgets/separator.dart';
import 'package:urban_dictionary_wrapper/Widgets/term_list_item.dart';

import '../cache_manager.dart';
import '../term.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState()=>FavoritesPageState();
}
class FavoritesPageState extends State<FavoritesPage>{
  List<Term> terms=<Term>[];

  void getTerms() async{
    terms=await Cache.getFavorites();
  }

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      setState(() {
        getTerms();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: TextButton(
                onPressed: (){Cache.clearAll();},
                child: Text("Clear")),
          )
        ],
      ),
      body: ListView.separated(
        itemCount: terms.length,
        itemBuilder: (BuildContext context, int index) {
          return TermListItem(term: terms[index]);
        },
        separatorBuilder: (BuildContext context, int index) {
          return MySeparator();
        },
      ),
    );
  }

}