import 'package:iphmenu/modal/LiquorItem.dart';

class LiquorDao {

  static final List<LiquorItem> liquoritems = [
    const LiquorItem(
        id: "1",
        type: "Bourbon",
        distillery: "Beam Suntory",
        name: "Knob Creek 25th Anniversary",
        price: r"$21",
        proof: "Proof: 122.1",
        age: "13 Years",
        style: "Bourbon",
        bill: "75% Corn, 13% Rye, 12% Malted Barley",
        color: "Deep Amber",
        weblink: "http://www.breakingbourbon.com/knob-creek-25th-anniversary.html",
        imglink: "https://sectorapp.io/knob_logo.png",
        image: "https://sectorapp.io/knob background.png",
        description: "assets/img/knob.png",


    ),
    const LiquorItem(
      id: "2",
      type: "Bourbon",
      distillery: "Beam Suntory",
      name: "Knob Creek 25th Anniversary",
      price: r"$21",
      proof: "Proof: 122.1",
      age: "13 Years",
      style: "Bourbon",
      bill: "75% Corn, 13% Rye, 12% Malted Barley",
      color: "Deep Amber",
      weblink: "http://www.breakingbourbon.com/knob-creek-25th-anniversary.html",
      imglink: "https://sectorapp.io/knob_logo.png",
      image: "https://sectorapp.io/knob background.png",
      description: "assets/img/knob.png",

    ),
    const LiquorItem(
      id: "3",
      type: "Bourbon",
      distillery: "Beam Suntory",
      name: "Knob Creek 25th Anniversary",
      price: r"$21",
      proof: "Proof: 122.1",
      age: "13 Years",
      style: "Bourbon",
      bill: "75% Corn, 13% Rye, 12% Malted Barley",
      color: "Deep Amber",
      weblink: "http://www.breakingbourbon.com/knob-creek-25th-anniversary.html",
      imglink: "https://sectorapp.io/knob_logo.png",
      image: "https://sectorapp.io/knob background.png",
      description: "assets/img/knob.png",

    ),
    const LiquorItem(
      id: "4",
      type: "Bourbon",
      distillery: "Beam Suntory",
      name: "Knob Creek 25th Anniversary",
      price: r"$21",
      proof: "Proof: 122.1",
      age: "13 Years",
      style: "Bourbon",
      bill: "75% Corn, 13% Rye, 12% Malted Barley",
      color: "Deep Amber",
      imglink: "https://sectorapp.io/knob_logo.png",
      image: "https://sectorapp.io/knob background.png",
      description: "Twenty-Five years ago, when Booker Noe bottled the first batch of Knob Creek® bourbon, he inadvertently started a small batch movement. A quarter century later, Booker’s son Fred Noe carries on his legacy, holding every barrel to the same rigorous Pre-Prohibition style standards. And to this day, Knob Creek® remains the benchmark for full-flavored bourbon.",

    ),
  ];

  static LiquorItem getLiquorById(id) {
    return liquoritems
        .where((p) => p.id == id)
        .first;
  }
}