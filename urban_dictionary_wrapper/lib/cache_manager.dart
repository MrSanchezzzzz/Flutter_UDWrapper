import 'dart:convert';
import 'package:urban_dictionary_wrapper/term.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cache{
  static Future<void> addToFavorites({required Term term}) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites=prefs.getStringList('favorites')??<String>[];
    favorites.add(jsonEncode(term.toJson()));
    prefs.setStringList('favorites', favorites);
  }

  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('favorites');
  }

  static void removeFromFavorites({required Term term}) async{
    final prefs = await SharedPreferences.getInstance();
    List<Term> terms=await getFavorites();
    List<String> lines=<String>[];
    for(Term t in terms) {
      if (term.defid == t.defid) {
        terms.remove(term);
        continue;
      }
      lines.add(jsonEncode(t.toJson()));
    }
    prefs.setStringList('favorites', lines);
  }

  static Future<List<Term>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites=prefs.getStringList('favorites')??<String>[];
    List<Term> terms=<Term>[];
    for(String str in favorites){
      terms.add(Term.fromJson(jsonDecode(str)));
    }
    return terms;
  }

  static Future<bool> isFavorite({required Term term}) async {
    List<Term> terms = await getFavorites();
    for(Term t in terms){
      if(term.defid==t.defid){
        return true;
      }
    }
    return false;
  }
}