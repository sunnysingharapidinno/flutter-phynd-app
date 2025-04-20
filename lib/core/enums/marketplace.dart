enum MarketplaceGameType {
  trendingGames('TRENDING_GAMES'),
  newlyReleased('NEWLY_RELEASED'),
  topSeller('TOP_SELLER'),
  topGames('TOP_GAMES'),
  upcoming('UPCOMING'),
  featured('FEATURED'),
  browserGames('BROWSER_GAMES'),
  all('ALL');

  final String value;

  const MarketplaceGameType(this.value);
}
