class DataManager<T> {
  final bool isSuccess;
  final T? data;
  final String? messageError;
  final int totalItems;

  DataManager._privateConstructor({
    required this.isSuccess,
    this.data,
    this.messageError,
    this.totalItems = 0,
  });

  factory DataManager.isSuccess({
    T? data,
    int totalItems = 0,
  }) {
    return DataManager._privateConstructor(
      isSuccess: true,
      data: data,
      totalItems: totalItems,
    );
  }

  factory DataManager.isError({
    String? message,
  }) {
    return DataManager._privateConstructor(
      isSuccess: false,
      messageError: message,
    );
  }
}
