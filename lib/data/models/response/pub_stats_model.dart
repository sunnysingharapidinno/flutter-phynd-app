class PubStatsModel {
  TotalEarning? totalEarning;
  TotalEarning? lastMonthEarning;
  int? totalGameImported;
  int? lastMonthGameImported;
  int? totalAsset;
  int? lastMonthAssetImport;
  int? assetSold;
  int? lastMonthAssetSold;
  int? purchase;
  int? activityCount;
  int? gamesCount;
  int? upcomingEvents;

  PubStatsModel(
      {this.totalEarning,
      this.lastMonthEarning,
      this.totalGameImported,
      this.lastMonthGameImported,
      this.totalAsset,
      this.lastMonthAssetImport,
      this.assetSold,
      this.lastMonthAssetSold,
      this.purchase,
      this.activityCount,
      this.gamesCount,
      this.upcomingEvents});

  PubStatsModel.fromJson(Map<String, dynamic> json) {
    totalEarning = json['total_earning'] != null
        ? new TotalEarning.fromJson(json['total_earning'])
        : null;
    lastMonthEarning = json['last_month_earning'] != null
        ? new TotalEarning.fromJson(json['last_month_earning'])
        : null;
    totalGameImported = json['total_game_imported'];
    lastMonthGameImported = json['last_month_game_imported'];
    totalAsset = json['total_asset'];
    lastMonthAssetImport = json['last_month_asset_import'];
    assetSold = json['asset_sold'];
    lastMonthAssetSold = json['last_month_asset_sold'];
    purchase = json['purchase'];
    activityCount = json['activity_count'];
    gamesCount = json['games_count'];
    upcomingEvents = json['upcoming_events'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.totalEarning != null) {
      data['total_earning'] = this.totalEarning!.toJson();
    }
    if (this.lastMonthEarning != null) {
      data['last_month_earning'] = this.lastMonthEarning!.toJson();
    }
    data['total_game_imported'] = this.totalGameImported;
    data['last_month_game_imported'] = this.lastMonthGameImported;
    data['total_asset'] = this.totalAsset;
    data['last_month_asset_import'] = this.lastMonthAssetImport;
    data['asset_sold'] = this.assetSold;
    data['last_month_asset_sold'] = this.lastMonthAssetSold;
    data['purchase'] = this.purchase;
    data['activity_count'] = this.activityCount;
    data['games_count'] = this.gamesCount;
    data['upcoming_events'] = this.upcomingEvents;
    return data;
  }
}

class TotalEarning {
  String? lamport;
  String? wei;

  TotalEarning({this.lamport, this.wei});

  TotalEarning.fromJson(Map<String, dynamic> json) {
    lamport = json['lamport'];
    wei = json['wei'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lamport'] = this.lamport;
    data['wei'] = this.wei;
    return data;
  }
}
