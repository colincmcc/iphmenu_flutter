import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SortableListView extends StatefulWidget {
  final List items;
  final IndexedWidgetBuilder itemBuilder;
  final Widget prototype;

  SortableListView({this.items, this.itemBuilder, this.prototype})
      : assert(items != null),
        assert(itemBuilder != null);

  @override
  State createState() => new SortableListViewState();
}

class SortableListViewState extends State<SortableListView> {

  @override
  Widget build(BuildContext context){
    var sizeConstraint = MediaQuery.of(context).size;
    return new SliverList(
      delegate:  new SliverChildBuilderDelegate(
        (BuildContext context, int index){
          return new Container(
            child: new LongPressDraggable<int>(
              data: index,
              child: new DragTarget(
                onAccept: (int data) {
                  _handleAccept(data, index);
                },
                builder: (BuildContext context, List<int> data,
                    List<dynamic> rejects) {
                  List<Widget> children = [];

                  // If the dragged item is on top of this item, the we draw
                  // a half-visible item to indicate that dropping the dragged
                  // item will add it in this position.
                  if (data.isNotEmpty) {
                    children.add(
                      new Container(
                        decoration: new BoxDecoration(
                          border: new Border.all(
                              color: Colors.grey[600], width: 2.0),
                        ),
                        child: new Opacity(
                          opacity: 0.5,
                          child: _getListItem(context, data[0]),
                        ),
                      ),
                    );
                  }
                  children.add(_getListItem(context, index));

                  return new Column(
                    children: children,
                  );
                },
              ), 
              feedback: new Opacity(
                opacity: 0.75,
                child: new SizedBox(
                  width: sizeConstraint.width,
                  child: _getListItem(context, index, true),
                ),
              ),
              childWhenDragging: new Container(),
              onDragStarted: () {
                Scaffold.of(context).showSnackBar(
                  new SnackBar(
                      content: new Text("Drag the row to change places")),
                );
              },
            )
          );
        },
        childCount: widget.items.length + 1,
        addRepaintBoundaries: true,
      ),
      
    );
  }
 /*f
  @override
  Widget build(BuildContext context) {
    return new LayoutBuilder(
      builder: (context, constraint) {
        return new ListView.builder(
          itemCount: widget.items.length + 1,
          addRepaintBoundaries: true,
          itemBuilder: (context, index) {
            return new Draggable<int>(
              data: index,
              child: new DragTarget<int>(
                onAccept: (int data) {
                  _handleAccept(data, index);
                },
                builder: (BuildContext context, List<int> data,
                    List<dynamic> rejects) {
                  List<Widget> children = [];

                  // If the dragged item is on top of this item, the we draw
                  // a half-visible item to indicate that dropping the dragged
                  // item will add it in this position.
                  if (data.isNotEmpty) {
                    children.add(
                      new Container(
                        decoration: new BoxDecoration(
                          border: new Border.all(
                              color: Colors.grey[600], width: 2.0),
                        ),
                        child: new Opacity(
                          opacity: 0.5,
                          child: _getListItem(context, data[0]),
                        ),
                      ),
                    );
                  }
                  children.add(_getListItem(context, index));

                  return new Column(
                    children: children,
                  );
                },
              ),
              onDragStarted: () {
                Scaffold.of(context).showSnackBar(
                  new SnackBar(
                      content: new Text("Drag the row to change places")),
                );
              },
              feedback: new Opacity(
                opacity: 0.75,
                child: new SizedBox(
                  width: constraint.maxWidth,
                  child: _getListItem(context, index, true),
                ),
              ),
              childWhenDragging: new Container(),
            );
          },
        );
      },
    );
  }
*/
  void _handleAccept(int data, int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("sortable list before set ${widget.items}");
    setState(() {
      // Decrement index so that after removing we'll still insert the item
      // in the correct position.
      if (index > data) {
        index--;
      }
      dynamic imageToMove = widget.items[data];
      widget.items.removeAt(data);
      widget.items.insert(index, imageToMove);
      print("sortable list set ${widget.items}");
      prefs.setStringList("liquorTypes", widget.items);
    });
  }

  Widget _getListItem(BuildContext context, int index, [bool dragged = false]) {
    // A little hack: our ListView has an extra invisible trailing item to
    // allow moving the dragged item to the last position.
    if (index == widget.items.length) {
      // This invisible item uses the previous item to determine its size. If
      // the list is empty, though, there's no dragging really.
      if (widget.items.isEmpty) {
        return new Container();
      }
      return new Opacity(
        opacity: 0.0,
        child: _getListItem(context, index - 1),
      );
    }

    return new Material(
      elevation: dragged ? 20.0 : 0.0,
      child: widget.itemBuilder(context, index),
    );
  }
}