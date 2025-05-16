enum PlayerProfileSectionType {
  continuePlayingAsc('CONTINUE_PLAYING_ASC'),
  continuePlayingDesc('CONTINUE_PLAYING_DESC'),
  favoriteAsc('FAVOURITE_ASC'),
  favoriteDesc('FAVOURITE_DESC'),
  continuePlayingMutualAsc('CONTINUE_PLAYING_MUTUAL_ASC'),
  continuePlayingMutualDesc('CONTINUE_PLAYING_MUTUAL_DESC'),
  friendGameAsc('FRIEND_GAME_ASC'),
  friendGameDesc('FRIEND_GAME_DESC');

  final String value;
  const PlayerProfileSectionType(this.value);
}
