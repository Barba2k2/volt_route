// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_dto.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTripDtoCollection on Isar {
  IsarCollection<TripDto> get tripDtos => this.collection();
}

const TripDtoSchema = CollectionSchema(
  name: r'TripDto',
  id: 1886097716509347190,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'destinationLat': PropertySchema(
      id: 1,
      name: r'destinationLat',
      type: IsarType.double,
    ),
    r'destinationLng': PropertySchema(
      id: 2,
      name: r'destinationLng',
      type: IsarType.double,
    ),
    r'isSaved': PropertySchema(
      id: 3,
      name: r'isSaved',
      type: IsarType.bool,
    ),
    r'lastModified': PropertySchema(
      id: 4,
      name: r'lastModified',
      type: IsarType.dateTime,
    ),
    r'name': PropertySchema(
      id: 5,
      name: r'name',
      type: IsarType.string,
    ),
    r'originLat': PropertySchema(
      id: 6,
      name: r'originLat',
      type: IsarType.double,
    ),
    r'originLng': PropertySchema(
      id: 7,
      name: r'originLng',
      type: IsarType.double,
    ),
    r'tripId': PropertySchema(
      id: 8,
      name: r'tripId',
      type: IsarType.string,
    ),
    r'userId': PropertySchema(
      id: 9,
      name: r'userId',
      type: IsarType.string,
    )
  },
  estimateSize: _tripDtoEstimateSize,
  serialize: _tripDtoSerialize,
  deserialize: _tripDtoDeserialize,
  deserializeProp: _tripDtoDeserializeProp,
  idName: r'id',
  indexes: {
    r'tripId': IndexSchema(
      id: 7734156669642746260,
      name: r'tripId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'tripId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _tripDtoGetId,
  getLinks: _tripDtoGetLinks,
  attach: _tripDtoAttach,
  version: '3.1.0+1',
);

int _tripDtoEstimateSize(
  TripDto object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.tripId.length * 3;
  {
    final value = object.userId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _tripDtoSerialize(
  TripDto object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeDouble(offsets[1], object.destinationLat);
  writer.writeDouble(offsets[2], object.destinationLng);
  writer.writeBool(offsets[3], object.isSaved);
  writer.writeDateTime(offsets[4], object.lastModified);
  writer.writeString(offsets[5], object.name);
  writer.writeDouble(offsets[6], object.originLat);
  writer.writeDouble(offsets[7], object.originLng);
  writer.writeString(offsets[8], object.tripId);
  writer.writeString(offsets[9], object.userId);
}

TripDto _tripDtoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TripDto();
  object.createdAt = reader.readDateTime(offsets[0]);
  object.destinationLat = reader.readDouble(offsets[1]);
  object.destinationLng = reader.readDouble(offsets[2]);
  object.id = id;
  object.isSaved = reader.readBool(offsets[3]);
  object.lastModified = reader.readDateTimeOrNull(offsets[4]);
  object.name = reader.readString(offsets[5]);
  object.originLat = reader.readDouble(offsets[6]);
  object.originLng = reader.readDouble(offsets[7]);
  object.tripId = reader.readString(offsets[8]);
  object.userId = reader.readStringOrNull(offsets[9]);
  return object;
}

P _tripDtoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readDouble(offset)) as P;
    case 7:
      return (reader.readDouble(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _tripDtoGetId(TripDto object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _tripDtoGetLinks(TripDto object) {
  return [];
}

void _tripDtoAttach(IsarCollection<dynamic> col, Id id, TripDto object) {
  object.id = id;
}

extension TripDtoByIndex on IsarCollection<TripDto> {
  Future<TripDto?> getByTripId(String tripId) {
    return getByIndex(r'tripId', [tripId]);
  }

  TripDto? getByTripIdSync(String tripId) {
    return getByIndexSync(r'tripId', [tripId]);
  }

  Future<bool> deleteByTripId(String tripId) {
    return deleteByIndex(r'tripId', [tripId]);
  }

  bool deleteByTripIdSync(String tripId) {
    return deleteByIndexSync(r'tripId', [tripId]);
  }

  Future<List<TripDto?>> getAllByTripId(List<String> tripIdValues) {
    final values = tripIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'tripId', values);
  }

  List<TripDto?> getAllByTripIdSync(List<String> tripIdValues) {
    final values = tripIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'tripId', values);
  }

  Future<int> deleteAllByTripId(List<String> tripIdValues) {
    final values = tripIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'tripId', values);
  }

  int deleteAllByTripIdSync(List<String> tripIdValues) {
    final values = tripIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'tripId', values);
  }

  Future<Id> putByTripId(TripDto object) {
    return putByIndex(r'tripId', object);
  }

  Id putByTripIdSync(TripDto object, {bool saveLinks = true}) {
    return putByIndexSync(r'tripId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByTripId(List<TripDto> objects) {
    return putAllByIndex(r'tripId', objects);
  }

  List<Id> putAllByTripIdSync(List<TripDto> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'tripId', objects, saveLinks: saveLinks);
  }
}

