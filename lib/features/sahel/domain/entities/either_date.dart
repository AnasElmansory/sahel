class EitherDate {
  final DateTime value;
  final String errMessage;

  const EitherDate._({this.value, this.errMessage});
  factory EitherDate(dynamic value) {
    if (value.runtimeType != DateTime) {
      return EitherDate._(errMessage: value);
    } else
      return EitherDate._(value: value);
  }
}
