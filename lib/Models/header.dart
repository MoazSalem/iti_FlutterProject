class headerModel {
   String Name = "";
   String Link = "";

  headerModel({required this.Name, required this.Link});

  headerModel.fromJson(Map<String, dynamic> json) {
    Name = json['name'];
    Link = json['Link'];
  }

  Map<String, dynamic> toMap() {
    return {
      'Name': Name,
      'Link': Link,
    };
  }
}
