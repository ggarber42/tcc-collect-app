abstract class DAO<T> {
  void add(T t);
  Future<List<T>> readAll();
  Future<int> update(T t);
  Future<int> delete(int id);
}