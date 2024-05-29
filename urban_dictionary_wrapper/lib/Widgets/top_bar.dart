import 'dart:ui';
import 'package:flutter/material.dart';

class TopBar extends StatefulWidget {
  const TopBar({Key? key, this.searchShown = false, this.onSearchButtonPressed,this.onSearch})
      : super(key: key);

  @override
  _TopBarState createState() => _TopBarState();

  final bool searchShown;
  final Function(bool)? onSearchButtonPressed;
  final Function(String)? onSearch;
}

class _TopBarState extends State<TopBar> {
  final FocusNode _focusNode = FocusNode();
  final _searchController = TextEditingController();
  String searchValue = "";

  @override
  Widget build(BuildContext context) {
    _searchController.text = searchValue;
    _searchController.selection = TextSelection.fromPosition(
        TextPosition(offset: _searchController.text.length));
    return Expanded(
        child: Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
            child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                        icon: const Icon(Icons.menu)),
                    Expanded(
                      child: widget.searchShown
                          ? TextField(
                              decoration: InputDecoration(
                                  hintText: "Enter your term",
                                  counterText: "",
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _focusNode.unfocus();
                                          searchValue = "";
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.clear,
                                        color: Color.fromARGB(255, 239, 255, 0),
                                      ))),
                              maxLength: 35,
                              maxLines: 1,
                              textAlignVertical: TextAlignVertical.center,
                              focusNode: _focusNode,
                              controller: _searchController,
                              onChanged: (value) {
                                setState(() {
                                  searchValue = value;
                                  widget.onSearch!(value);
                                });
                              },
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Urban Dictionary",style: Theme.of(context).appBarTheme.titleTextStyle,),
                                IconButton(
                                    icon: const Icon(Icons.search),
                                    tooltip: "Search...",
                                    onPressed: () {
                                      setState(() {
                                        widget.onSearchButtonPressed!(true);
                                        if (!_focusNode.hasFocus) {
                                          _focusNode.requestFocus();
                                        }
                                      });
                                    })
                              ],
                            ),
                    ),
                  ],
                )))
      ],
    ));
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}
