abstract class DAO<T> {
  Future<void> add(T t);
  Future<List<T>> readAll(int? id);
  Future<int> update(T t);
  Future<int> delete(int id);
}