class restaurantModel {
  String name = "";
  String location = "";
  String link = "";
  String tall_link = "";
  String time = "";
  String price = "";
  String reviews = "";
  String type = "";
  //List<foods> Foods = [];

  restaurantModel({required this.name, required this.location, required this.link, required this.price, required this.reviews, required this.type,required this.tall_link,required this.time});

  restaurantModel.fromJson(Map<String, dynamic> json){
    name = json['name'];
    location = json['location'];
    link = json['link'];
    tall_link = json['tall_link'];
    time = json['time'];
    price = json['price'];
    reviews = json['reviews'];
    type = json['type'];
    //Foods = List.from(json['foods']).map((e)=>foods.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['location'] = location;
    _data['link'] = link;
    _data['tall_link'] = tall_link;
    _data['time'] = time;
    _data['price'] = price;
    _data['reviews'] = reviews;
    _data['type'] = type;
    //_data['results'] = Foods.map((e)=>e.toJson()).toList();
    return _data;
  }

}

class foods {
  String description = "";
  String price = "";

  foods({required this.description, required this.price});

  foods.fromJson(Map<String, dynamic> json){
    description = json['description'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['description'] = description;
    _data['price'] = price;
    return _data;
  }
}