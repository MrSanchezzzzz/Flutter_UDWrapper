import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:urban_dictionary_wrapper/Widgets/term_details_page.dart';
import 'package:urban_dictionary_wrapper/requests.dart';

import '../cache_manager.dart';
import '../term.dart';
import 'favorites_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
    this.onThemeChanged
  }) : super(key: key);

  //true for dark mode
  final Function(bool)? onThemeChanged;
  @override
  Widget build(BuildContext context) {
    var brightness = Theme.of(context).brightness;
    bool isDarkmode=brightness==Brightness.dark;

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.65,
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.only(left: 16,top: 60,right: 16,bottom: 24),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,

              ),
              child: Text('Urban Dictionary',
                  style: Theme.of(context).textTheme.caption
              ),
            ),
            Expanded(
              child: Column(
                //mainAxisSize: MainAxisSize.max,
                children: [
                  ListTile(
                    leading: ImageIcon(AssetImage("assets/images/shuffle.png"),color: Theme.of(context).indicatorColor,),
                    title: const Text('Random term',),
                    onTap: () async {
                      Term term= await Requests.getRandomTerm();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => TermDetailsPage(term: term)));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.bookmark,color: Theme.of(context).indicatorColor),
                    title: const Text('Saved'),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>FavoritesPage()));
                    },
                  ),
                  Spacer(),
                  ListTile(
                    leading: Icon(
                        isDarkmode?Icons.light_mode:Icons.dark_mode,
                        color: Theme.of(context).indicatorColor),
                    title: Text(
                        isDarkmode?'Light mode':'Dark mode'
                    ),
                    onTap: () {
                      if(onThemeChanged!=null) {
                        onThemeChanged!(!isDarkmode);
                      }
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.exit_to_app,color: Theme.of(context).indicatorColor),
                    title: const Text('Exit'),
                    onTap: () {
                      SystemNavigator.pop(animated: true);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}