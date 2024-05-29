import 'package:flutter/material.dart';
import 'package:urban_dictionary_wrapper/Widgets/term_list_item.dart';

import '../term.dart';

class MyAlert extends StatelessWidget {
  const MyAlert({Key? key, this.child,this.height}) : super(key: key);

  final double? height;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: Theme
          .of(context)
          .backgroundColor,
      child: Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery
                .of(context)
                .size
                .height * 0.25,
            maxHeight: MediaQuery
                .of(context)
                .size
                .height * 0.5,
          ),
          width: MediaQuery
              .of(context)
              .size
              .height * 0.8,
          height: height,
          child: this.child
      ),

    );
  }

  factory MyAlert.text({required BuildContext context,String title="",String text=""}){
    return MyAlert(
      height: MediaQuery
          .of(context)
          .size
          .height * 0.3,
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,

              children: [
                Text(title,
                style: Theme.of(context).textTheme.headline4,
                  textAlign: TextAlign.center,
                ),
                Text(text,
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          Spacer(),
          InkWell(
            onTap: (){
              Navigator.of(context).pop();
            },
            child: Container(
              padding: EdgeInsets.only(bottom: 8,top: 8),
              decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24)
                  )
              ),
              child: Text(
                  "OK",
                style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      )
    );
  }

  factory MyAlert.termsList(List<Term> terms){
    return MyAlert(child:
    ListView.builder(
      itemCount: terms.length,
      itemBuilder: (BuildContext context, int index) {
        return TermListItem(term: terms[index],);
      },
    )
    );
  }
}
