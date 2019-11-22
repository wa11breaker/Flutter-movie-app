class Movies {
  String index;
  String category;
  String name;
  String image;
  String rating;
  String duration;
  String link480;
  String link720;

  Movies(
    this.index,
    this.category,
    this.name,
    this.image,
    this.rating,
    this.duration,
    this.link480,
    this.link720,
  );

  Movies.fromJson(Map<String, dynamic> json) {
    index = json["index"].toString();
    category = json['category'];
    name = json['name'];
    image = json['image'];
    rating = json['rating'].toString();
    duration = json['duration'];
    link480 = json['link480'];
    link720 = json['link720'];
    
  }
}