extension TripDtoQueryWhereSort on QueryBuilder<TripDto, TripDto, QWhere> {
  QueryBuilder<TripDto, TripDto, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TripDtoQueryWhere on QueryBuilder<TripDto, TripDto, QWhereClause> {
  QueryBuilder<TripDto, TripDto, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterWhereClause> tripIdEqualTo(
      String tripId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'tripId',
        value: [tripId],
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterWhereClause> tripIdNotEqualTo(
      String tripId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'tripId',
              lower: [],
              upper: [tripId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'tripId',
              lower: [tripId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'tripId',
              lower: [tripId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'tripId',
              lower: [],
              upper: [tripId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension TripDtoQueryFilter
    on QueryBuilder<TripDto, TripDto, QFilterCondition> {
  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> createdAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> destinationLatEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'destinationLat',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition>
      destinationLatGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'destinationLat',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> destinationLatLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'destinationLat',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> destinationLatBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'destinationLat',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> destinationLngEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'destinationLng',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition>
      destinationLngGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'destinationLng',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> destinationLngLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'destinationLng',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> destinationLngBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'destinationLng',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> isSavedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSaved',
        value: value,
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> lastModifiedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastModified',
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition>
      lastModifiedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastModified',
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> lastModifiedEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastModified',
        value: value,
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> lastModifiedGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastModified',
        value: value,
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> lastModifiedLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastModified',
        value: value,
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> lastModifiedBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastModified',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> originLatEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'originLat',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> originLatGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'originLat',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> originLatLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'originLat',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> originLatBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'originLat',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> originLngEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'originLng',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> originLngGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'originLng',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> originLngLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'originLng',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> originLngBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'originLng',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> tripIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tripId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> tripIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tripId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> tripIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tripId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> tripIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tripId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> tripIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tripId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> tripIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tripId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> tripIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tripId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> tripIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tripId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> tripIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tripId',
        value: '',
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> tripIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tripId',
        value: '',
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> userIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'userId',
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> userIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'userId',
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> userIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> userIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> userIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> userIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> userIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> userIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> userIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> userIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> userIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: '',
      ));
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterFilterCondition> userIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userId',
        value: '',
      ));
    });
  }
}

extension TripDtoQueryObject
    on QueryBuilder<TripDto, TripDto, QFilterCondition> {}

extension TripDtoQueryLinks
    on QueryBuilder<TripDto, TripDto, QFilterCondition> {}

extension TripDtoQuerySortBy on QueryBuilder<TripDto, TripDto, QSortBy> {
  QueryBuilder<TripDto, TripDto, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterSortBy> sortByDestinationLat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'destinationLat', Sort.asc);
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterSortBy> sortByDestinationLatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'destinationLat', Sort.desc);
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterSortBy> sortByDestinationLng() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'destinationLng', Sort.asc);
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterSortBy> sortByDestinationLngDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'destinationLng', Sort.desc);
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterSortBy> sortByIsSaved() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSaved', Sort.asc);
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterSortBy> sortByIsSavedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSaved', Sort.desc);
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterSortBy> sortByLastModified() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastModified', Sort.asc);
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterSortBy> sortByLastModifiedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastModified', Sort.desc);
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterSortBy> sortByOriginLat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originLat', Sort.asc);
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterSortBy> sortByOriginLatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originLat', Sort.desc);
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterSortBy> sortByOriginLng() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originLng', Sort.asc);
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterSortBy> sortByOriginLngDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originLng', Sort.desc);
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterSortBy> sortByTripId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tripId', Sort.asc);
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterSortBy> sortByTripIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tripId', Sort.desc);
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterSortBy> sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterSortBy> sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension TripDtoQuerySortThenBy
    on QueryBuilder<TripDto, TripDto, QSortThenBy> {
  QueryBuilder<TripDto, TripDto, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterSortBy> thenByDestinationLat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'destinationLat', Sort.asc);
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterSortBy> thenByDestinationLatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'destinationLat', Sort.desc);
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterSortBy> thenByDestinationLng() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'destinationLng', Sort.asc);
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterSortBy> thenByDestinationLngDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'destinationLng', Sort.desc);
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterSortBy> thenByIsSaved() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSaved', Sort.asc);
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterSortBy> thenByIsSavedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSaved', Sort.desc);
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterSortBy> thenByLastModified() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastModified', Sort.asc);
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterSortBy> thenByLastModifiedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastModified', Sort.desc);
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterSortBy> thenByOriginLat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originLat', Sort.asc);
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterSortBy> thenByOriginLatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originLat', Sort.desc);
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterSortBy> thenByOriginLng() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originLng', Sort.asc);
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterSortBy> thenByOriginLngDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originLng', Sort.desc);
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterSortBy> thenByTripId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tripId', Sort.asc);
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterSortBy> thenByTripIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tripId', Sort.desc);
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterSortBy> thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<TripDto, TripDto, QAfterSortBy> thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension TripDtoQueryWhereDistinct
    on QueryBuilder<TripDto, TripDto, QDistinct> {
  QueryBuilder<TripDto, TripDto, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<TripDto, TripDto, QDistinct> distinctByDestinationLat() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'destinationLat');
    });
  }

  QueryBuilder<TripDto, TripDto, QDistinct> distinctByDestinationLng() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'destinationLng');
    });
  }

  QueryBuilder<TripDto, TripDto, QDistinct> distinctByIsSaved() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSaved');
    });
  }

  QueryBuilder<TripDto, TripDto, QDistinct> distinctByLastModified() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastModified');
    });
  }

  QueryBuilder<TripDto, TripDto, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TripDto, TripDto, QDistinct> distinctByOriginLat() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'originLat');
    });
  }

  QueryBuilder<TripDto, TripDto, QDistinct> distinctByOriginLng() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'originLng');
    });
  }

  QueryBuilder<TripDto, TripDto, QDistinct> distinctByTripId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tripId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TripDto, TripDto, QDistinct> distinctByUserId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId', caseSensitive: caseSensitive);
    });
  }
}

