import 'package:flutter/material.dart';
import 'package:urban_dictionary_wrapper/Widgets/term_details_page.dart';

import '../term.dart';
import '../utils.dart';

class TermListItem extends StatelessWidget {
  const TermListItem({
    Key? key,
    this.term
  }) : super(key: key);
  final Term? term;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if(term == null){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Could not open")));
          //TODO create message box for errors
        }
        else {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => TermDetailsPage(term: term,)));
        }
      },
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(6)),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              term?.word??"Null",
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(height: 8),
            Text(
              Term.formatDefinition(term?.definition??"Null") ,
              style: Theme.of(context).textTheme.bodyText1,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            )
          ],
        ),
      ),
    );
  }
}
