class AppFailure {
  const AppFailure(this.message, {this.code});

  final String message;
  final String? code;

  @override
  String toString() {
    return code == null ? message : '$code: $message';
  }
}
