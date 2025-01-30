class Result<T>{
  Result._();

  factory Result.success(T bannerList) = SuccessState;
  factory Result.error(T foo) = ErrorState ;
  factory Result.noInternet(String msg) = NoInternetState;
}

class NoInternetState<T> extends Result<T> {
  NoInternetState(this.msg): super._();

  final String msg;
}

class ErrorState<T> extends Result<T> {
  ErrorState(this.msg): super._();

  final T msg;
}

class SuccessState<T> extends Result<T> {
  SuccessState(this.value): super._();

  final T value;
}