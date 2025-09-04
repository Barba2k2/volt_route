// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leg_estimate_dto.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetLegEstimateDtoCollection on Isar {
  IsarCollection<LegEstimateDto> get legEstimateDtos => this.collection();
}

const LegEstimateDtoSchema = CollectionSchema(
  name: r'LegEstimateDto',
  id: 1242077351502688686,
  properties: {
    r'arrivalSoCPercent': PropertySchema(
      id: 0,
      name: r'arrivalSoCPercent',
      type: IsarType.double,
    ),
    r'assumptions': PropertySchema(
      id: 1,
      name: r'assumptions',
      type: IsarType.stringList,
    ),
    r'chargingCost': PropertySchema(
      id: 2,
      name: r'chargingCost',
      type: IsarType.double,
    ),
    r'chargingTimeMinutes': PropertySchema(
      id: 3,
      name: r'chargingTimeMinutes',
      type: IsarType.long,
    ),
    r'departureSoCPercent': PropertySchema(
      id: 4,
      name: r'departureSoCPercent',
      type: IsarType.double,
    ),
    r'energyConsumedKwh': PropertySchema(
      id: 5,
      name: r'energyConsumedKwh',
      type: IsarType.double,
    ),
    r'energyToAddKwh': PropertySchema(
      id: 6,
      name: r'energyToAddKwh',
      type: IsarType.double,
    )
  },
  estimateSize: _legEstimateDtoEstimateSize,
  serialize: _legEstimateDtoSerialize,
  deserialize: _legEstimateDtoDeserialize,
  deserializeProp: _legEstimateDtoDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _legEstimateDtoGetId,
  getLinks: _legEstimateDtoGetLinks,
  attach: _legEstimateDtoAttach,
  version: '3.1.0+1',
);

int _legEstimateDtoEstimateSize(
  LegEstimateDto object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.assumptions.length * 3;
  {
    for (var i = 0; i < object.assumptions.length; i++) {
      final value = object.assumptions[i];
      bytesCount += value.length * 3;
    }
  }
  return bytesCount;
}

void _legEstimateDtoSerialize(
  LegEstimateDto object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.arrivalSoCPercent);
  writer.writeStringList(offsets[1], object.assumptions);
  writer.writeDouble(offsets[2], object.chargingCost);
  writer.writeLong(offsets[3], object.chargingTimeMinutes);
  writer.writeDouble(offsets[4], object.departureSoCPercent);
  writer.writeDouble(offsets[5], object.energyConsumedKwh);
  writer.writeDouble(offsets[6], object.energyToAddKwh);
}

LegEstimateDto _legEstimateDtoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = LegEstimateDto();
  object.arrivalSoCPercent = reader.readDouble(offsets[0]);
  object.assumptions = reader.readStringList(offsets[1]) ?? [];
  object.chargingCost = reader.readDoubleOrNull(offsets[2]);
  object.chargingTimeMinutes = reader.readLongOrNull(offsets[3]);
  object.departureSoCPercent = reader.readDouble(offsets[4]);
  object.energyConsumedKwh = reader.readDouble(offsets[5]);
  object.energyToAddKwh = reader.readDoubleOrNull(offsets[6]);
  object.id = id;
  return object;
}

