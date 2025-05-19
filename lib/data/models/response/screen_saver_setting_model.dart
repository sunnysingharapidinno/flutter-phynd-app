class ScreenSaverSettingModel {
  int? id;
  int? timeOutSeconds;

  ScreenSaverSettingModel({this.id, this.timeOutSeconds});

  ScreenSaverSettingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    timeOutSeconds = json['time_out_seconds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['time_out_seconds'] = this.timeOutSeconds;
    return data;
  }
}
