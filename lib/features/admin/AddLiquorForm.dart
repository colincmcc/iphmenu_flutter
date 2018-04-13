import 'dart:async';
import 'dart:convert';

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

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  LiquorData liquor = new LiquorData();

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

  @override
  void initState() {
    super.initState();
    _liquorList = _prefs.then((SharedPreferences prefs) {
      return (prefs.getString('masterLiquorList'));
    });
    _updateLiquorList();
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: new Text(value)
    ));
  }

  bool _autovalidate = false;
  bool _formWasEdited = false;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _passwordFieldKey = new GlobalKey<FormFieldState<String>>();
  final _UsNumberTextInputFormatter _phoneNumberFormatter = new _UsNumberTextInputFormatter();


  void _handleSubmitted() {
    final FormState form = _formKey.currentState;
    form.save();

    int lastIndex = (liquoritems.last.id != "") ? int.parse(liquoritems.last.id)+1 : 1;
    String currentIndex = lastIndex.toString();

    var formLiquorItem = new LiquorItem(
      id: currentIndex,
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


    (liquoritems != null) ? liquoritems.insert(0, formLiquorItem) : null;
    _updateLiquorList();


  }

  String _validateName(String value) {
    _formWasEdited = true;
    if (value.isEmpty)
      return 'Name is required.';
    final RegExp nameExp = new RegExp(r'^[A-Za-z ]+$');
    if (!nameExp.hasMatch(value))
      return 'Please enter only alphabetical characters.';
    return null;
  }

  String _validatePhoneNumber(String value) {
    _formWasEdited = true;
    final RegExp phoneExp = new RegExp(r'^\(\d\d\d\) \d\d\d\-\d\d\d\d$');
    if (!phoneExp.hasMatch(value))
      return '(###) ###-#### - Please enter a valid US phone number.';
    return null;
  }

  String _validatePassword(String value) {
    _formWasEdited = true;
    final FormFieldState<String> passwordField = _passwordFieldKey.currentState;
    if (passwordField.value == null || passwordField.value.isEmpty)
      return 'Please choose a password.';
    if (passwordField.value != value)
      return 'Passwords don\'t match';
    return null;
  }

  Future<bool> _warnUserAboutInvalidData() async {
    final FormState form = _formKey.currentState;
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new PreferredSize(child: new GradientAppBar("ADD LIQUOR"), preferredSize: const Size.fromHeight(48.0)),
      body: new SafeArea(
        top: false,
        bottom: false,
        child: new Form(
          key: _formKey,
          autovalidate: _autovalidate,
          onWillPop: _warnUserAboutInvalidData,
          child: new SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: new Column(
              children: <Widget>[
                new TextFormField(
                  initialValue: "Clase Azul",
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.person),
                    hintText: 'What do people call you?',
                    labelText: 'Name *',
                  ),
                  onSaved: (String value) { liquor.name = value; },
                ),
                new TextFormField(
                  initialValue: "Tequila",
                  decoration: const InputDecoration(
                    hintText: 'What do people call you?',
                    labelText: 'Type',
                  ),
                  onSaved: (String value) { liquor.type = value; },
                ),
                new TextFormField(
                  initialValue: "Clase Azul",
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.person),
                    hintText: 'What do people call you?',
                    labelText: 'Distillery/Brewery',
                  ),
                  onSaved: (String value) { liquor.distillery = value; },
                ),
                new TextFormField(
                  initialValue: "https://www.claseazul.com/img/clase-azul-family/plata/tequila-anejo.png",
                  decoration: const InputDecoration(
                    hintText: 'Where can we reach you?',
                    labelText: 'Logo',
                  ),
                  keyboardType: TextInputType.url,
                  onSaved: (String value) { liquor.imglink = value; },
                ),
                new TextFormField(
                  initialValue: "http://i2.cdn.turner.com/money/dam/assets/170703142445-clase-azul-780x439.jpg",
                  decoration: const InputDecoration(
                    hintText: 'Where can we reach you?',
                    labelText: 'Background',
                  ),
                  keyboardType: TextInputType.url,
                  onSaved: (String value) { liquor.image = value; },
                ),
                new TextFormField(
                  initialValue: "https://www.claseazul.com",
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.web),
                    hintText: 'Your email address',
                    labelText: 'Website',
                  ),
                  keyboardType: TextInputType.url,
                  onSaved: (String value) { liquor.weblink = value; },
                ),
                new TextFormField(
                  initialValue: "Clase Azul Añejo “Edición Indígena-Mazahua” (Mazahua Edition) is an ultra- premium añejo tequila made from Tequilana Weber Blue Agave. Its intense amber color and layered aromas are a result of an extended period of aging.",
                  decoration: const InputDecoration(
                    hintText: 'Tell us about yourself',
                    helperText: 'Keep it short, this is just a demo',
                    labelText: 'About',
                  ),
                  onSaved: (String value) { liquor.description = value; },
                  maxLines: 5,
                ),
                new TextFormField(
                  initialValue: "34",
                  keyboardType: TextInputType.text,
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
                  keyboardType: TextInputType.text,
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
                  ),
                  onSaved: (String value) { liquor.age = value; },
                  maxLines: 1,
                ),
                new TextFormField(
                  initialValue: "Tequila",
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Style',
                  ),
                  onSaved: (String value) { liquor.style = value; },
                  maxLines: 1,
                ),
                new TextFormField(
                  initialValue: "TASTE: Cooked agave flavors with touches of vanilla, caramel, and various woods through the finish.",
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Bill',
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

/// Format incoming numeric text to fit the format of (###) ###-#### ##...
class _UsNumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue
      ) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = new StringBuffer();
    if (newTextLength >= 1) {
      newText.write('(');
      if (newValue.selection.end >= 1)
        selectionIndex++;
    }
    if (newTextLength >= 4) {
      newText.write(newValue.text.substring(0, usedSubstringIndex = 3) + ') ');
      if (newValue.selection.end >= 3)
        selectionIndex += 2;
    }
    if (newTextLength >= 7) {
      newText.write(newValue.text.substring(3, usedSubstringIndex = 6) + '-');
      if (newValue.selection.end >= 6)
        selectionIndex++;
    }
    if (newTextLength >= 11) {
      newText.write(newValue.text.substring(6, usedSubstringIndex = 10) + ' ');
      if (newValue.selection.end >= 10)
        selectionIndex++;
    }
    // Dump the rest.
    if (newTextLength >= usedSubstringIndex)
      newText.write(newValue.text.substring(usedSubstringIndex));
    return new TextEditingValue(
      text: newText.toString(),
      selection: new TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
