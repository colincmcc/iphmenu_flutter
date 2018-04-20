import 'dart:async';
import 'dart:convert'
;
import 'package:flutter/material.dart';

import 'package:fluro/fluro.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:iphmenu/features/liquor/LiquorListPage.dart';
import 'package:iphmenu/modal/LiquorItem.dart';
import 'package:iphmenu/Theme.dart' as Theme;
import 'package:iphmenu/features/common/objects.dart';
import 'package:iphmenu/features/liquorDetail/LiquorDetailBody.dart';
import 'package:iphmenu/routes/application.dart';
/*
class LiquorCard extends StatefulWidget{
  final LiquorItem liquoritem;
  final bool horizontal;
  final bool isAdmin;

  LiquorCard(this.liquoritem, {this.horizontal = true, this.isAdmin = true});

  LiquorCard.vertical(this.liquoritem): horizontal = false;

  LiquorCard.admin(this.liquoritem): isAdmin = false;

  LiquorCardState createState() => new LiquorCardState();

}

class LiquorCardState extends State<LiquorCard>{
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<String> _liquorList;

  _updateLiquorList() async {
    final SharedPreferences prefs = await _prefs;
    final String liquorList = json.encode(liquoritems);

    setState(() {
      _liquorList = prefs.setString("masterLiquorList", liquorList).then((bool success) {
        return liquorList;
      });
    });
  }

  DismissDirection _dismissDirection = DismissDirection.horizontal;


/*
  void dismissCard(LiquorItem liquoritem) async {
    final SharedPreferences prefs = await _prefs;

    setState(() {
        liquoritems.remove(liquoritem);
        LiquorListState.storedLiquorByType
        final String liquorList = json.encode(liquoritems);
        _liquorList = prefs.setString("masterLiquorList", liquorList).then((bool success) {
          return liquorList;
        });
      });

  }
*/

  @override
  void initState() {
    super.initState();
    _liquorList = _prefs.then((SharedPreferences prefs) {
      return (prefs.getString('masterLiquorList'));
    });
  }

  @override
  Widget build(BuildContext context) {
    // Use the index of the item to create a unique id for the Hero image
    // in case there are duplicate items
    // Todo make sure all items have unique id, switch to Set()

    int currentIndex = liquoritems.indexOf(widget.liquoritem);

    final liquorThumbnail = new Container(
      margin: new EdgeInsets.symmetric(
          vertical: widget.horizontal ? 16.0 : 71.0
      ),
      alignment: widget.horizontal ? FractionalOffset.centerLeft : FractionalOffset.center,
      child: new Hero(
        tag: "liquor-hero-${widget.liquoritem.id}-${currentIndex}",
        child: new Image.network(
          widget.liquoritem.imglink,
          height: 92.0,
          width: 92.0,
        ),
      ),
    );



    Widget _liquorValue({String value, String image}) {
      return new Container(
        child: new Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Image.asset(image, height: 12.0),
              new Container(width: 8.0),
              new Text(value, style: Theme.TextStyles.liquorType),
            ]
        ),
      );
    }


    final liquorCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(widget.horizontal ? 76.0 : 16.0, widget.horizontal ? 16.0 : 42.0, 16.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment: widget.horizontal ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: <Widget>[
          new Container(height: 4.0,),
          new Text(widget.liquoritem.name, style: Theme.TextStyles.liquorTitle),
          new Container(height: 10.0),
          new Text(widget.liquoritem.type, style: Theme.TextStyles.liquorType),
          new Separator(),
          new Row(
            mainAxisAlignment: widget.horizontal ? MainAxisAlignment.start : MainAxisAlignment.center,
            children: <Widget>[
              new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _liquorValue(
                      value: widget.liquoritem.proof,
                      image: 'assets/img/liquor_ic.png'),
                  _liquorValue(
                      value: widget.liquoritem.age,
                      image: 'assets/img/liquor_ic.png')
                ],
              ),
              new Container(width:5.0),
              new Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  new Text(widget.liquoritem.price, style: Theme.TextStyles.liquorTitle)
                ],
              ),
            ],
          ),
        ],
      ),
    );


    final liquorCard = new Container(
          child: liquorCardContent,
          height: widget.horizontal ? 175.0 : 200.0,
          margin: widget.horizontal
              ? new EdgeInsets.only(left: 46.0)
              : new EdgeInsets.only(top: 125.0),
          decoration: new BoxDecoration(
            color: Theme.Colors.liquorCard,
            shape: BoxShape.rectangle,
            borderRadius: new BorderRadius.circular(8.0),
            boxShadow: <BoxShadow>[
              new BoxShadow(
                color: Colors.black12,
                blurRadius: 10.0,
                offset: new Offset(0.0, 10.0),
              ),
            ],
          ),

    );




    return new Dismissible(
        key: new ObjectKey(currentIndex),
    direction: _dismissDirection,
    onDismissed: (DismissDirection direction) { dismissCard(widget.liquoritem); },
    child: new GestureDetector(
        onTap: widget.horizontal
            ? () => Navigator.of(context).push(
          new PageRouteBuilder(
            pageBuilder: (_, __, ___) => new LiquorDetailBody(widget.liquoritem),
            transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            new FadeTransition(opacity: animation, child: child),
          ) ,
        )
            : null,
        child: new Container(
          margin: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 24.0,
          ),
          child: new Stack(
            children: <Widget>[
              liquorCard,
              liquorThumbnail,
            ],
          ),
        )
      )
    );
  }
}
*/
class LiquorSummary extends StatelessWidget {

