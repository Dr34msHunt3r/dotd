// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_drift_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class RecipeMoor extends DataClass implements Insertable<RecipeMoor> {
  final String id;
  final String recipeTitle;
  final String recipeRecipe;
  final String imageUrl;
  final String favourite;
  RecipeMoor(
      {required this.id,
      required this.recipeTitle,
      required this.recipeRecipe,
      required this.imageUrl,
      required this.favourite});
  factory RecipeMoor.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return RecipeMoor(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      recipeTitle: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}recipe_title'])!,
      recipeRecipe: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}recipe_recipe'])!,
      imageUrl: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}image_url'])!,
      favourite: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}favourite'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['recipe_title'] = Variable<String>(recipeTitle);
    map['recipe_recipe'] = Variable<String>(recipeRecipe);
    map['image_url'] = Variable<String>(imageUrl);
    map['favourite'] = Variable<String>(favourite);
    return map;
  }

  RecipesMoorCompanion toCompanion(bool nullToAbsent) {
    return RecipesMoorCompanion(
      id: Value(id),
      recipeTitle: Value(recipeTitle),
      recipeRecipe: Value(recipeRecipe),
      imageUrl: Value(imageUrl),
      favourite: Value(favourite),
    );
  }

  factory RecipeMoor.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecipeMoor(
      id: serializer.fromJson<String>(json['id']),
      recipeTitle: serializer.fromJson<String>(json['recipeTitle']),
      recipeRecipe: serializer.fromJson<String>(json['recipeRecipe']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      favourite: serializer.fromJson<String>(json['favourite']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'recipeTitle': serializer.toJson<String>(recipeTitle),
      'recipeRecipe': serializer.toJson<String>(recipeRecipe),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'favourite': serializer.toJson<String>(favourite),
    };
  }

  RecipeMoor copyWith(
          {String? id,
          String? recipeTitle,
          String? recipeRecipe,
          String? imageUrl,
          String? favourite}) =>
      RecipeMoor(
        id: id ?? this.id,
        recipeTitle: recipeTitle ?? this.recipeTitle,
        recipeRecipe: recipeRecipe ?? this.recipeRecipe,
        imageUrl: imageUrl ?? this.imageUrl,
        favourite: favourite ?? this.favourite,
      );
  @override
  String toString() {
    return (StringBuffer('RecipeMoor(')
          ..write('id: $id, ')
          ..write('recipeTitle: $recipeTitle, ')
          ..write('recipeRecipe: $recipeRecipe, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('favourite: $favourite')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, recipeTitle, recipeRecipe, imageUrl, favourite);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecipeMoor &&
          other.id == this.id &&
          other.recipeTitle == this.recipeTitle &&
          other.recipeRecipe == this.recipeRecipe &&
          other.imageUrl == this.imageUrl &&
          other.favourite == this.favourite);
}

class RecipesMoorCompanion extends UpdateCompanion<RecipeMoor> {
  final Value<String> id;
  final Value<String> recipeTitle;
  final Value<String> recipeRecipe;
  final Value<String> imageUrl;
  final Value<String> favourite;
  const RecipesMoorCompanion({
    this.id = const Value.absent(),
    this.recipeTitle = const Value.absent(),
    this.recipeRecipe = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.favourite = const Value.absent(),
  });
  RecipesMoorCompanion.insert({
    this.id = const Value.absent(),
    required String recipeTitle,
    required String recipeRecipe,
    required String imageUrl,
    required String favourite,
  })  : recipeTitle = Value(recipeTitle),
        recipeRecipe = Value(recipeRecipe),
        imageUrl = Value(imageUrl),
        favourite = Value(favourite);
  static Insertable<RecipeMoor> custom({
    Expression<String>? id,
    Expression<String>? recipeTitle,
    Expression<String>? recipeRecipe,
    Expression<String>? imageUrl,
    Expression<String>? favourite,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (recipeTitle != null) 'recipe_title': recipeTitle,
      if (recipeRecipe != null) 'recipe_recipe': recipeRecipe,
      if (imageUrl != null) 'image_url': imageUrl,
      if (favourite != null) 'favourite': favourite,
    });
  }

  RecipesMoorCompanion copyWith(
      {Value<String>? id,
      Value<String>? recipeTitle,
      Value<String>? recipeRecipe,
      Value<String>? imageUrl,
      Value<String>? favourite}) {
    return RecipesMoorCompanion(
      id: id ?? this.id,
      recipeTitle: recipeTitle ?? this.recipeTitle,
      recipeRecipe: recipeRecipe ?? this.recipeRecipe,
      imageUrl: imageUrl ?? this.imageUrl,
      favourite: favourite ?? this.favourite,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (recipeTitle.present) {
      map['recipe_title'] = Variable<String>(recipeTitle.value);
    }
    if (recipeRecipe.present) {
      map['recipe_recipe'] = Variable<String>(recipeRecipe.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (favourite.present) {
      map['favourite'] = Variable<String>(favourite.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecipesMoorCompanion(')
          ..write('id: $id, ')
          ..write('recipeTitle: $recipeTitle, ')
          ..write('recipeRecipe: $recipeRecipe, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('favourite: $favourite')
          ..write(')'))
        .toString();
  }
}

class $RecipesMoorTable extends RecipesMoor
    with TableInfo<$RecipesMoorTable, RecipeMoor> {
  final GeneratedDatabase _db;
  final String? _alias;
  $RecipesMoorTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      clientDefault: () => _uuid.v4());
  final VerificationMeta _recipeTitleMeta =
      const VerificationMeta('recipeTitle');
  @override
  late final GeneratedColumn<String?> recipeTitle = GeneratedColumn<String?>(
      'recipe_title', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _recipeRecipeMeta =
      const VerificationMeta('recipeRecipe');
  @override
  late final GeneratedColumn<String?> recipeRecipe = GeneratedColumn<String?>(
      'recipe_recipe', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _imageUrlMeta = const VerificationMeta('imageUrl');
  @override
  late final GeneratedColumn<String?> imageUrl = GeneratedColumn<String?>(
      'image_url', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _favouriteMeta = const VerificationMeta('favourite');
  @override
  late final GeneratedColumn<String?> favourite = GeneratedColumn<String?>(
      'favourite', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, recipeTitle, recipeRecipe, imageUrl, favourite];
  @override
  String get aliasedName => _alias ?? 'recipes_moor';
  @override
  String get actualTableName => 'recipes_moor';
  @override
  VerificationContext validateIntegrity(Insertable<RecipeMoor> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('recipe_title')) {
      context.handle(
          _recipeTitleMeta,
          recipeTitle.isAcceptableOrUnknown(
              data['recipe_title']!, _recipeTitleMeta));
    } else if (isInserting) {
      context.missing(_recipeTitleMeta);
    }
    if (data.containsKey('recipe_recipe')) {
      context.handle(
          _recipeRecipeMeta,
          recipeRecipe.isAcceptableOrUnknown(
              data['recipe_recipe']!, _recipeRecipeMeta));
    } else if (isInserting) {
      context.missing(_recipeRecipeMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(_imageUrlMeta,
          imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta));
    } else if (isInserting) {
      context.missing(_imageUrlMeta);
    }
    if (data.containsKey('favourite')) {
      context.handle(_favouriteMeta,
          favourite.isAcceptableOrUnknown(data['favourite']!, _favouriteMeta));
    } else if (isInserting) {
      context.missing(_favouriteMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecipeMoor map(Map<String, dynamic> data, {String? tablePrefix}) {
    return RecipeMoor.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $RecipesMoorTable createAlias(String alias) {
    return $RecipesMoorTable(_db, alias);
  }
}

class IngredientMoor extends DataClass implements Insertable<IngredientMoor> {
  final String id;
  final String recipeMoorId;
  final String name;
  IngredientMoor(
      {required this.id, required this.recipeMoorId, required this.name});
  factory IngredientMoor.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return IngredientMoor(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      recipeMoorId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}recipe_moor_id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['recipe_moor_id'] = Variable<String>(recipeMoorId);
    map['name'] = Variable<String>(name);
    return map;
  }

  IngredientsMoorCompanion toCompanion(bool nullToAbsent) {
    return IngredientsMoorCompanion(
      id: Value(id),
      recipeMoorId: Value(recipeMoorId),
      name: Value(name),
    );
  }

  factory IngredientMoor.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return IngredientMoor(
      id: serializer.fromJson<String>(json['id']),
      recipeMoorId: serializer.fromJson<String>(json['recipeMoorId']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'recipeMoorId': serializer.toJson<String>(recipeMoorId),
      'name': serializer.toJson<String>(name),
    };
  }

  IngredientMoor copyWith({String? id, String? recipeMoorId, String? name}) =>
      IngredientMoor(
        id: id ?? this.id,
        recipeMoorId: recipeMoorId ?? this.recipeMoorId,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('IngredientMoor(')
          ..write('id: $id, ')
          ..write('recipeMoorId: $recipeMoorId, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, recipeMoorId, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IngredientMoor &&
          other.id == this.id &&
          other.recipeMoorId == this.recipeMoorId &&
          other.name == this.name);
}

class IngredientsMoorCompanion extends UpdateCompanion<IngredientMoor> {
  final Value<String> id;
  final Value<String> recipeMoorId;
  final Value<String> name;
  const IngredientsMoorCompanion({
    this.id = const Value.absent(),
    this.recipeMoorId = const Value.absent(),
    this.name = const Value.absent(),
  });
  IngredientsMoorCompanion.insert({
    this.id = const Value.absent(),
    required String recipeMoorId,
    required String name,
  })  : recipeMoorId = Value(recipeMoorId),
        name = Value(name);
  static Insertable<IngredientMoor> custom({
    Expression<String>? id,
    Expression<String>? recipeMoorId,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (recipeMoorId != null) 'recipe_moor_id': recipeMoorId,
      if (name != null) 'name': name,
    });
  }

  IngredientsMoorCompanion copyWith(
      {Value<String>? id, Value<String>? recipeMoorId, Value<String>? name}) {
    return IngredientsMoorCompanion(
      id: id ?? this.id,
      recipeMoorId: recipeMoorId ?? this.recipeMoorId,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (recipeMoorId.present) {
      map['recipe_moor_id'] = Variable<String>(recipeMoorId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IngredientsMoorCompanion(')
          ..write('id: $id, ')
          ..write('recipeMoorId: $recipeMoorId, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $IngredientsMoorTable extends IngredientsMoor
    with TableInfo<$IngredientsMoorTable, IngredientMoor> {
  final GeneratedDatabase _db;
  final String? _alias;
  $IngredientsMoorTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      clientDefault: () => _uuid.v4());
  final VerificationMeta _recipeMoorIdMeta =
      const VerificationMeta('recipeMoorId');
  @override
  late final GeneratedColumn<String?> recipeMoorId = GeneratedColumn<String?>(
      'recipe_moor_id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: const StringType(),
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, recipeMoorId, name];
  @override
  String get aliasedName => _alias ?? 'ingredients_moor';
  @override
  String get actualTableName => 'ingredients_moor';
  @override
  VerificationContext validateIntegrity(Insertable<IngredientMoor> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('recipe_moor_id')) {
      context.handle(
          _recipeMoorIdMeta,
          recipeMoorId.isAcceptableOrUnknown(
              data['recipe_moor_id']!, _recipeMoorIdMeta));
    } else if (isInserting) {
      context.missing(_recipeMoorIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  IngredientMoor map(Map<String, dynamic> data, {String? tablePrefix}) {
    return IngredientMoor.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $IngredientsMoorTable createAlias(String alias) {
    return $IngredientsMoorTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $RecipesMoorTable recipesMoor = $RecipesMoorTable(this);
  late final $IngredientsMoorTable ingredientsMoor =
      $IngredientsMoorTable(this);
  late final RecipeMoorDao recipeMoorDao = RecipeMoorDao(this as AppDatabase);
  late final IngredientMoorDao ingredientMoorDao =
      IngredientMoorDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [recipesMoor, ingredientsMoor];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$IngredientMoorDaoMixin on DatabaseAccessor<AppDatabase> {
  $IngredientsMoorTable get ingredientsMoor => attachedDatabase.ingredientsMoor;
}
mixin _$RecipeMoorDaoMixin on DatabaseAccessor<AppDatabase> {
  $RecipesMoorTable get recipesMoor => attachedDatabase.recipesMoor;
}
