import 'dart:async';

import 'package:flutter/material.dart';
import 'package:urban_dictionary_wrapper/Widgets/separator.dart';
import 'package:urban_dictionary_wrapper/Widgets/top_bar.dart';
import 'package:urban_dictionary_wrapper/requests.dart';
import 'package:urban_dictionary_wrapper/term.dart';
import 'package:urban_dictionary_wrapper/themes.dart';
import 'Widgets/drawer.dart';
import 'Widgets/term_details_page.dart';
import 'Widgets/term_list_item.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ValueNotifier<ThemeMode> _notifier = ValueNotifier(ThemeMode.dark);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: _notifier,
      builder: (_,mode,__){
        return MaterialApp(
          title: 'UD Wrapper',
          theme: Themes.lightTheme,
          themeMode: mode,
          darkTheme: Themes.darkTheme,
          home: MyHomePage(title: 'Flutter Demo Home Page',themeNotifier: _notifier,),
        );
      }
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title,this.themeNotifier}) : super(key: key);
  final String title;
  final ValueNotifier<ThemeMode>? themeNotifier;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _searchShown = false;
  bool loading=false;
  List<Term> terms=List.empty(growable: true);

  void onThemeChanged(bool isDarkmode){
    if(widget.themeNotifier!=null) {
      print(isDarkmode);
      widget.themeNotifier!.value =
      isDarkmode ? ThemeMode.dark : ThemeMode.light;
      setState(() {

      });
    }
  }

  Timer? _debounce;
  void handleSearch(String value) {
    if(value.isEmpty) {
      loading=false;
      return;
    }

    setState(() {
      terms.clear();
      loading=true;
    });
    if(_debounce?.isActive??false){
      _debounce?.cancel();
    }
    _debounce=Timer(const Duration(milliseconds: 500),() async {
      terms=await Requests.getTermsByString(value);
      setState(() {
        loading=false;
      });
    });
  }

  @override void initState(){
    super.initState();
    loading=true;
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      terms=await Requests.getRandomTerms(count: 10);
      setState(() {
        loading=false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        setState(() {
          _searchShown = false;
        });
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            TopBar(
              searchShown: _searchShown,
              onSearchButtonPressed: (value) {
                setState(() {
                  _searchShown = value;
                });
              },
              onSearch: handleSearch,
            )
          ],
        ),
        drawer: MyDrawer(onThemeChanged: onThemeChanged,),
        body:
        terms.isNotEmpty?
        RefreshIndicator(
          onRefresh: () async{
            terms=await Requests.getRandomTerms(count: 10);
            setState(() {

            });
          },
          color: Theme.of(context).indicatorColor,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: ListView.separated(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemBuilder: (BuildContext context, int index) {
                return TermListItem(term:terms[index]);
              },
              itemCount: terms.length,
              separatorBuilder: (BuildContext context, int index) {
                return MySeparator();
              },

            ),
          ),
        ):
            Center(
              child:loading?
              CircularProgressIndicator(
                color:Theme.of(context).indicatorColor,

              ):
              Text("No terms found",
                style: Theme.of(context).textTheme.bodyText2)
            )
      ),
    );
  }
}


