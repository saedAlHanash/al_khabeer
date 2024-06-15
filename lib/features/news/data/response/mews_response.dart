class NewsResponse {
  NewsResponse({
    required this.data,
  });

  final List<NewsData> data;

  factory NewsResponse.fromJson(Map<String, dynamic> json) {
    return NewsResponse(
      data: json["data"] == null
          ? []
          : List<NewsData>.from(json["data"]!.map((x) => NewsData.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class NewsData {
  NewsData({
    required this.id,
    required this.date,
    required this.title,
    required this.note,
    required this.image,
  });

  final int id;
  final String date;
  final String title;
  final String note;
  final String image;

  factory NewsData.fromJson(Map<String, dynamic> json) {
    return NewsData(
      id: json["id"] ?? 0,
      date: json["date"] ?? "",
      title: json["title"] ?? "",
      note: json["note"] ?? "",
      image: json["image"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "title": title,
        "note": note,
        "image": image,
      };
}
