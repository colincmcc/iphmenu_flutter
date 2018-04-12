
class LiquorItem {
  final String id;
  final String type;
  final String distillery;
  final String name;
  final String price;
  final String proof;
  final String age;
  final String style;
  final String bill;
  final String color;
  final String weblink;
  final String imglink;
  final String image;
  final String description;

  const LiquorItem({this.id, this.type, this.distillery,this.name, this.price, this.proof,
    this.age, this.style, this.bill, this.color, this.weblink, this.imglink, this.image, this.description});

    Map toJson() {
      Map map = new Map();
      map["id"] = id;
      map["type"] = type;
      map["distillery"] = distillery;
      map["name"] = name;
      map["price"] = price;
      map["proof"] = proof;
      map["age"] = age;
      map["style"] = style;
      map["bill"] = bill;
      map["color"] = color;
      map["weblink"] = weblink;
      map["imglink"] = imglink;
      map["image"] = image;
      map["description"] = description;
      return map;
    }
}

List<LiquorItem> liquoritems = [
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
    image: "https://sectorapp.io/knob background.jpg",
    description: "assets/img/knob.png",


  ),
  const LiquorItem(
    id: "2",
    type: "Tequila",
    distillery: "Beam Suntory",
    name: "Knob Creek 25th Anniversary",
    price: r"$21",
    proof: "Proof: 122.1",
    age: "13 Years",
    style: "Tequila",
    bill: "75% Corn, 13% Rye, 12% Malted Barley",
    color: "Deep Amber",
    weblink: "http://www.breakingbourbon.com/knob-creek-25th-anniversary.html",
    imglink: "https://sectorapp.io/knob_logo.png",
    image: "https://sectorapp.io/knob background.jpg",
    description: "assets/img/knob.png",

  ),
  const LiquorItem(
    id: "3",
    type: "Rum",
    distillery: "Beam Suntory",
    name: "Knob Creek 25th Anniversary",
    price: r"$21",
    proof: "Proof: 122.1",
    age: "13 Years",
    style: "Rum",
    bill: "75% Corn, 13% Rye, 12% Malted Barley",
    color: "Deep Amber",
    weblink: "http://www.breakingbourbon.com/knob-creek-25th-anniversary.html",
    imglink: "https://sectorapp.io/knob_logo.png",
    image: "https://sectorapp.io/knob background.jpg",
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
    image: "https://sectorapp.io/knob background.jpg",
    description: "Twenty-Five years ago, when Booker Noe bottled the first batch of Knob Creek® bourbon, he inadvertently started a small batch movement. A quarter century later, Booker’s son Fred Noe carries on his legacy, holding every barrel to the same rigorous Pre-Prohibition style standards. And to this day, Knob Creek® remains the benchmark for full-flavored bourbon.",

  ),
];



