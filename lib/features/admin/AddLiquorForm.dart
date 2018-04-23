import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:iphmenu/modal/LiquorItem.dart';
import 'package:iphmenu/features/common/AppBars.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LiquorFormField extends StatefulWidget {
  const LiquorFormField({ Key key }) : super(key: key);

  static const String routeName = '/text-form-field';

  @override
  LiquorFormFieldState createState() => new LiquorFormFieldState();
}

class LiquorData {
  String id = "";
  String type = "";
  String distillery = "";
  String name = "";
  String price = "";
  String proof = "";
  String age = "";
  String style = "";
  String bill = "";
  String color = "";
  String weblink = "";
  String imglink = "";
  String image = "";
  String description = "";
}

class LiquorFormFieldState extends State<LiquorFormField> {

  TextEditingController _textController = new TextEditingController();
  LiquorData liquor = new LiquorData();
  List<LiquorItem> liquorList = [];
  String _submittedValidation = "";
  final Random _random = new Random();
  List<String> _liquorTypes = [];
  List<String> _submittedLiquorTypes =[];
  List dropDownFields = [];
  bool _visible = true;
  String dropDownValue;





  _updateLiquorList(formLiquorItem) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String _liquorJson = prefs.getString(liquor.type);
    print("liquorJson is $_liquorJson");
    if(_liquorJson == null){
      liquorList.insert(0, formLiquorItem);
      setState(() {
        _liquorJson = json.encode(liquorList);
        prefs.setString(liquor.type, _liquorJson).then((bool success) {
          _submittedValidation = "SUBMITTED!";
          print("liquor json was null $_liquorJson");
        });
      });
    } else {
      var data = json.decode(_liquorJson);
      setState(() {
        liquorList = (data as List).map((i) => new LiquorItem.fromJson(i)).toList();
        print("liquorlist is $liquorList");
        liquorList.insert(0, formLiquorItem);
        String _submittedLiquorJson = json.encode(liquorList);
        prefs.setString(liquor.type, _submittedLiquorJson).then((bool success) {
          _submittedValidation = "SUBMITTED!";
          print("liquor json not null $_submittedLiquorJson");
        });
      });
    }

  }


  bool _autovalidate = false;
  bool _formWasEdited = false;
  final GlobalKey<FormState> _formLiquorKey = new GlobalKey<FormState>();


  void _handleSubmitted() async {
    final FormState form = _formLiquorKey.currentState;
    form.save();
    String _randomId = _random.nextInt(10000).toString();
    print(_randomId);


    if(_visible == false) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState((){
        if(_liquorTypes != null)
          _submittedLiquorTypes.addAll(_liquorTypes);
        _submittedLiquorTypes.add(liquor.type);
        print(_submittedLiquorTypes);
        prefs.setStringList("liquorTypes", _submittedLiquorTypes);
        _visible = true;
      });
      _getLiquorTypes();
    }
    var formLiquorItem = new LiquorItem(
      id: _randomId,
      type: liquor.type,
      distillery: liquor.distillery,
      name: liquor.name,
      price: r"$" + liquor.price,
      proof: "Proof " + liquor.proof,
      age: liquor.age,
      style: liquor.style,
      bill: liquor.bill,
      color: liquor.color,
      weblink: liquor.weblink,
      imglink: liquor.imglink,
      image: liquor.image,
      description: liquor.description,
    );


    _updateLiquorList(formLiquorItem);

  }


  Future<bool> _warnUserAboutInvalidData() async {
    final FormState form = _formLiquorKey.currentState;
    if (form == null || !_formWasEdited || form.validate())
      return true;

    return await showDialog<bool>(
      context: context,
      child: new AlertDialog(
        title: const Text('This form has errors'),
        content: const Text('Really leave this form?'),
        actions: <Widget> [
          new FlatButton(
            child: const Text('YES'),
            onPressed: () { Navigator.of(context).pop(true); },
          ),
          new FlatButton(
            child: const Text('NO'),
            onPressed: () { Navigator.of(context).pop(false); },
          ),
        ],
      ),
    ) ?? false;
  }
  void _getLiquorTypes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _liquorTypes = prefs.getStringList("liquorTypes");
      print(_liquorTypes);
      if(_liquorTypes != null) {
        dropDownFields = _liquorTypes
            .map((String value) {
          return new DropdownMenuItem<String>(
            value: value,
            child: new Text(value),
          );
        }
        ).toList();
      }
      dropDownFields.add(
        new DropdownMenuItem<String>(
            value: "addNew",
            child: new Text("Add New")
        )

      );

    });

  }

    @override
    void initState() {
      super.initState();
      _getLiquorTypes();
    }

    @override
    Widget build(BuildContext context) {
      return new Scaffold(
        appBar: new PreferredSize(child: new GradientAppBar("ADD LIQUOR"), preferredSize: const Size.fromHeight(48.0)),
        body: new SafeArea(
          top: false,
          bottom: false,
          child: new Form(
            key: _formLiquorKey,
            autovalidate: _autovalidate,
            onWillPop: _warnUserAboutInvalidData,
            child: new SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: new Column(
                  children: <Widget>[
                    new TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Name of Liquor',
                        labelText: 'Name *',
                      ),
                      onSaved: (String value) { liquor.name = value; },
                    ),
                    new AnimatedCrossFade(
                        firstChild: new DropdownButton(
                          value:dropDownValue,
                          items: dropDownFields,
                          hint: new Text("Select a current type or add a new one"),
                          onChanged: (String value){
                            setState((){
                              if(value == "addNew") {
                                _visible = false;
                              }
                              else{
                                dropDownValue = value;
                                _textController.text = value.toLowerCase();
                                _visible = true;
                                print(value);
                              }
                            });
                          },
                        ),
                        secondChild: new Container(
                            child: new TextFormField(
                              controller: _textController,
                              decoration: const InputDecoration(
                                hintText: 'What style of liquor is it?',
                                labelText: 'Type',
                              ),
                              onSaved: (String value) { liquor.type = value.toLowerCase(); },
                            )
                        ),
                        crossFadeState: _visible ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                        duration: const Duration(seconds: 1)),
                    new TextFormField(
                      initialValue: "Clase Azul",
                      decoration: const InputDecoration(
                        icon: const Icon(Icons.person),
                        hintText: 'Who makes this?',
                        labelText: 'Distillery/Brewery',
                      ),
                      onSaved: (String value) { liquor.distillery = value; },
                    ),
                    new TextFormField(
                      initialValue: "https://www.claseazul.com/img/clase-azul-family/plata/tequila-anejo.png",
                      decoration: const InputDecoration(
                        hintText: 'Picture of bottle / company logo / etc',
                        labelText: 'Small logo link',
                      ),
                      keyboardType: TextInputType.url,
                      onSaved: (String value) { liquor.imglink = value; },
                    ),
                    new TextFormField(
                      initialValue: "http://i2.cdn.turner.com/money/dam/assets/170703142445-clase-azul-780x439.jpg",
                      decoration: const InputDecoration(
                        hintText: 'Large background image link',
                        labelText: 'Background image',
                      ),
                      keyboardType: TextInputType.url,
                      onSaved: (String value) { liquor.image = value; },
                    ),
                    new TextFormField(
                      initialValue: "https://www.claseazul.com",
                      decoration: const InputDecoration(
                        icon: const Icon(Icons.web),
                        hintText: 'Link to company or liquor website',
                        labelText: 'Website',
                      ),
                      keyboardType: TextInputType.url,
                      onSaved: (String value) { liquor.weblink = value; },
                    ),
                    new TextFormField(
                      initialValue: "Clase Azul Añejo “Edición Indígena-Mazahua” (Mazahua Edition) is an ultra- premium añejo tequila made from Tequilana Weber Blue Agave. Its intense amber color and layered aromas are a result of an extended period of aging.",
                      decoration: const InputDecoration(
                        hintText: 'Tell us about the liquor',
                        helperText: 'Keep it short',
                        labelText: 'About',
                      ),
                      onSaved: (String value) { liquor.description = value; },
                      maxLines: 5,
                    ),
                    new TextFormField(
                      initialValue: "34",
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          labelText: 'Price',
                          prefixText: '\$',
                          suffixStyle: const TextStyle(color: Colors.green)
                      ),
                      onSaved: (String value) { liquor.price = value; },
                      maxLines: 1,
                    ),
                    new TextFormField(
                      initialValue: "110",
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Proof',
                      ),
                      onSaved: (String value) { liquor.proof = value; },
                      maxLines: 1,
                    ),
                    new TextFormField(
                      initialValue: "3 Years",
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: 'Age',
                        helperText: 'Please specify if years/months',
                      ),
                      onSaved: (String value) { liquor.age = value; },
                      maxLines: 1,
                    ),
                    new TextFormField(
                      initialValue: "Tequila",
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: 'Substyle',
                        hintText: 'Stout / Barrel Aged / etc.',
                      ),
                      onSaved: (String value) { liquor.style = value; },
                      maxLines: 1,
                    ),
                    new TextFormField(
                      initialValue: "TASTE: Cooked agave flavors with touches of vanilla, caramel, and various woods through the finish.",
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: 'Bill/Tasting Notes',
                      ),
                      onSaved: (String value) { liquor.bill = value; },
                      maxLines: 1,
                    ),
                    new TextFormField(
                      initialValue: "Intense Amber",

                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: 'Color',
                      ),
                      onSaved: (String value) { liquor.color = value; },
                      maxLines: 1,
                    ),
                    new Container(
                      padding: const EdgeInsets.all(20.0),
                      alignment: Alignment.center,
                      child: new RaisedButton(
                        child: const Text('SUBMIT'),
                        onPressed: _handleSubmitted,
                      ),
                    ),
                    new Container(
                        child: new Text(_submittedValidation)
                    ),
                    new Container(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: new Text('* indicates required field', style: Theme.of(context).textTheme.caption),
                    ),

                  ],
                )


            ),
          ),
        ),
      );
    }
  }



