abstract class crudAb<T, R, S, U> {
  T Create(T value);

  Future<R?> Read(T value);

  Future<T?> ReadbyValue(S value);

  Future<U> Delete(S value);

  Future<U> Update(T value);

  Future<int?> getMaxCount();
}
