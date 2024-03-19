class DBQueries {
  static const String table1 = "NEWS";

  // static const String _col1 = "NEWSID";
  static const String col2 = "title";
  static const String col3 = "description";
  static const String col4 = "content";
  static const String col5= "source";
  static const String col6 = "src";
  static const String col7 = "url";
  static const String col8 = "urlToImage";
  static const String col9 = "author";
  static const String col10 = "publishedAt";

  static String createTable =
      "CREATE TABLE  $table1 ( $col2 TEXT PRIMARY KEY, $col3 TEXT, $col4 TEXT, $col5 TEXT, $col6 TEXT, $col7 TEXT, $col8 TEXT,$col9 Text, $col10 Text);";
  static String insertData =
      "INSERT INTO $table1 ($col2, $col3, $col4, $col5, $col6, $col7,$col8, $col9, $col10) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)";

  static String truncateData = "DELETE FROM $table1";
}