P _legEstimateDtoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readStringList(offset) ?? []) as P;
    case 2:
      return (reader.readDoubleOrNull(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readDouble(offset)) as P;
    case 5:
      return (reader.readDouble(offset)) as P;
    case 6:
      return (reader.readDoubleOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _legEstimateDtoGetId(LegEstimateDto object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _legEstimateDtoGetLinks(LegEstimateDto object) {
  return [];
}

void _legEstimateDtoAttach(
    IsarCollection<dynamic> col, Id id, LegEstimateDto object) {
  object.id = id;
}

extension LegEstimateDtoQueryWhereSort
    on QueryBuilder<LegEstimateDto, LegEstimateDto, QWhere> {
  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension LegEstimateDtoQueryWhere
    on QueryBuilder<LegEstimateDto, LegEstimateDto, QWhereClause> {
  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterWhereClause> idBetween(
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
}

extension LegEstimateDtoQueryFilter
    on QueryBuilder<LegEstimateDto, LegEstimateDto, QFilterCondition> {
  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterFilterCondition>
      arrivalSoCPercentEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'arrivalSoCPercent',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterFilterCondition>
      arrivalSoCPercentGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'arrivalSoCPercent',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterFilterCondition>
      arrivalSoCPercentLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'arrivalSoCPercent',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterFilterCondition>
      arrivalSoCPercentBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'arrivalSoCPercent',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterFilterCondition>
      assumptionsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'assumptions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterFilterCondition>
      assumptionsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'assumptions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterFilterCondition>
      assumptionsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'assumptions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterFilterCondition>
      assumptionsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'assumptions',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterFilterCondition>
      assumptionsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'assumptions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterFilterCondition>
      assumptionsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'assumptions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterFilterCondition>
      assumptionsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'assumptions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterFilterCondition>
      assumptionsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'assumptions',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterFilterCondition>
      assumptionsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'assumptions',
        value: '',
      ));
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterFilterCondition>
      assumptionsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'assumptions',
        value: '',
      ));
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterFilterCondition>
      assumptionsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'assumptions',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterFilterCondition>
      assumptionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'assumptions',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterFilterCondition>
      assumptionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'assumptions',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterFilterCondition>
      assumptionsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'assumptions',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterFilterCondition>
      assumptionsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'assumptions',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterFilterCondition>
      assumptionsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'assumptions',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterFilterCondition>
      chargingCostIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'chargingCost',
      ));
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterFilterCondition>
      chargingCostIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'chargingCost',
      ));
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterFilterCondition>
      chargingCostEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chargingCost',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterFilterCondition>
      chargingCostGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'chargingCost',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterFilterCondition>
      chargingCostLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'chargingCost',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterFilterCondition>
      chargingCostBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'chargingCost',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterFilterCondition>
      chargingTimeMinutesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'chargingTimeMinutes',
      ));
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterFilterCondition>
      chargingTimeMinutesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'chargingTimeMinutes',
      ));
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterFilterCondition>
      chargingTimeMinutesEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chargingTimeMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterFilterCondition>
      chargingTimeMinutesGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'chargingTimeMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterFilterCondition>
      chargingTimeMinutesLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'chargingTimeMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterFilterCondition>
      chargingTimeMinutesBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'chargingTimeMinutes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterFilterCondition>
      departureSoCPercentEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'departureSoCPercent',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterFilterCondition>
      departureSoCPercentGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'departureSoCPercent',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterFilterCondition>
      departureSoCPercentLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'departureSoCPercent',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterFilterCondition>
      departureSoCPercentBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'departureSoCPercent',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterFilterCondition>
      energyConsumedKwhEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'energyConsumedKwh',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterFilterCondition>
      energyConsumedKwhGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'energyConsumedKwh',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterFilterCondition>
      energyConsumedKwhLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'energyConsumedKwh',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterFilterCondition>
      energyConsumedKwhBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'energyConsumedKwh',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterFilterCondition>
      energyToAddKwhIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'energyToAddKwh',
      ));
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterFilterCondition>
      energyToAddKwhIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'energyToAddKwh',
      ));
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterFilterCondition>
      energyToAddKwhEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'energyToAddKwh',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterFilterCondition>
      energyToAddKwhGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'energyToAddKwh',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterFilterCondition>
      energyToAddKwhLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'energyToAddKwh',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterFilterCondition>
      energyToAddKwhBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'energyToAddKwh',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterFilterCondition> idBetween(
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
}

extension LegEstimateDtoQueryObject
    on QueryBuilder<LegEstimateDto, LegEstimateDto, QFilterCondition> {}

extension LegEstimateDtoQueryLinks
    on QueryBuilder<LegEstimateDto, LegEstimateDto, QFilterCondition> {}

