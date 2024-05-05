class UserDBQueries {
  static const String table = "USER_PREFERENCE";

  static const String col1 = 'userId';
  static const String col2 = 'name';
  static const String col3 = 'email';
  static const String col4 = 'password';
  static const String col5 = 'profile';
  static const String col6 = 'country';

  static const String createTable =
      "CREATE TABLE $table ($col1 TEXT PRIMARY KEY, $col2 TEXT, $col3 TEXT, $col4 TEXT, $col5 TEXT, $col6 TEXT)";

}
