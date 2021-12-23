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
    tables: [RecipesMoor]
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<RecipeMoor>> getAllRecipes() => select(recipesMoor).get();
  Stream<List<RecipeMoor>> watchAllRecipes() => select(recipesMoor).watch();
  Future insertRecipe(RecipesMoorCompanion recipe) => into(recipesMoor).insert(recipe);
  Future updateRecipe(RecipeMoor recipe) => update(recipesMoor).replace(recipe);
  Future deleteRecipe(RecipeMoor recipe) => delete(recipesMoor).delete(recipe);

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
