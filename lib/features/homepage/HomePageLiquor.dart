import 'package:flutter/material.dart';
import 'package:iphmenu/features/homepage/LiquorListPage.dart';
import 'package:iphmenu/features/common/gradientappbar.dart';
import 'package:iphmenu/Theme.dart' as Theme;
import 'package:iphmenu/features/homepage/MenuList.dart';
import 'package:iphmenu/modal/MenuModal.dart';
import 'package:flutter/foundation.dart';
import 'package:iphmenu/modal/LiquorItem.dart';


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
    String category;
    for (LiquorType liquorType in kAllLiquorTypeItems) {
      if (category != liquorType.category) {
        if (category != null)
          listItems.add(const Divider());
        listItems.add(
            new MergeSemantics(
              child: new Container(
                height: 48.0,
                padding: const EdgeInsetsDirectional.only(start: 16.0),
                alignment: AlignmentDirectional.centerStart,
                child: new SafeArea(
                  top: false,
                  bottom: false,
                  child: new Semantics(
                    header: true,
                    child: new Text(liquorType.title, style: Theme.TextStyles.liquorType),
                  ),
                ),
              ),
            )
        );
        category = liquorType.category;
      }
      listItems.add(liquorType);
    }
    return listItems;
  }

  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    Widget home = new Scaffold(
      key: _scaffoldKey,
      body: new CustomScrollView(
        slivers: <Widget>[
          _buildAppBar(context, statusBarHeight),
          new SliverList(delegate: new SliverChildListDelegate(_menuListItems())),
        ]
      ),
    );

    return home;
  }

  Widget _buildAppBar(BuildContext context, double statusBarHeight) {
    return new SliverAppBar(
      pinned: true,
      expandedHeight: _kAppBarHeight,
      flexibleSpace: new LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final Size size = constraints.biggest;
          final double appBarHeight = size.height - statusBarHeight;
          final double t = (appBarHeight - kToolbarHeight) / (_kAppBarHeight - kToolbarHeight);
          final double extraPadding = new Tween<double>(begin: 10.0, end: 24.0).lerp(t);
          final double logoHeight = appBarHeight - 1.5 * extraPadding;
          return new Padding(
            padding: new EdgeInsets.only(
              top: statusBarHeight + 0.5 * extraPadding,
              bottom: extraPadding,
            ),
            child: new Center(
                child: new PageLogo(height: logoHeight, t: t.clamp(0.0, 1.0), liquorType: "Bourbon")
            ),
          );
        },
      ),
    );
  }



}

class PageLogo extends StatefulWidget{
  const PageLogo({this.height, this.t, this.liquorType});

  final double height;
  final double t;
  final String liquorType;

  @override
  _PageLogoState createState() => new _PageLogoState();
}

class _PageLogoState extends State<PageLogo>{
  static const double kLogoHeight = 162.0;
  static const double kLogoWidth = 220.0;
  static const double kImageHeight = 108.0;
  static const double kTextHeight = 48.0;

  final RectTween _textRectTween = new RectTween(
      begin: new Rect.fromLTWH(0.0, kLogoHeight, kLogoWidth, kTextHeight),
      end: new Rect.fromLTWH(0.0, kImageHeight, kLogoWidth, kTextHeight)
  );
  final Curve _textOpacity = const Interval(0.4, 1.0, curve: Curves.easeInOut);
  final RectTween _imageRectTween = new RectTween(
    begin: new Rect.fromLTWH(0.0, 0.0, kLogoWidth, kLogoHeight),
    end: new Rect.fromLTWH(0.0, 0.0, kLogoWidth, kImageHeight),
  );

  @override
  Widget build(BuildContext context) {
    return new Transform(
      transform: new Matrix4.identity()..scale(widget.height / kLogoHeight),
      alignment: Alignment.topCenter,
      child: new SizedBox(
        width: kLogoWidth,
        child: new Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            new Positioned.fromRect(
              rect: _imageRectTween.lerp(widget.t),
              child: new Image.asset(
                _kSmallLogoImage,
                fit: BoxFit.contain,
              ),
            ),
            new Positioned.fromRect(
              rect: _textRectTween.lerp(widget.t),
              child: new Opacity(
                opacity: _textOpacity.transform(widget.t),
                child: new Text("IPH Executive", style: Theme.TextStyles.liquorMenu, textAlign: TextAlign.center),
              ),
            ),
          ],
        ),
      ),
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