extension TripDtoQueryProperty
    on QueryBuilder<TripDto, TripDto, QQueryProperty> {
  QueryBuilder<TripDto, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TripDto, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<TripDto, double, QQueryOperations> destinationLatProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'destinationLat');
    });
  }

  QueryBuilder<TripDto, double, QQueryOperations> destinationLngProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'destinationLng');
    });
  }

  QueryBuilder<TripDto, bool, QQueryOperations> isSavedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSaved');
    });
  }

  QueryBuilder<TripDto, DateTime?, QQueryOperations> lastModifiedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastModified');
    });
  }

  QueryBuilder<TripDto, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<TripDto, double, QQueryOperations> originLatProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'originLat');
    });
  }

  QueryBuilder<TripDto, double, QQueryOperations> originLngProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'originLng');
    });
  }

  QueryBuilder<TripDto, String, QQueryOperations> tripIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tripId');
    });
  }

  QueryBuilder<TripDto, String?, QQueryOperations> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const TripAssumptionsDtoSchema = Schema(
  name: r'TripAssumptionsDto',
  id: 704789217121286799,
  properties: {
    r'ambientTemperatureCelsius': PropertySchema(
      id: 0,
      name: r'ambientTemperatureCelsius',
      type: IsarType.double,
    ),
    r'averageSpeedKmh': PropertySchema(
      id: 1,
      name: r'averageSpeedKmh',
      type: IsarType.double,
    ),
    r'chargingCostPerKwh': PropertySchema(
      id: 2,
      name: r'chargingCostPerKwh',
      type: IsarType.double,
    ),
    r'hvacConsumptionPercent': PropertySchema(
      id: 3,
      name: r'hvacConsumptionPercent',
      type: IsarType.double,
    ),
    r'maxChargingSessionMinutes': PropertySchema(
      id: 4,
      name: r'maxChargingSessionMinutes',
      type: IsarType.long,
    ),
    r'reserveBufferPercent': PropertySchema(
      id: 5,
      name: r'reserveBufferPercent',
      type: IsarType.double,
    ),
    r'useHvac': PropertySchema(
      id: 6,
      name: r'useHvac',
      type: IsarType.bool,
    )
  },
  estimateSize: _tripAssumptionsDtoEstimateSize,
  serialize: _tripAssumptionsDtoSerialize,
  deserialize: _tripAssumptionsDtoDeserialize,
  deserializeProp: _tripAssumptionsDtoDeserializeProp,
);

int _tripAssumptionsDtoEstimateSize(
  TripAssumptionsDto object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _tripAssumptionsDtoSerialize(
  TripAssumptionsDto object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.ambientTemperatureCelsius);
  writer.writeDouble(offsets[1], object.averageSpeedKmh);
  writer.writeDouble(offsets[2], object.chargingCostPerKwh);
  writer.writeDouble(offsets[3], object.hvacConsumptionPercent);
  writer.writeLong(offsets[4], object.maxChargingSessionMinutes);
  writer.writeDouble(offsets[5], object.reserveBufferPercent);
  writer.writeBool(offsets[6], object.useHvac);
}

