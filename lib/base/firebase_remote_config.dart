import 'dart:convert';

import 'package:dotd/config/app_consts.dart';
import 'package:dotd/config/remote/app_theme_dto.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class FirebaseRemoteConfig {

  final RemoteConfig _remoteConfig = RemoteConfig.instance;

  bool _isInitialized = false;

  final _defaults = <String, dynamic>{
    AppConsts.primaryThemeKey: jsonEncode(AppThemeConfigDto.defaultConfig)
  };

  Future _fetchAndActivate() async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: Duration(seconds: 10),
      minimumFetchInterval: Duration(minutes: 1),
    ));
    await _remoteConfig.fetch();
    await _remoteConfig.activate();
  }

  Future initialise() async{
    try {
      if (_isInitialized) {
        throw "'FirebaseRemoteConfig' has already initialized";
      }
      await _remoteConfig.setDefaults(_defaults);
      await _fetchAndActivate();
      try {
        _parseDtos();
      } catch (e) {
        print(e);
      }
      _isInitialized = true;
    } catch (e) {
      print(e);
    }
  }

  late AppThemeConfigDto _appThemeConfigDto;
  AppThemeConfigDto get appThemeConfigDto {
    _setDefaultIfNotInitialized();
    return _appThemeConfigDto;
  }

  AppThemeConfigDto? _setDefaultIfNotInitialized(){
    if(_isInitialized == false) {
      return _appThemeConfigDto = AppThemeConfigDto();
    }
  }

  void _parseDtos() {
    try{
      _appThemeConfigDto = AppThemeConfigDto.fromJson(
        jsonDecode(_remoteConfig.getString(AppConsts.primaryThemeKey))
      );
    }catch(err){
      print(err);
    }
  }

}