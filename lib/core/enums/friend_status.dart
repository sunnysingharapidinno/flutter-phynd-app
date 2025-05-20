enum FriendStatus {
  pending('PENDING'),
  accepted('ACCEPTED'),
  received('RECEIVED');

  final String value;

  const FriendStatus(this.value);

  static FriendStatus fromValue(String value) {
    return FriendStatus.values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw Exception('Invalid FriendStatus: $value'),
    );
  }
}
