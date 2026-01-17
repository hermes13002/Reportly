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

abstract class ScheduleConfig
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ScheduleConfig._({
    this.id,
    required this.companyId,
    required this.frequency,
    this.customDays,
    this.dayOfWeek,
    this.dayOfMonth,
    required this.hourOfDay,
    required this.minuteOfHour,
    required this.isEnabled,
    this.lastRunAt,
    this.nextRunAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ScheduleConfig({
    int? id,
    required int companyId,
    required String frequency,
    int? customDays,
    int? dayOfWeek,
    int? dayOfMonth,
    required int hourOfDay,
    required int minuteOfHour,
    required bool isEnabled,
    DateTime? lastRunAt,
    DateTime? nextRunAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ScheduleConfigImpl;

  factory ScheduleConfig.fromJson(Map<String, dynamic> jsonSerialization) {
    return ScheduleConfig(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      frequency: jsonSerialization['frequency'] as String,
      customDays: jsonSerialization['customDays'] as int?,
      dayOfWeek: jsonSerialization['dayOfWeek'] as int?,
      dayOfMonth: jsonSerialization['dayOfMonth'] as int?,
      hourOfDay: jsonSerialization['hourOfDay'] as int,
      minuteOfHour: jsonSerialization['minuteOfHour'] as int,
      isEnabled: jsonSerialization['isEnabled'] as bool,
      lastRunAt: jsonSerialization['lastRunAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['lastRunAt']),
      nextRunAt: jsonSerialization['nextRunAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['nextRunAt']),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = ScheduleConfigTable();

  static const db = ScheduleConfigRepository._();

  @override
  int? id;

  int companyId;

  String frequency;

  int? customDays;

  int? dayOfWeek;

  int? dayOfMonth;

  int hourOfDay;

  int minuteOfHour;

  bool isEnabled;

  DateTime? lastRunAt;

  DateTime? nextRunAt;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ScheduleConfig]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ScheduleConfig copyWith({
    int? id,
    int? companyId,
    String? frequency,
    int? customDays,
    int? dayOfWeek,
    int? dayOfMonth,
    int? hourOfDay,
    int? minuteOfHour,
    bool? isEnabled,
    DateTime? lastRunAt,
    DateTime? nextRunAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ScheduleConfig',
      if (id != null) 'id': id,
      'companyId': companyId,
      'frequency': frequency,
      if (customDays != null) 'customDays': customDays,
      if (dayOfWeek != null) 'dayOfWeek': dayOfWeek,
      if (dayOfMonth != null) 'dayOfMonth': dayOfMonth,
      'hourOfDay': hourOfDay,
      'minuteOfHour': minuteOfHour,
      'isEnabled': isEnabled,
      if (lastRunAt != null) 'lastRunAt': lastRunAt?.toJson(),
      if (nextRunAt != null) 'nextRunAt': nextRunAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ScheduleConfig',
      if (id != null) 'id': id,
      'companyId': companyId,
      'frequency': frequency,
      if (customDays != null) 'customDays': customDays,
      if (dayOfWeek != null) 'dayOfWeek': dayOfWeek,
      if (dayOfMonth != null) 'dayOfMonth': dayOfMonth,
      'hourOfDay': hourOfDay,
      'minuteOfHour': minuteOfHour,
      'isEnabled': isEnabled,
      if (lastRunAt != null) 'lastRunAt': lastRunAt?.toJson(),
      if (nextRunAt != null) 'nextRunAt': nextRunAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static ScheduleConfigInclude include() {
    return ScheduleConfigInclude._();
  }

  static ScheduleConfigIncludeList includeList({
    _i1.WhereExpressionBuilder<ScheduleConfigTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ScheduleConfigTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ScheduleConfigTable>? orderByList,
    ScheduleConfigInclude? include,
  }) {
    return ScheduleConfigIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ScheduleConfig.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ScheduleConfig.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ScheduleConfigImpl extends ScheduleConfig {
  _ScheduleConfigImpl({
    int? id,
    required int companyId,
    required String frequency,
    int? customDays,
    int? dayOfWeek,
    int? dayOfMonth,
    required int hourOfDay,
    required int minuteOfHour,
    required bool isEnabled,
    DateTime? lastRunAt,
    DateTime? nextRunAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         companyId: companyId,
         frequency: frequency,
         customDays: customDays,
         dayOfWeek: dayOfWeek,
         dayOfMonth: dayOfMonth,
         hourOfDay: hourOfDay,
         minuteOfHour: minuteOfHour,
         isEnabled: isEnabled,
         lastRunAt: lastRunAt,
         nextRunAt: nextRunAt,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [ScheduleConfig]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ScheduleConfig copyWith({
    Object? id = _Undefined,
    int? companyId,
    String? frequency,
    Object? customDays = _Undefined,
    Object? dayOfWeek = _Undefined,
    Object? dayOfMonth = _Undefined,
    int? hourOfDay,
    int? minuteOfHour,
    bool? isEnabled,
    Object? lastRunAt = _Undefined,
    Object? nextRunAt = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ScheduleConfig(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      frequency: frequency ?? this.frequency,
      customDays: customDays is int? ? customDays : this.customDays,
      dayOfWeek: dayOfWeek is int? ? dayOfWeek : this.dayOfWeek,
      dayOfMonth: dayOfMonth is int? ? dayOfMonth : this.dayOfMonth,
      hourOfDay: hourOfDay ?? this.hourOfDay,
      minuteOfHour: minuteOfHour ?? this.minuteOfHour,
      isEnabled: isEnabled ?? this.isEnabled,
      lastRunAt: lastRunAt is DateTime? ? lastRunAt : this.lastRunAt,
      nextRunAt: nextRunAt is DateTime? ? nextRunAt : this.nextRunAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class ScheduleConfigUpdateTable extends _i1.UpdateTable<ScheduleConfigTable> {
  ScheduleConfigUpdateTable(super.table);

  _i1.ColumnValue<int, int> companyId(int value) => _i1.ColumnValue(
    table.companyId,
    value,
  );

  _i1.ColumnValue<String, String> frequency(String value) => _i1.ColumnValue(
    table.frequency,
    value,
  );

  _i1.ColumnValue<int, int> customDays(int? value) => _i1.ColumnValue(
    table.customDays,
    value,
  );

  _i1.ColumnValue<int, int> dayOfWeek(int? value) => _i1.ColumnValue(
    table.dayOfWeek,
    value,
  );

  _i1.ColumnValue<int, int> dayOfMonth(int? value) => _i1.ColumnValue(
    table.dayOfMonth,
    value,
  );

  _i1.ColumnValue<int, int> hourOfDay(int value) => _i1.ColumnValue(
    table.hourOfDay,
    value,
  );

  _i1.ColumnValue<int, int> minuteOfHour(int value) => _i1.ColumnValue(
    table.minuteOfHour,
    value,
  );

  _i1.ColumnValue<bool, bool> isEnabled(bool value) => _i1.ColumnValue(
    table.isEnabled,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> lastRunAt(DateTime? value) =>
      _i1.ColumnValue(
        table.lastRunAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> nextRunAt(DateTime? value) =>
      _i1.ColumnValue(
        table.nextRunAt,
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

class ScheduleConfigTable extends _i1.Table<int?> {
  ScheduleConfigTable({super.tableRelation})
    : super(tableName: 'schedule_config') {
    updateTable = ScheduleConfigUpdateTable(this);
    companyId = _i1.ColumnInt(
      'companyId',
      this,
    );
    frequency = _i1.ColumnString(
      'frequency',
      this,
    );
    customDays = _i1.ColumnInt(
      'customDays',
      this,
    );
    dayOfWeek = _i1.ColumnInt(
      'dayOfWeek',
      this,
    );
    dayOfMonth = _i1.ColumnInt(
      'dayOfMonth',
      this,
    );
    hourOfDay = _i1.ColumnInt(
      'hourOfDay',
      this,
    );
    minuteOfHour = _i1.ColumnInt(
      'minuteOfHour',
      this,
    );
    isEnabled = _i1.ColumnBool(
      'isEnabled',
      this,
    );
    lastRunAt = _i1.ColumnDateTime(
      'lastRunAt',
      this,
    );
    nextRunAt = _i1.ColumnDateTime(
      'nextRunAt',
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

  late final ScheduleConfigUpdateTable updateTable;

  late final _i1.ColumnInt companyId;

  late final _i1.ColumnString frequency;

  late final _i1.ColumnInt customDays;

  late final _i1.ColumnInt dayOfWeek;

  late final _i1.ColumnInt dayOfMonth;

  late final _i1.ColumnInt hourOfDay;

  late final _i1.ColumnInt minuteOfHour;

  late final _i1.ColumnBool isEnabled;

  late final _i1.ColumnDateTime lastRunAt;

  late final _i1.ColumnDateTime nextRunAt;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    companyId,
    frequency,
    customDays,
    dayOfWeek,
    dayOfMonth,
    hourOfDay,
    minuteOfHour,
    isEnabled,
    lastRunAt,
    nextRunAt,
    createdAt,
    updatedAt,
  ];
}

class ScheduleConfigInclude extends _i1.IncludeObject {
  ScheduleConfigInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ScheduleConfig.t;
}

class ScheduleConfigIncludeList extends _i1.IncludeList {
  ScheduleConfigIncludeList._({
    _i1.WhereExpressionBuilder<ScheduleConfigTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ScheduleConfig.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ScheduleConfig.t;
}

class ScheduleConfigRepository {
  const ScheduleConfigRepository._();

  /// Returns a list of [ScheduleConfig]s matching the given query parameters.
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
  Future<List<ScheduleConfig>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ScheduleConfigTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ScheduleConfigTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ScheduleConfigTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<ScheduleConfig>(
      where: where?.call(ScheduleConfig.t),
      orderBy: orderBy?.call(ScheduleConfig.t),
      orderByList: orderByList?.call(ScheduleConfig.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [ScheduleConfig] matching the given query parameters.
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
  Future<ScheduleConfig?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ScheduleConfigTable>? where,
    int? offset,
    _i1.OrderByBuilder<ScheduleConfigTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ScheduleConfigTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<ScheduleConfig>(
      where: where?.call(ScheduleConfig.t),
      orderBy: orderBy?.call(ScheduleConfig.t),
      orderByList: orderByList?.call(ScheduleConfig.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [ScheduleConfig] by its [id] or null if no such row exists.
  Future<ScheduleConfig?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<ScheduleConfig>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [ScheduleConfig]s in the list and returns the inserted rows.
  ///
  /// The returned [ScheduleConfig]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<ScheduleConfig>> insert(
    _i1.Session session,
    List<ScheduleConfig> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ScheduleConfig>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [ScheduleConfig] and returns the inserted row.
  ///
  /// The returned [ScheduleConfig] will have its `id` field set.
  Future<ScheduleConfig> insertRow(
    _i1.Session session,
    ScheduleConfig row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ScheduleConfig>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ScheduleConfig]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ScheduleConfig>> update(
    _i1.Session session,
    List<ScheduleConfig> rows, {
    _i1.ColumnSelections<ScheduleConfigTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ScheduleConfig>(
      rows,
      columns: columns?.call(ScheduleConfig.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ScheduleConfig]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ScheduleConfig> updateRow(
    _i1.Session session,
    ScheduleConfig row, {
    _i1.ColumnSelections<ScheduleConfigTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ScheduleConfig>(
      row,
      columns: columns?.call(ScheduleConfig.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ScheduleConfig] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ScheduleConfig?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<ScheduleConfigUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ScheduleConfig>(
      id,
      columnValues: columnValues(ScheduleConfig.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ScheduleConfig]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ScheduleConfig>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<ScheduleConfigUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<ScheduleConfigTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ScheduleConfigTable>? orderBy,
    _i1.OrderByListBuilder<ScheduleConfigTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ScheduleConfig>(
      columnValues: columnValues(ScheduleConfig.t.updateTable),
      where: where(ScheduleConfig.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ScheduleConfig.t),
      orderByList: orderByList?.call(ScheduleConfig.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ScheduleConfig]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ScheduleConfig>> delete(
    _i1.Session session,
    List<ScheduleConfig> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ScheduleConfig>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ScheduleConfig].
  Future<ScheduleConfig> deleteRow(
    _i1.Session session,
    ScheduleConfig row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ScheduleConfig>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ScheduleConfig>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ScheduleConfigTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ScheduleConfig>(
      where: where(ScheduleConfig.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ScheduleConfigTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ScheduleConfig>(
      where: where?.call(ScheduleConfig.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
