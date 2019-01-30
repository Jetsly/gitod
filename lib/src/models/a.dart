void main() {
  print('int test');
  test<int>(1);

  print('\r\nint list test');
  test<List<int>>(<int>[]);

  print('\r\nobject test');
  test<A<int>>(A<int>());
}

void test<T>(T t) {
  print(T);

  print(t.runtimeType);

  print(T == t.runtimeType);

  print(identical(T, t.runtimeType));
}

class A<T> {}
