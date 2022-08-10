class APIPath {
  static String order(String uid, String orderdetails) =>
      '/users/$uid/Orders/$orderdetails';
  static String orders(String uid) => '/users/$uid/Orders';
}
