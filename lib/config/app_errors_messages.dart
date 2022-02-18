class AppErrorMessages {

  dynamic loadingRecipesError(dynamic error){
    return throw Exception('Loading recipes failed: ${error}');
  }

  dynamic addingRecipeError(dynamic error){
    return throw Exception('Adding recipe failed: ${error}');
  }

  dynamic updatingRecipeError(dynamic error){
    return throw Exception('Updating recipe failed: ${error}');
  }

  dynamic deletingRecipeError(dynamic error){
    return throw Exception('Deleting recipe failed: ${error}');
  }
}