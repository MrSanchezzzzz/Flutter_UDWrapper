import 'dart:convert';

import 'package:http/http.dart';
import 'package:urban_dictionary_wrapper/term.dart';
import 'package:http/http.dart' as http;

class Requests {
  static Future<List<Term>> getTermsByString(String value) async {
    List<Term> terms = <Term>[];
    Response response = await http.get(
        Uri.parse(
            'https://mashape-community-urban-dictionary.p.rapidapi.com/define?term=' +
                value),
        headers: {
          'No headers! Ha-ha'
        });
    Map<String, dynamic> body = jsonDecode(response.body) as Map<String, dynamic>;
    List<dynamic> list = body['list'] as List<dynamic>;
    for (var element in list) {
      terms.add(Term.fromJson(element));
    }
    return terms;
  }

  static Future<Term> getRandomTerm() async{
    Response response = await http.get(Uri.parse("https://unofficialurbandictionaryapi.com/api/random?strict=false&matchCase=false&limit=1&page=1&multiPage=false&"));
    Map<String,dynamic> data= (jsonDecode(response.body) as Map<String,dynamic>)['data'][0];
    Term t = Term.fromJson(data);
    return t;
  }

  static Future<List<Term>> getRandomTerms({required int count}) async{
    Response response = await http.get(Uri.parse("https://unofficialurbandictionaryapi.com/api/random?strict=false&matchCase=false&limit=$count&page=1&multiPage=false&"));
    List<dynamic> data= (jsonDecode(response.body) as Map<String,dynamic>)['data'];
    List<Term> terms=<Term>[];
    for(var d in data){
      terms.add(Term.fromJson(d));
    }
    return terms;
  }
}
