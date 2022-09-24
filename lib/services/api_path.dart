class APIPath {
  static String order(String uid, String orderID) =>
      '/users/$uid/Orders/$orderID';
  static String orders(String uid) => '/users/$uid/Orders';
}
