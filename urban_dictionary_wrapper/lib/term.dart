import 'dart:math';

import 'package:intl/intl.dart';
import 'package:urban_dictionary_wrapper/utils.dart';

class Term {
  final String definition;
  final String permalink;
  final int thumbsUp;
  final String author;
  final String word;
  final int defid;
  final String currentVote;
  final DateTime writtenOn;
  final String example;
  final int thumbsDown;

  Term({
    required this.definition,
    required this.permalink,
    required this.thumbsUp,
    required this.author,
    required this.word,
    required this.defid,
    required this.currentVote,
    required this.writtenOn,
    required this.example,
    required this.thumbsDown,
  });

  factory Term.fromJson(Map<String, dynamic> json) {
    DateTime date;
    if(json['written_on']!=null){
      date=DateTime.parse(json['date']??DateTime.now().toString());
    }
    else if(json['date']!=null){
      DateFormat df=DateFormat("MMMM d, yyyy");
      date=df.parse(json['date']??DateTime.now().toString());
    }
    else{
      date=DateTime.now();
    }

    Random rnd=Random();
    const int maxInt = 2147483646;
    int defid=json['defid']??-1;
    if(defid==-1){
      defid=generateRandomNumber(1, maxInt);
    }

    return Term(
      definition: json['definition']??json['meaning']??'',
      permalink: json['permalink']??'',
      thumbsUp: json['thumbs_up']??0,
      author: json['author']??json['contributor']??'',
      word: json['word']??'',
      defid: defid,
      currentVote: json['current_vote']??'',
      writtenOn: date,
      example: json['example']??'',
      thumbsDown: json['thumbs_down']??0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'definition': definition,
      'permalink': permalink,
      'thumbs_up': thumbsUp,
      'author': author,
      'word': word,
      'defid': defid,
      'current_vote': currentVote,
      'written_on': writtenOn.toIso8601String(),
      'example': example,
      'thumbs_down': thumbsDown,
    };
  }
  static String formatDefinition(String definition)=>
      definition.replaceAll('[', '').replaceAll(']', '');
}