TripAssumptionsDto _tripAssumptionsDtoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TripAssumptionsDto();
  object.ambientTemperatureCelsius = reader.readDouble(offsets[0]);
  object.averageSpeedKmh = reader.readDouble(offsets[1]);
  object.chargingCostPerKwh = reader.readDouble(offsets[2]);
  object.hvacConsumptionPercent = reader.readDouble(offsets[3]);
  object.maxChargingSessionMinutes = reader.readLong(offsets[4]);
  object.reserveBufferPercent = reader.readDouble(offsets[5]);
  object.useHvac = reader.readBool(offsets[6]);
  return object;
}

P _tripAssumptionsDtoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readDouble(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readDouble(offset)) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension TripAssumptionsDtoQueryFilter
    on QueryBuilder<TripAssumptionsDto, TripAssumptionsDto, QFilterCondition> {
  QueryBuilder<TripAssumptionsDto, TripAssumptionsDto, QAfterFilterCondition>
      ambientTemperatureCelsiusEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ambientTemperatureCelsius',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TripAssumptionsDto, TripAssumptionsDto, QAfterFilterCondition>
      ambientTemperatureCelsiusGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ambientTemperatureCelsius',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TripAssumptionsDto, TripAssumptionsDto, QAfterFilterCondition>
      ambientTemperatureCelsiusLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ambientTemperatureCelsius',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TripAssumptionsDto, TripAssumptionsDto, QAfterFilterCondition>
      ambientTemperatureCelsiusBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ambientTemperatureCelsius',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TripAssumptionsDto, TripAssumptionsDto, QAfterFilterCondition>
      averageSpeedKmhEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'averageSpeedKmh',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TripAssumptionsDto, TripAssumptionsDto, QAfterFilterCondition>
      averageSpeedKmhGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'averageSpeedKmh',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TripAssumptionsDto, TripAssumptionsDto, QAfterFilterCondition>
      averageSpeedKmhLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'averageSpeedKmh',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TripAssumptionsDto, TripAssumptionsDto, QAfterFilterCondition>
      averageSpeedKmhBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'averageSpeedKmh',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TripAssumptionsDto, TripAssumptionsDto, QAfterFilterCondition>
      chargingCostPerKwhEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chargingCostPerKwh',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TripAssumptionsDto, TripAssumptionsDto, QAfterFilterCondition>
      chargingCostPerKwhGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'chargingCostPerKwh',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TripAssumptionsDto, TripAssumptionsDto, QAfterFilterCondition>
      chargingCostPerKwhLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'chargingCostPerKwh',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TripAssumptionsDto, TripAssumptionsDto, QAfterFilterCondition>
      chargingCostPerKwhBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'chargingCostPerKwh',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TripAssumptionsDto, TripAssumptionsDto, QAfterFilterCondition>
      hvacConsumptionPercentEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hvacConsumptionPercent',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TripAssumptionsDto, TripAssumptionsDto, QAfterFilterCondition>
      hvacConsumptionPercentGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hvacConsumptionPercent',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TripAssumptionsDto, TripAssumptionsDto, QAfterFilterCondition>
      hvacConsumptionPercentLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hvacConsumptionPercent',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TripAssumptionsDto, TripAssumptionsDto, QAfterFilterCondition>
      hvacConsumptionPercentBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hvacConsumptionPercent',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TripAssumptionsDto, TripAssumptionsDto, QAfterFilterCondition>
      maxChargingSessionMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maxChargingSessionMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<TripAssumptionsDto, TripAssumptionsDto, QAfterFilterCondition>
      maxChargingSessionMinutesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'maxChargingSessionMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<TripAssumptionsDto, TripAssumptionsDto, QAfterFilterCondition>
      maxChargingSessionMinutesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'maxChargingSessionMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<TripAssumptionsDto, TripAssumptionsDto, QAfterFilterCondition>
      maxChargingSessionMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'maxChargingSessionMinutes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TripAssumptionsDto, TripAssumptionsDto, QAfterFilterCondition>
      reserveBufferPercentEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reserveBufferPercent',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TripAssumptionsDto, TripAssumptionsDto, QAfterFilterCondition>
      reserveBufferPercentGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'reserveBufferPercent',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TripAssumptionsDto, TripAssumptionsDto, QAfterFilterCondition>
      reserveBufferPercentLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'reserveBufferPercent',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TripAssumptionsDto, TripAssumptionsDto, QAfterFilterCondition>
      reserveBufferPercentBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'reserveBufferPercent',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TripAssumptionsDto, TripAssumptionsDto, QAfterFilterCondition>
      useHvacEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'useHvac',
        value: value,
      ));
    });
  }
}

extension TripAssumptionsDtoQueryObject
    on QueryBuilder<TripAssumptionsDto, TripAssumptionsDto, QFilterCondition> {}
