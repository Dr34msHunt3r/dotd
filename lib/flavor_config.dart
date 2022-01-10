enum Flavor {
  RESTAPI,
  MOOR,
  SECURE_STORAGE
}

class FlavorValues {
  FlavorValues({required this.source});
  final String source;
}

class FlavorConfig {
  final Flavor flavor;
  final FlavorValues values;
  final String appDisplayName;
  static late FlavorConfig _instance;


  factory FlavorConfig({
    required FlavorValues values,
    required Flavor flavor,}) {
     _instance = FlavorConfig._internal(
        flavor, values, flavor.toString());
    return _instance;
  }

  FlavorConfig._internal(this.flavor, this.values, this.appDisplayName);

  static FlavorConfig get instance {
    return _instance;
  }

  static bool isRecipeFromRestApi() => _instance.flavor == Flavor.RESTAPI;

  static bool isRecipeFromMoor() => _instance.flavor == Flavor.MOOR;

  static bool isRecipeFromSecureStorage() => _instance.flavor == Flavor.SECURE_STORAGE;
}