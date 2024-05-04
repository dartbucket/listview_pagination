class Endpoints {
  const Endpoints._();

  static productUrl({ required int skip, int limit = 10 }) => "https://dummyjson.com/products?limit=$limit&skip=$skip";
}