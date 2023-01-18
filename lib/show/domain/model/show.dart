class Show {
  String id;
  String author;
  num width;
  num height;
  String url;
  String downloadUrl;
  bool isFavourite;

  Show(
      {this.id,
      this.author,
      this.width,
      this.height,
      this.url,
      this.downloadUrl,
      this.isFavourite});

  Show.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    author = json['author'];
    width = json['width'];
    height = json['height'];
    url = json['url'];
    downloadUrl = json['download_url'];
    isFavourite = json['isFavourite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['author'] = this.author;
    data['width'] = this.width;
    data['height'] = this.height;
    data['url'] = this.url;
    data['download_url'] = this.downloadUrl;
    data['isFavourite'] = this.isFavourite;
    return data;
  }
}