extension LegEstimateDtoQuerySortBy
    on QueryBuilder<LegEstimateDto, LegEstimateDto, QSortBy> {
  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterSortBy>
      sortByArrivalSoCPercent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'arrivalSoCPercent', Sort.asc);
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterSortBy>
      sortByArrivalSoCPercentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'arrivalSoCPercent', Sort.desc);
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterSortBy>
      sortByChargingCost() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chargingCost', Sort.asc);
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterSortBy>
      sortByChargingCostDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chargingCost', Sort.desc);
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterSortBy>
      sortByChargingTimeMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chargingTimeMinutes', Sort.asc);
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterSortBy>
      sortByChargingTimeMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chargingTimeMinutes', Sort.desc);
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterSortBy>
      sortByDepartureSoCPercent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'departureSoCPercent', Sort.asc);
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterSortBy>
      sortByDepartureSoCPercentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'departureSoCPercent', Sort.desc);
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterSortBy>
      sortByEnergyConsumedKwh() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'energyConsumedKwh', Sort.asc);
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterSortBy>
      sortByEnergyConsumedKwhDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'energyConsumedKwh', Sort.desc);
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterSortBy>
      sortByEnergyToAddKwh() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'energyToAddKwh', Sort.asc);
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterSortBy>
      sortByEnergyToAddKwhDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'energyToAddKwh', Sort.desc);
    });
  }
}

extension LegEstimateDtoQuerySortThenBy
    on QueryBuilder<LegEstimateDto, LegEstimateDto, QSortThenBy> {
  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterSortBy>
      thenByArrivalSoCPercent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'arrivalSoCPercent', Sort.asc);
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterSortBy>
      thenByArrivalSoCPercentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'arrivalSoCPercent', Sort.desc);
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterSortBy>
      thenByChargingCost() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chargingCost', Sort.asc);
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterSortBy>
      thenByChargingCostDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chargingCost', Sort.desc);
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterSortBy>
      thenByChargingTimeMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chargingTimeMinutes', Sort.asc);
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterSortBy>
      thenByChargingTimeMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chargingTimeMinutes', Sort.desc);
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterSortBy>
      thenByDepartureSoCPercent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'departureSoCPercent', Sort.asc);
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterSortBy>
      thenByDepartureSoCPercentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'departureSoCPercent', Sort.desc);
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterSortBy>
      thenByEnergyConsumedKwh() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'energyConsumedKwh', Sort.asc);
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterSortBy>
      thenByEnergyConsumedKwhDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'energyConsumedKwh', Sort.desc);
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterSortBy>
      thenByEnergyToAddKwh() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'energyToAddKwh', Sort.asc);
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterSortBy>
      thenByEnergyToAddKwhDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'energyToAddKwh', Sort.desc);
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension LegEstimateDtoQueryWhereDistinct
    on QueryBuilder<LegEstimateDto, LegEstimateDto, QDistinct> {
  QueryBuilder<LegEstimateDto, LegEstimateDto, QDistinct>
      distinctByArrivalSoCPercent() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'arrivalSoCPercent');
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QDistinct>
      distinctByAssumptions() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'assumptions');
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QDistinct>
      distinctByChargingCost() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'chargingCost');
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QDistinct>
      distinctByChargingTimeMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'chargingTimeMinutes');
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QDistinct>
      distinctByDepartureSoCPercent() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'departureSoCPercent');
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QDistinct>
      distinctByEnergyConsumedKwh() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'energyConsumedKwh');
    });
  }

  QueryBuilder<LegEstimateDto, LegEstimateDto, QDistinct>
      distinctByEnergyToAddKwh() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'energyToAddKwh');
    });
  }
}

extension LegEstimateDtoQueryProperty
    on QueryBuilder<LegEstimateDto, LegEstimateDto, QQueryProperty> {
  QueryBuilder<LegEstimateDto, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<LegEstimateDto, double, QQueryOperations>
      arrivalSoCPercentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'arrivalSoCPercent');
    });
  }

  QueryBuilder<LegEstimateDto, List<String>, QQueryOperations>
      assumptionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'assumptions');
    });
  }

  QueryBuilder<LegEstimateDto, double?, QQueryOperations>
      chargingCostProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'chargingCost');
    });
  }

  QueryBuilder<LegEstimateDto, int?, QQueryOperations>
      chargingTimeMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'chargingTimeMinutes');
    });
  }

  QueryBuilder<LegEstimateDto, double, QQueryOperations>
      departureSoCPercentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'departureSoCPercent');
    });
  }

  QueryBuilder<LegEstimateDto, double, QQueryOperations>
      energyConsumedKwhProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'energyConsumedKwh');
    });
  }

  QueryBuilder<LegEstimateDto, double?, QQueryOperations>
      energyToAddKwhProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'energyToAddKwh');
    });
  }
}