  final LiquorItem liquoritem;
  final bool horizontal;
  final bool isAdmin;

  LiquorSummary(this.liquoritem, {this.horizontal = true, this.isAdmin = true});

  LiquorSummary.vertical(this.liquoritem): horizontal = false;

  LiquorSummary.admin(this.liquoritem): isAdmin = false;



  @override
  Widget build(BuildContext context) {


    // Use the index of the item to create a unique id for the Hero image
    // in case there are duplicate items
    // Todo make sure all items have unique id, switch to Set()
    

    final liquorThumbnail = new Container(
      margin: new EdgeInsets.symmetric(
          vertical: horizontal ? 16.0 : 71.0
      ),
      alignment: horizontal ? FractionalOffset.centerLeft : FractionalOffset.center,
      child: new Hero(
        tag: "liquor-hero-${liquoritem.id}",
        child: new Image.network(
          liquoritem.imglink,
          height: 92.0,
          width: 92.0,
        ),
      ),
    );



    Widget _liquorValue({String value, String image}) {
      return new Container(
        child: new Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Image.asset(image, height: 12.0),
              new Container(width: 8.0),
              new Text(value, style: Theme.TextStyles.liquorType),
            ]
        ),
      );
    }


    final liquorCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(horizontal ? 76.0 : 16.0, horizontal ? 16.0 : 42.0, 16.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment: horizontal ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: <Widget>[
            new Container(height: 4.0,),
            new Text(liquoritem.name, style: Theme.TextStyles.liquorTitle),
            new Container(height: 10.0),
            new Text(liquoritem.type, style: Theme.TextStyles.liquorType),
            new Separator(),
            new Row(
              mainAxisAlignment: horizontal ? MainAxisAlignment.start : MainAxisAlignment.center,
              children: <Widget>[
                new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _liquorValue(
                        value: liquoritem.proof,
                        image: 'assets/img/liquor_ic.png'),
                    _liquorValue(
                        value: liquoritem.age,
                        image: 'assets/img/liquor_ic.png')
                  ],
                ),
                new Container(width:5.0),
                new Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    new Text(liquoritem.price, style: Theme.TextStyles.liquorTitle)
                  ],
                ),
              ],
            ),

        ],
      ),
    );


    final liquorCard = new Container(
          child: liquorCardContent,
          height: horizontal ? 175.0 : 200.0,
          margin: horizontal
              ? new EdgeInsets.only(left: 46.0)
              : new EdgeInsets.only(top: 125.0),
          decoration: new BoxDecoration(
            color: Theme.Colors.liquorCard,
            shape: BoxShape.rectangle,
            borderRadius: new BorderRadius.circular(8.0),
            boxShadow: <BoxShadow>[
              new BoxShadow(
                color: Colors.black12,
                blurRadius: 10.0,
                offset: new Offset(0.0, 10.0),
              ),
            ],
          ),

    );




    return new GestureDetector(
        onTap:  null,
        child: new Container(
          margin: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 24.0,
          ),
          child: new Stack(
            children: <Widget>[
              liquorCard,
              liquorThumbnail,
            ],
          ),
        )
    );
  }
}