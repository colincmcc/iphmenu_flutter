import 'package:flutter/material.dart';
import 'package:iphmenu/features/common/AppBars.dart';
import 'package:iphmenu/Theme.dart' as Theme;
import 'package:iphmenu/modal/MenuModal.dart';
import 'package:flutter/foundation.dart';
import 'package:iphmenu/features/liquor/LiquorListPage.dart';

const double _kFlexibleSpaceMaxHeight = 256.0;
const String _kSmallLogoImage = 'assets/img/lightbulb_solo.png';
const double _kAppBarHeight = 128.0;
const double _kFabHalfSize = 28.0; // TODO(mpcomplete): needs to adapt to screen size
const double _kLiquorPageMaxWidth = 500.0;

class HomePageLiquor extends StatefulWidget {
  const HomePageLiquor({Key key}): super(key: key);

  @override
  HomePageLiquorState createState() => new HomePageLiquorState();

}

class HomePageLiquorState extends State<HomePageLiquor>{
  static final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  List<Widget> _menuListItems() {
    final List<Widget> listItems = <Widget>[];
    for (LiquorType liquorType in kAllLiquorTypeItems) {
      listItems.add(liquorType);
    }
    return listItems;
  }

  Widget build(BuildContext context) {
    Widget home = new Scaffold(
      key: _scaffoldKey,
      body: new CustomScrollView(
        slivers: <Widget>[
          new AnimatedAppBar(context, "IPH Executive"),
          new HomePageItem()
        ]
      ),
    );

    return home;
  }

  Widget _buildBody(){
    return new SliverList(
        delegate: new SliverChildListDelegate(
            _menuListItems()
        )
    );

  }
}
_getHomeContent(){

  return new Expanded(
    child: new Container(
      decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [
                Theme.Colors.appBarGradientStart,
                Theme.Colors.appBarGradientEnd,
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(0.0, 1.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp)),
      child: new CustomScrollView(
        scrollDirection: Axis.vertical,
        shrinkWrap: false,
        slivers: <Widget>[
          new SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            sliver: new SliverList(
              delegate: new SliverChildBuilderDelegate(
                    (context, index) => new HomePageItem(kAllLiquorTypeItems[index]),
                childCount: kAllLiquorTypeItems.length,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class HomePageItem extends StatelessWidget {
  final LiquorType liquorType;
  final bool horizontal;

  HomePageItem(this.liquorType);



  @override
  Widget build(BuildContext context) {

    final homeThumbnail = new Container(
      margin: new EdgeInsets.symmetric(
          vertical: 16.0
      ),
      alignment: horizontal ? FractionalOffset.centerLeft : FractionalOffset.center,
      child: new Hero(
        tag: "liquor-hero-${liquorType.title}",
        child: new Image.network(
          liquorType.imgLink,
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
              new Text(value, style: Theme.TextStyles.appBarTitle),
            ]
        ),
      );
    }


    final homeCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(horizontal ? 76.0 : 16.0, horizontal ? 16.0 : 42.0, 16.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment: horizontal ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: <Widget>[
          new Container(height: 4.0),
          new Text(liquorType.title, style: Theme.TextStyles.liquorTitle),
        ],
      ),
    );


    final homeContent = new Container(
      child: homeCardContent,
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
            pageBuilder: (_, __, ___) => new LiquorListBody(liquorType.title),
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
              homeContent
            ],
          ),
        )
    );
  }


}

/*
class HomePageBody extends StatefulWidget{
  @override
  _HomePageBodyState createState() => new _HomePageBodyState();

}

class _HomePageBodyState extends State<HomePageBody> {

  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        child: new MenuList(_buildMenuList()),
      ),
    );
  }
}
*/