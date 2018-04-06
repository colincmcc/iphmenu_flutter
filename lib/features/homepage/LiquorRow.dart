import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:iphmenu/models/LiquorItem.dart';
import 'package:iphmenu/Theme.dart' as Theme;
import 'package:iphmenu/Routes.dart';

class LiquorRow extends StatelessWidget {

  final LiquorItem liquoritem;
  final bool horizontal;

  LiquorRow(this.liquoritem, {this.horizontal = true});
  LiquorRow.vertical(this.liquoritem): horizontal = false;

  @override
  Widget build(BuildContext context) {
    final liquorThumbnail = new Container(
      alignment: new FractionalOffset(0.0, 0.5),
      margin: const EdgeInsets.only(left: 24.0),
      child: new Hero(
        tag: 'liquor-icon-${liquoritem.id}',
        child: new Image.network(
         liquoritem.imglink,
          height: Theme.Dimens.liquorHeight,
          width: Theme.Dimens.liquorWidth,
        ),
      ),
    );

    final liquorCard = new Container(
      margin: const EdgeInsets.only(left: 72.0, right: 24.0),
      decoration: new BoxDecoration(
        color: Theme.Colors.liquorCard,
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(color: Colors.black,
              blurRadius: 10.0,
              offset: new Offset(0.0, 10.0))
        ],
      ),

        child: new Container(
        margin: const EdgeInsets.only(top: 16.0, left: 72.0),
        constraints: new BoxConstraints.expand(),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(liquoritem.name, style: Theme.TextStyles.liquorTitle),
            new Text(liquoritem.type, style: Theme.TextStyles.liquorType),
            new Container(
                color: Theme.Colors.accentcolor,
                width: 24.0,
                height: 1.0,
                margin: const EdgeInsets.symmetric(vertical: 8.0)
            ),
            new Row (
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
            new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            new Row(
              children:[
                new Row (
                children: <Widget>[
                new Icon(Icons.arrow_right, size: 14.0,
                    color: Theme.Colors.liquorPrice),
                new Text(
                    liquoritem.proof, style: Theme.TextStyles.liquorType),
                new Container(width: 6.0),
                ],
                ),
            ],
            ),
            new Row(
              children:[
                new Icon(Icons.arrow_right, size: 14.0,
                    color: Theme.Colors.liquorPrice),
                new Text(
                    liquoritem.age, style: Theme.TextStyles.liquorType),
                new Container(width: 6.0),
              ],
                ),
                ],
            ),
                new Column (
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    new Text(
                        liquoritem.price, style: Theme.TextStyles.liquorTitle),
                  ],
                ),
    ],
    ),
            ],
            ),
      )
    );

    return new Container(
      height: 120.0,
      margin: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: new FlatButton(
        onPressed: () => _navigateTo(context, liquoritem.id),

        child: new Stack(
          children: <Widget>[
            liquorCard,
            liquorThumbnail,
          ],
        ),
      ),
    );
  }

  _navigateTo(context, String id) {
    Routes.navigateTo(
        context,
        '/detail/${liquoritem.id}',
        transition: TransitionType.fadeIn
    );
  }
}