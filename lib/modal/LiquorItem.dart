
class LiquorItem {
   String id;
   String type;
   String distillery;
   String name;
   String price;
   String proof;
   String age;
   String style;
   String bill;
   String color;
   String weblink;
   String imglink;
   String image;
   String description;

   LiquorItem({this.id, this.type, this.distillery,this.name, this.price, this.proof,
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

  LiquorItem.fromJson(Map json) {
    this.id = json['id'];
    this.type = json['type'];
    this.distillery = json['distillery'];
    this.name = json['name'];
    this.price = json['price'];
    this.proof = json['proof'];
    this.age = json['age'];
    this.style = json['style'];
    this.bill = json['bill'];
    this.color = json['color'];
    this.weblink = json['weblink'];
    this.imglink = json['imglink'];
    this.image = json['image'];
    this.description = json['description'];

  }

   static LiquorItem getLiquorById(id) {
     return liquoritems
         .where((p) => p.id == id)
         .first;
   }
}
//List<LiquorItem> liquoritems = [];

var defaultLiquorItem =
  new LiquorItem(
    id: " ",
    type: " ",
    distillery: " ",
    name: " ",
    price: r" ",
    proof: " ",
    age: " ",
    style: " ",
    bill: " ",
    color: " ",
    weblink: " ",
    imglink: " ",
    image: " ",
    description: " ",


  );

final List<LiquorItem> liquoritems = [
  new LiquorItem(
      id: "1",
      type: " ",
      distillery: " ",
      name: " ",
      price: r" ",
      proof: " ",
      age: " ",
      style: " ",
      bill: " ",
      color: " ",
      weblink: " ",
      imglink: " ",
      image: " ",
      description: " ",
  ),

];



