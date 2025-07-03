abstract class StatePage<T> {}

class StateStart<T> extends StatePage<T> {}

class StateSuccess<T> extends StatePage<T> {
  final T? data;

  StateSuccess({this.data});
}

class StateEmpty<T> extends StatePage<T> {}

class StateError<T> extends StatePage<T> {
  String? message;
  Exception? exception;

  StateError({this.message, this.exception});
}

class StateLoading<T> extends StatePage<T> {}
