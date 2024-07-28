// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorMovieDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$MovieDatabaseBuilder databaseBuilder(String name) =>
      _$MovieDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$MovieDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$MovieDatabaseBuilder(null);
}

class _$MovieDatabaseBuilder {
  _$MovieDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$MovieDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$MovieDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<MovieDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$MovieDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$MovieDatabase extends MovieDatabase {
  _$MovieDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  CastDao? _castDaoInstance;

  MovieDao? _movieDaoInstance;

  GenreDao? _genreDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `Movie` (`id` INTEGER NOT NULL, `title` TEXT NOT NULL, `posterName` TEXT NOT NULL, `backdropName` TEXT NOT NULL, `releaseDate` TEXT NOT NULL, `genres` TEXT NOT NULL, `overview` TEXT NOT NULL, `score` REAL NOT NULL, `saved` INTEGER NOT NULL, `liked` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Genre` (`id` INTEGER NOT NULL, `name` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `MovieCast` (`id` INTEGER NOT NULL, `profilePath` TEXT NOT NULL, `movieId` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `MovieCategory` (`category` INTEGER NOT NULL, `movieId` INTEGER NOT NULL, `page` INTEGER NOT NULL, PRIMARY KEY (`category`, `movieId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `MovieGenre` (`genreId` INTEGER NOT NULL, `movieId` INTEGER NOT NULL, PRIMARY KEY (`genreId`, `movieId`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  CastDao get castDao {
    return _castDaoInstance ??= _$CastDao(database, changeListener);
  }

  @override
  MovieDao get movieDao {
    return _movieDaoInstance ??= _$MovieDao(database, changeListener);
  }

  @override
  GenreDao get genreDao {
    return _genreDaoInstance ??= _$GenreDao(database, changeListener);
  }
}

class _$CastDao extends CastDao {
  _$CastDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _castInsertionAdapter = InsertionAdapter(
            database,
            'MovieCast',
            (Cast item) => <String, Object?>{
                  'id': item.id,
                  'profilePath': item.profilePath,
                  'movieId': item.movieId
                }),
        _castUpdateAdapter = UpdateAdapter(
            database,
            'MovieCast',
            ['id'],
            (Cast item) => <String, Object?>{
                  'id': item.id,
                  'profilePath': item.profilePath,
                  'movieId': item.movieId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Cast> _castInsertionAdapter;

  final UpdateAdapter<Cast> _castUpdateAdapter;

  @override
  Future<List<Cast>> getCastByMovie(int movieId) async {
    return _queryAdapter.queryList('SELECT * FROM MovieCast WHERE movieId = ?1',
        mapper: (Map<String, Object?> row) => Cast(
            id: row['id'] as int,
            profilePath: row['profilePath'] as String,
            movieId: row['movieId'] as int),
        arguments: [movieId]);
  }

  @override
  Future<void> insertCast(List<Cast> cast) async {
    await _castInsertionAdapter.insertList(cast, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateCast(Cast cast) async {
    await _castUpdateAdapter.update(cast, OnConflictStrategy.replace);
  }
}

class _$MovieDao extends MovieDao {
  _$MovieDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _movieInsertionAdapter = InsertionAdapter(
            database,
            'Movie',
            (Movie item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'posterName': item.posterName,
                  'backdropName': item.backdropName,
                  'releaseDate': item.releaseDate,
                  'genres': _genresListConverter.encode(item.genres),
                  'overview': item.overview,
                  'score': item.score,
                  'saved': item.saved ? 1 : 0,
                  'liked': item.liked ? 1 : 0
                }),
        _movieCategoryInsertionAdapter = InsertionAdapter(
            database,
            'MovieCategory',
            (MovieCategory item) => <String, Object?>{
                  'category': item.category.index,
                  'movieId': item.movieId,
                  'page': item.page
                }),
        _movieUpdateAdapter = UpdateAdapter(
            database,
            'Movie',
            ['id'],
            (Movie item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'posterName': item.posterName,
                  'backdropName': item.backdropName,
                  'releaseDate': item.releaseDate,
                  'genres': _genresListConverter.encode(item.genres),
                  'overview': item.overview,
                  'score': item.score,
                  'saved': item.saved ? 1 : 0,
                  'liked': item.liked ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Movie> _movieInsertionAdapter;

  final InsertionAdapter<MovieCategory> _movieCategoryInsertionAdapter;

  final UpdateAdapter<Movie> _movieUpdateAdapter;

  @override
  Future<List<Movie>> findAllMovies() async {
    return _queryAdapter.queryList('SELECT * FROM Movie',
        mapper: (Map<String, Object?> row) => Movie(
            id: row['id'] as int,
            title: row['title'] as String,
            posterName: row['posterName'] as String,
            backdropName: row['backdropName'] as String,
            releaseDate: row['releaseDate'] as String,
            score: row['score'] as double,
            genres: _genresListConverter.decode(row['genres'] as String),
            overview: row['overview'] as String,
            saved: (row['saved'] as int) != 0,
            liked: (row['liked'] as int) != 0));
  }

  @override
  Future<Movie?> findMovieById(int id) async {
    return _queryAdapter.query('SELECT * FROM Movie WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Movie(
            id: row['id'] as int,
            title: row['title'] as String,
            posterName: row['posterName'] as String,
            backdropName: row['backdropName'] as String,
            releaseDate: row['releaseDate'] as String,
            score: row['score'] as double,
            genres: _genresListConverter.decode(row['genres'] as String),
            overview: row['overview'] as String,
            saved: (row['saved'] as int) != 0,
            liked: (row['liked'] as int) != 0),
        arguments: [id]);
  }

  @override
  Future<List<Movie>> findMovieByType(
    Endpoint type,
    int page,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Movie m WHERE EXISTS( SELECT 1 FROM MovieCategory c WHERE m.id = c.movieId AND c.category = ?1 AND c.page = ?2)',
        mapper: (Map<String, Object?> row) => Movie(id: row['id'] as int, title: row['title'] as String, posterName: row['posterName'] as String, backdropName: row['backdropName'] as String, releaseDate: row['releaseDate'] as String, score: row['score'] as double, genres: _genresListConverter.decode(row['genres'] as String), overview: row['overview'] as String, saved: (row['saved'] as int) != 0, liked: (row['liked'] as int) != 0),
        arguments: [type.index, page]);
  }

  @override
  Future<List<Movie>> findSavedMovies() async {
    return _queryAdapter.queryList('SELECT * FROM Movie WHERE saved = true',
        mapper: (Map<String, Object?> row) => Movie(
            id: row['id'] as int,
            title: row['title'] as String,
            posterName: row['posterName'] as String,
            backdropName: row['backdropName'] as String,
            releaseDate: row['releaseDate'] as String,
            score: row['score'] as double,
            genres: _genresListConverter.decode(row['genres'] as String),
            overview: row['overview'] as String,
            saved: (row['saved'] as int) != 0,
            liked: (row['liked'] as int) != 0));
  }

  @override
  Future<List<Movie>> findLikedMovies() async {
    return _queryAdapter.queryList('SELECT * FROM Movie WHERE liked = true',
        mapper: (Map<String, Object?> row) => Movie(
            id: row['id'] as int,
            title: row['title'] as String,
            posterName: row['posterName'] as String,
            backdropName: row['backdropName'] as String,
            releaseDate: row['releaseDate'] as String,
            score: row['score'] as double,
            genres: _genresListConverter.decode(row['genres'] as String),
            overview: row['overview'] as String,
            saved: (row['saved'] as int) != 0,
            liked: (row['liked'] as int) != 0));
  }

  @override
  Future<void> insertMovie(Movie movie) async {
    await _movieInsertionAdapter.insert(movie, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertMovieCategory(MovieCategory movieCategory) async {
    await _movieCategoryInsertionAdapter.insert(
        movieCategory, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateMovie(Movie movie) async {
    await _movieUpdateAdapter.update(movie, OnConflictStrategy.replace);
  }
}

class _$GenreDao extends GenreDao {
  _$GenreDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _genreInsertionAdapter = InsertionAdapter(
            database,
            'Genre',
            (Genre item) =>
                <String, Object?>{'id': item.id, 'name': item.name}),
        _movieGenreInsertionAdapter = InsertionAdapter(
            database,
            'MovieGenre',
            (MovieGenre item) => <String, Object?>{
                  'genreId': item.genreId,
                  'movieId': item.movieId
                }),
        _genreUpdateAdapter = UpdateAdapter(
            database,
            'Genre',
            ['id'],
            (Genre item) =>
                <String, Object?>{'id': item.id, 'name': item.name});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Genre> _genreInsertionAdapter;

  final InsertionAdapter<MovieGenre> _movieGenreInsertionAdapter;

  final UpdateAdapter<Genre> _genreUpdateAdapter;

  @override
  Future<List<Genre>> getAllGenres() async {
    return _queryAdapter.queryList('SELECT * FROM Genre',
        mapper: (Map<String, Object?> row) =>
            Genre(id: row['id'] as int, name: row['name'] as String));
  }

  @override
  Future<List<Genre>> getGenreByMovie(int movieId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Genre g WHERE EXISTS( SELECT 1 FROM MovieGenre m WHERE m.genreId = g.id AND m.movieId = ?1 )',
        mapper: (Map<String, Object?> row) => Genre(id: row['id'] as int, name: row['name'] as String),
        arguments: [movieId]);
  }

  @override
  Future<void> insertGenre(Genre genre) async {
    await _genreInsertionAdapter.insert(genre, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertMovieGenre(MovieGenre movieGenre) async {
    await _movieGenreInsertionAdapter.insert(
        movieGenre, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateGenre(Genre genre) async {
    await _genreUpdateAdapter.update(genre, OnConflictStrategy.replace);
  }
}

// ignore_for_file: unused_element
final _genresListConverter = GenresListConverter();
