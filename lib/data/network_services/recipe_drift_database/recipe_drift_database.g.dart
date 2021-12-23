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

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $RecipesMoorTable recipesMoor = $RecipesMoorTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [recipesMoor];
}
