// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  FormDataModelDaoApartamento? _formDataModelDaoApartamentoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Apartamento` (`idDepartamento` INTEGER PRIMARY KEY AUTOINCREMENT, `ubigeo` TEXT, `descripcion` TEXT, `amenidades` TEXT, `caracteristicas` TEXT, `precio` TEXT, `area` TEXT, `imagen` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  FormDataModelDaoApartamento get formDataModelDaoApartamento {
    return _formDataModelDaoApartamentoInstance ??=
        _$FormDataModelDaoApartamento(database, changeListener);
  }
}

class _$FormDataModelDaoApartamento extends FormDataModelDaoApartamento {
  _$FormDataModelDaoApartamento(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _apartamentoInsertionAdapter = InsertionAdapter(
            database,
            'Apartamento',
            (Apartamento item) => <String, Object?>{
                  'idDepartamento': item.idDepartamento,
                  'ubigeo': item.ubigeo,
                  'descripcion': item.descripcion,
                  'amenidades': item.amenidades,
                  'caracteristicas': item.caracteristicas,
                  'precio': item.precio,
                  'area': item.area,
                  'imagen': item.imagen
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Apartamento> _apartamentoInsertionAdapter;

  @override
  Future<List<Apartamento>> findFormDataModel() async {
    return _queryAdapter.queryList('SELECT * FROM Apartamento',
        mapper: (Map<String, Object?> row) => Apartamento(
            idDepartamento: row['idDepartamento'] as int?,
            ubigeo: row['ubigeo'] as String?,
            descripcion: row['descripcion'] as String?,
            amenidades: row['amenidades'] as String?,
            caracteristicas: row['caracteristicas'] as String?,
            precio: row['precio'] as String?,
            area: row['area'] as String?,
            imagen: row['imagen'] as String?));
  }

  @override
  Future<int?> BorrarTodo() async {
    return _queryAdapter.query('DELETE * FROM Apartamento',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<void> insertFormDataModelApartamento(Apartamento formDataModel) async {
    await _apartamentoInsertionAdapter.insert(
        formDataModel, OnConflictStrategy.replace);
  }
}
