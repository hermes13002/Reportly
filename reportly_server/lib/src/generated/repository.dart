/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

abstract class Repository
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Repository._({
    this.id,
    required this.companyId,
    required this.provider,
    required this.repoName,
    required this.branch,
    this.prefixRules,
    this.excludePatterns,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Repository({
    int? id,
    required int companyId,
    required String provider,
    required String repoName,
    required String branch,
    String? prefixRules,
    String? excludePatterns,
    required bool isActive,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _RepositoryImpl;

  factory Repository.fromJson(Map<String, dynamic> jsonSerialization) {
    return Repository(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      provider: jsonSerialization['provider'] as String,
      repoName: jsonSerialization['repoName'] as String,
      branch: jsonSerialization['branch'] as String,
      prefixRules: jsonSerialization['prefixRules'] as String?,
      excludePatterns: jsonSerialization['excludePatterns'] as String?,
      isActive: jsonSerialization['isActive'] as bool,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = RepositoryTable();

  static const db = RepositoryRepository._();

  @override
  int? id;

  int companyId;

  String provider;

  String repoName;

  String branch;

  String? prefixRules;

  String? excludePatterns;

  bool isActive;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Repository]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Repository copyWith({
    int? id,
    int? companyId,
    String? provider,
    String? repoName,
    String? branch,
    String? prefixRules,
    String? excludePatterns,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Repository',
      if (id != null) 'id': id,
      'companyId': companyId,
      'provider': provider,
      'repoName': repoName,
      'branch': branch,
      if (prefixRules != null) 'prefixRules': prefixRules,
      if (excludePatterns != null) 'excludePatterns': excludePatterns,
      'isActive': isActive,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Repository',
      if (id != null) 'id': id,
      'companyId': companyId,
      'provider': provider,
      'repoName': repoName,
      'branch': branch,
      if (prefixRules != null) 'prefixRules': prefixRules,
      if (excludePatterns != null) 'excludePatterns': excludePatterns,
      'isActive': isActive,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static RepositoryInclude include() {
    return RepositoryInclude._();
  }

  static RepositoryIncludeList includeList({
    _i1.WhereExpressionBuilder<RepositoryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RepositoryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RepositoryTable>? orderByList,
    RepositoryInclude? include,
  }) {
    return RepositoryIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Repository.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Repository.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RepositoryImpl extends Repository {
  _RepositoryImpl({
    int? id,
    required int companyId,
    required String provider,
    required String repoName,
    required String branch,
    String? prefixRules,
    String? excludePatterns,
    required bool isActive,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         companyId: companyId,
         provider: provider,
         repoName: repoName,
         branch: branch,
         prefixRules: prefixRules,
         excludePatterns: excludePatterns,
         isActive: isActive,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Repository]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Repository copyWith({
    Object? id = _Undefined,
    int? companyId,
    String? provider,
    String? repoName,
    String? branch,
    Object? prefixRules = _Undefined,
    Object? excludePatterns = _Undefined,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Repository(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      provider: provider ?? this.provider,
      repoName: repoName ?? this.repoName,
      branch: branch ?? this.branch,
      prefixRules: prefixRules is String? ? prefixRules : this.prefixRules,
      excludePatterns: excludePatterns is String?
          ? excludePatterns
          : this.excludePatterns,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class RepositoryUpdateTable extends _i1.UpdateTable<RepositoryTable> {
  RepositoryUpdateTable(super.table);

  _i1.ColumnValue<int, int> companyId(int value) => _i1.ColumnValue(
    table.companyId,
    value,
  );

  _i1.ColumnValue<String, String> provider(String value) => _i1.ColumnValue(
    table.provider,
    value,
  );

  _i1.ColumnValue<String, String> repoName(String value) => _i1.ColumnValue(
    table.repoName,
    value,
  );

  _i1.ColumnValue<String, String> branch(String value) => _i1.ColumnValue(
    table.branch,
    value,
  );

  _i1.ColumnValue<String, String> prefixRules(String? value) => _i1.ColumnValue(
    table.prefixRules,
    value,
  );

  _i1.ColumnValue<String, String> excludePatterns(String? value) =>
      _i1.ColumnValue(
        table.excludePatterns,
        value,
      );

  _i1.ColumnValue<bool, bool> isActive(bool value) => _i1.ColumnValue(
    table.isActive,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );
}

class RepositoryTable extends _i1.Table<int?> {
  RepositoryTable({super.tableRelation}) : super(tableName: 'repository') {
    updateTable = RepositoryUpdateTable(this);
    companyId = _i1.ColumnInt(
      'companyId',
      this,
    );
    provider = _i1.ColumnString(
      'provider',
      this,
    );
    repoName = _i1.ColumnString(
      'repoName',
      this,
    );
    branch = _i1.ColumnString(
      'branch',
      this,
    );
    prefixRules = _i1.ColumnString(
      'prefixRules',
      this,
    );
    excludePatterns = _i1.ColumnString(
      'excludePatterns',
      this,
    );
    isActive = _i1.ColumnBool(
      'isActive',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final RepositoryUpdateTable updateTable;

  late final _i1.ColumnInt companyId;

  late final _i1.ColumnString provider;

  late final _i1.ColumnString repoName;

  late final _i1.ColumnString branch;

  late final _i1.ColumnString prefixRules;

  late final _i1.ColumnString excludePatterns;

  late final _i1.ColumnBool isActive;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    companyId,
    provider,
    repoName,
    branch,
    prefixRules,
    excludePatterns,
    isActive,
    createdAt,
    updatedAt,
  ];
}

class RepositoryInclude extends _i1.IncludeObject {
  RepositoryInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Repository.t;
}

class RepositoryIncludeList extends _i1.IncludeList {
  RepositoryIncludeList._({
    _i1.WhereExpressionBuilder<RepositoryTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Repository.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Repository.t;
}

class RepositoryRepository {
  const RepositoryRepository._();

  /// Returns a list of [Repository]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<Repository>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RepositoryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RepositoryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RepositoryTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Repository>(
      where: where?.call(Repository.t),
      orderBy: orderBy?.call(Repository.t),
      orderByList: orderByList?.call(Repository.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Repository] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<Repository?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RepositoryTable>? where,
    int? offset,
    _i1.OrderByBuilder<RepositoryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RepositoryTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Repository>(
      where: where?.call(Repository.t),
      orderBy: orderBy?.call(Repository.t),
      orderByList: orderByList?.call(Repository.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Repository] by its [id] or null if no such row exists.
  Future<Repository?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Repository>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Repository]s in the list and returns the inserted rows.
  ///
  /// The returned [Repository]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Repository>> insert(
    _i1.Session session,
    List<Repository> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Repository>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Repository] and returns the inserted row.
  ///
  /// The returned [Repository] will have its `id` field set.
  Future<Repository> insertRow(
    _i1.Session session,
    Repository row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Repository>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Repository]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Repository>> update(
    _i1.Session session,
    List<Repository> rows, {
    _i1.ColumnSelections<RepositoryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Repository>(
      rows,
      columns: columns?.call(Repository.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Repository]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Repository> updateRow(
    _i1.Session session,
    Repository row, {
    _i1.ColumnSelections<RepositoryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Repository>(
      row,
      columns: columns?.call(Repository.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Repository] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Repository?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<RepositoryUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Repository>(
      id,
      columnValues: columnValues(Repository.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Repository]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Repository>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<RepositoryUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<RepositoryTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RepositoryTable>? orderBy,
    _i1.OrderByListBuilder<RepositoryTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Repository>(
      columnValues: columnValues(Repository.t.updateTable),
      where: where(Repository.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Repository.t),
      orderByList: orderByList?.call(Repository.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Repository]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Repository>> delete(
    _i1.Session session,
    List<Repository> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Repository>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Repository].
  Future<Repository> deleteRow(
    _i1.Session session,
    Repository row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Repository>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Repository>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<RepositoryTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Repository>(
      where: where(Repository.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RepositoryTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Repository>(
      where: where?.call(Repository.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
