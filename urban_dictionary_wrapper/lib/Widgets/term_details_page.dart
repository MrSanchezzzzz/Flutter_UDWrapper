import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:urban_dictionary_wrapper/Widgets/alert_dialog.dart';
import 'package:urban_dictionary_wrapper/Widgets/linked_rich_text.dart';
import 'package:urban_dictionary_wrapper/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

import '../cache_manager.dart';
import '../term.dart';

class TermDetailsPage extends StatefulWidget {
  const TermDetailsPage({Key? key, this.term}) : super(key: key);

  @override
  State<TermDetailsPage> createState() => TermDetailsPageState();
  final Term? term;
}

class TermDetailsPageState extends State<TermDetailsPage> {
  bool isFavorite=false;

  @override void initState(){
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      checkIfFavorite();
      setState(() {

      });
    });
  }
  Future<void> checkIfFavorite() async {
    isFavorite=await Cache.isFavorite(term: widget.term!);
  }
  @override
  Widget build(BuildContext context) {
    //checkIfFavorite();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Term details"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
                onPressed: (){
                  if(widget.term==null) {
                    return;
                  }
                  if(isFavorite){
                    Cache.removeFromFavorites(term: widget.term!);
                    setState(() {
                      isFavorite=false;
                    });
                  }
                  else{
                    Cache.addToFavorites(term: widget.term!);
                    setState(() {
                      isFavorite=true;
                    });
                  }

                },
                icon: Icon(isFavorite?Icons.favorite:Icons.favorite_border),
            color: Theme.of(context).indicatorColor,
            ),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
        constraints:
            BoxConstraints(minHeight: MediaQuery.of(context).size.height),
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                InkWell(
                  child: Text(
                    widget.term?.word ?? "",
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(decoration: TextDecoration.underline),
                  ),
                  onTap: () {
                    if(widget.term?.permalink==null||widget.term?.permalink=='') {
                      MyAlert.text(context: context,title: "Error",text: "Could not open link");
                      return;
                    }
                    launchUrlFromString(widget.term!.permalink);
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                LinkedRichText(text: widget.term?.definition??""),
                SizedBox(height: 64,),
                LinkedRichText(text: widget.term?.example??""),
                SizedBox(height: 64,),
                Row(
                  children: [
                    Text(
                      "by ",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(
                      widget.term?.author ?? "Author",
                      style: Theme.of(context).textTheme.bodyText1,
                      overflow: TextOverflow.clip,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
