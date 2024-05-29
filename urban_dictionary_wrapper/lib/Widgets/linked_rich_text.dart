import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:urban_dictionary_wrapper/Widgets/alert_dialog.dart';

import '../requests.dart';
import '../term.dart';

class LinkedRichText extends StatelessWidget {
  final String text;

  const LinkedRichText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TextSpan> textSpans = [];
    RegExp regExp = RegExp(r'\[([^\]]+)\]');
    Iterable<Match> matches = regExp.allMatches(text);

    int currentPosition = 0;
    for (Match match in matches) {
      if (match.start > currentPosition) {
        textSpans.add(TextSpan(
          text: text.substring(currentPosition, match.start),
          style: Theme.of(context).textTheme.bodyText1,
        ));
      }
      String matchText = match.group(1)!;
      textSpans.add(TextSpan(
        text: matchText,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
          color: Colors.blueAccent,
        ),
        recognizer: TapGestureRecognizer()
          ..onTap = () async {
          List<Term> terms=await Requests.getTermsByString(matchText);
          showDialog(context: context, builder: (BuildContext context)=>
             MyAlert.termsList(terms));
          }
      ));
      currentPosition = match.end;
    }
    if (currentPosition < text.length) {
      textSpans.add(TextSpan(
        text: text.substring(currentPosition),
        style: Theme.of(context).textTheme.bodyText1,
      ));
    }

    return RichText(
      text: TextSpan(
        children: textSpans,
        style: const TextStyle(
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}