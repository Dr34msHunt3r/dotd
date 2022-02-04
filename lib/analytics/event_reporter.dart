abstract class EventReporter {
  const EventReporter();
  Future<void> reportEvent(String eventName);
  Future<void> reportScreenView(String screenName);

  /// Screens
  static const HOME_SCREEN_VIEWED = "home_screen";
  static const ADD_RECIPE_SCREEN_VIEWED = "add_recipe_screen";
  static const DETAILS_RECIPE_SCREEN_VIEWED = "details_recipe_screen";
  static const EDIT_RECIPE_SCREEN_VIEWED = "edit_recipe_screen";
  static const SETTINGS_SCREEN_VIEWED = "settings_screen";
  static const RANDOM_MEAL_SCREEN_VIEWED = "random_meal_screen";

  /// Events
  static const LOADED_RECIPES_EMPTY_LIST = "loaded_empty_recipes_list";
  static const LOADED_RECIPES_FILLED_LIST = "loaded_filled_recipes_list";
  static const ADDED_NEW_RECIPE = "added_new_recipe";
  static const UPDATED_RECIPE = "updated_recipe";
  static const DELETED_RECIPE = "deleted_recipe";
  static const RECIPES_LIST_NOT_EMPTY_AFTER_DELETE = "recipes_list_not_empty_after_delete";
  static const RECIPES_LIST_EMPTY_AFTER_DELETE = "recipes_list_empty_after_delete";
}