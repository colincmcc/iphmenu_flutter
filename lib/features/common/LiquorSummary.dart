import 'package:flutter/material.dart';
import 'package:iphmenu/models/LiquorItem.dart';
import 'package:iphmenu/Theme.dart' as Theme;
import 'package:iphmenu/features/common/objects.dart';
import 'package:iphmenu/features/detail/LiquorDetailBody.dart';

class LiquorSummary extends StatelessWidget {

  final LiquorItem liquoritem;
  final bool horizontal;

  LiquorSummary(this.liquoritem, {this.horizontal = true});

  LiquorSummary.vertical(this.liquoritem): horizontal = false;


  @override
  Widget build(BuildContext context) {

    final liquorThumbnail = new Container(
      margin: new EdgeInsets.symmetric(
          vertical: 16.0
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
            new Container(height: 4.0),
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
                new Container(width:50.0),
                new Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    new Text(liquoritem.price, style: Theme.TextStyles.liquorTitle)
                  ],
                ),
              ],
            ),
            /*
            new Expanded(
                flex: horizontal ? 1 : 0,
                child: _liquorValue(
                    value: liquoritem.proof,
                    image: 'assets/img/liquor_ic.png')

            ),
            new Container (
              width: 32.0,
            ),
            new Expanded(
                flex: horizontal ? 1 : 0,
                child: _liquorValue(
                    value: liquoritem.age,
                    image: 'assets/img/liquor_ic.png')
            ),
              */
            /*
            new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Expanded(
                      flex: horizontal ? 1 : 0,
                      child: _liquorValue(
                          value: liquoritem.proof,
                          image: 'assets/img/liquor_ic.png')

                  ),
                  new Container (
                    width: 32.0,
                  ),
                  new Expanded(
                      flex: horizontal ? 1 : 0,
                      child: _liquorValue(
                          value: liquoritem.age,
                          image: 'assets/img/liquor_ic.png')
                  )
                ],
            ), */
        ],
      ),
    );


    final liquorCard = new Container(
      child: liquorCardContent,
      height: horizontal ? 175.0 : 200.0,
      margin: horizontal
          ? new EdgeInsets.only(left: 46.0)
          : new EdgeInsets.only(top: 72.0),
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
        onTap: horizontal
            ? () => Navigator.of(context).push(
          new PageRouteBuilder(
            pageBuilder: (_, __, ___) => new LiquorDetailBody(liquoritem),
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
    );
  }
}