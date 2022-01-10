import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';
import 'package:uuid/uuid.dart';

part 'recipe_drift_database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file, logStatements: true);
  });
}

@DriftDatabase(
    tables: [RecipesMoor, IngredientsMoor], daos: [RecipeMoorDao, IngredientMoorDao]
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

@DriftAccessor(
    tables: [IngredientsMoor]
)
class IngredientMoorDao extends DatabaseAccessor<AppDatabase> with _$IngredientMoorDaoMixin{
  final AppDatabase db;
  IngredientMoorDao(this.db) : super(db);

  Future<List<IngredientMoor>> getAllIngredients() => select(ingredientsMoor).get();
  Future updateIngredient(IngredientMoor ingredient) => update(ingredientsMoor).replace(ingredient);
  Future deleteIngredient(IngredientMoor ingredient) => delete(ingredientsMoor).delete(ingredient);

  Future deleteIngredientsWhereRecipeId(String id) {
    return  (delete(ingredientsMoor)..where((t) => t.recipeMoorId.equals(id))).go();
  }

}

@DriftAccessor(
  tables: [RecipesMoor]
)
class RecipeMoorDao extends DatabaseAccessor<AppDatabase> with _$RecipeMoorDaoMixin{
  final AppDatabase db;
  RecipeMoorDao(this.db) : super(db);

  Future<List<RecipeMoor>> getAllRecipes() => select(recipesMoor).get();
  Stream<List<RecipeMoor>> watchAllRecipes() => select(recipesMoor).watch();
  Future insertRecipe(Insertable<RecipeMoor> recipe) => into(recipesMoor).insertReturning(recipe);
  Future updateRecipe(RecipeMoor recipe) => update(recipesMoor).replace(recipe);
  Future deleteRecipe(RecipeMoor recipe) => delete(recipesMoor).delete(recipe);
  Future deleteRecipeWhereId(String id) {
    return (delete(recipesMoor)..where((t) => t.id.equals(id))).go();
  }
}

@DataClassName('RecipeMoor')
class RecipesMoor extends Table {

  var _uuid = Uuid();

  TextColumn get id => text().clientDefault(() => _uuid.v4())();
  TextColumn get recipeTitle => text().withLength(min: 1, max: 50)();
  TextColumn get recipeRecipe => text()();
  TextColumn get imageUrl => text()();
  TextColumn get favourite => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('IngredientMoor')
class IngredientsMoor extends Table {

  var _uuid = Uuid();

  TextColumn get id => text().clientDefault(() => _uuid.v4())();
  TextColumn get recipeMoorId => text()();
  TextColumn get name => text().withLength(min: 1, max: 50)();

  @override
  Set<Column> get primaryKey => {id};

}
