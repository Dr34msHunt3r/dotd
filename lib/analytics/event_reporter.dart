abstract class EventReporter {
  const EventReporter();
  Future<void> reportEvent(String eventName);

  static const HOME_SCREEN_VIEWED = "home_screen";
  static const ADD_RECIPE_SCREEN_VIEWED = "add_recipe_screen";
  static const DETAILS_RECIPE_SCREEN_VIEWED = "details_recipe_screen";
  static const EDIT_RECIPE_SCREEN_VIEWED = "edit_recipe_screen";
  static const SETTINGS_SCREEN_VIEWED = "settings_screen";
}