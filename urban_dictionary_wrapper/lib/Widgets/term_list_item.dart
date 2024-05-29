import 'package:flutter/material.dart';
import 'package:urban_dictionary_wrapper/Widgets/term_details_page.dart';

import '../cache_manager.dart';
import '../term.dart';
import '../utils.dart';

class TermListItem extends StatefulWidget {
  const TermListItem({Key? key, this.term, this.onFavoriteChanged})
      : super(key: key);
  final Term? term;
  final Function(bool)? onFavoriteChanged;

  @override
  State<TermListItem> createState() => _TermListItemState();
}

class _TermListItemState extends State<TermListItem> {
  bool isFavorite = false;

  Future<void> checkIfFavorite() async {
    isFavorite = await Cache.isFavorite(term: widget.term!);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      checkIfFavorite();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.term == null) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Could not open")));
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TermDetailsPage(
                        term: widget.term,
                      ))).then((value) => {
                setState(() {
                  bool tmp = isFavorite;
                  checkIfFavorite();
                  if (tmp != isFavorite) {
                    if (widget.onFavoriteChanged != null) {
                      widget.onFavoriteChanged!(isFavorite);
                    }
                  }
                })
              });
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(6)),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    widget.term?.word ?? "Null",
                    style: Theme.of(context).textTheme.headline4,
                    maxLines: 3,
                    overflow: TextOverflow.clip,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (widget.term == null) {
                      return;
                    }
                    if (isFavorite) {
                      Cache.removeFromFavorites(term: widget.term!);
                      setState(() {
                        isFavorite = false;
                      });
                    } else {
                      Cache.addToFavorites(term: widget.term!);
                      setState(() {
                        isFavorite = true;
                      });
                    }
                  },
                  icon:
                      Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                  color: Theme.of(context).indicatorColor,
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              Term.formatDefinition(widget.term?.definition ?? "Null"),
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
