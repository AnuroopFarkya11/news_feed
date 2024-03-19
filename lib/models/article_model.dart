class Article {
  final dynamic source;
  final String? src;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  Article({
    required this.source,
    this.src,
    this.author,
    required this.title,
    this.description,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
    this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      source: json['source'],
      src: json['src'],
      author: json['author'],
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'],
      content: json['content'],
    );
  }
  //
  // factory Article.fromDBJson(Map<String, dynamic> json) {
  //   return Article(
  //     source: json['SOURCE'],
  //     author: json['AUTHOR'],
  //     title: json['TITLE'],
  //     description: json['DESCRIPTION'],
  //     url: json['URL'],
  //     urlToImage: json['URLTOIMAGE'],
  //     publishedAt: json['PUBLISHEDAT'],
  //     content: json['CONTENT'],
  //   );
  // }

  Map<String,dynamic> toJson()
  {
    return {
      'title':title,
      'description':description,
      'content':content,
      'source':source,
      'src':src,
      'url':url,
      'urlToImage':urlToImage,
      'author':author,
      'publishedAt':publishedAt
    };
  }

  // Map<String,dynamic> toDBJson()
  // {
  //   return {
  //     'TITLE':title,
  //     'DESCRIPTION':description,
  //     'CONTENT':content,
  //     'SOURCE':source,
  //     'URL':url,
  //     'URLTOIMAGE':urlToImage,
  //     'AUTHOR':author,
  //     'PUBLISHEDAT':publishedAt
  //   };
  // }


}