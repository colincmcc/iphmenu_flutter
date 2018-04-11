import 'package:flutter/material.dart';
import 'package:iphmenu/features/liquor/LiquorListPage.dart';
import 'package:iphmenu/features/common/AppBars.dart';
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
                    child: new Text(liquorType.title, style: Theme.TextStyles.appBarTitle),
                  ),
                ),
              ),
            )
        );
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
          new AnimatedAppBar(context, "IPH Executive"),
          _buildBody()
        ]
      ),
    );

    return home;
  }

  Widget _buildBody(){
    return new SliverList(delegate: new SliverChildListDelegate(_menuListItems()));

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