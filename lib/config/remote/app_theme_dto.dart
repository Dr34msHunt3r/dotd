
import 'package:dotd/config/app_colors.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_theme_dto.g.dart';

@JsonSerializable()
class AppThemeConfigDto {

  static final defaultConfig = <String, dynamic>{
    primaryColorKey: AppColors.primaryColor.toString()
  };

  final String? primaryColor;

  AppThemeConfigDto({
       this.primaryColor
  });

  static const String primaryColorKey = "primaryColor";

  static const fromJsonFactory = _$AppThemeConfigDtoFromJson;

  factory AppThemeConfigDto.fromJson(Map<String, dynamic> json) => _$AppThemeConfigDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AppThemeConfigDtoToJson(this);
}