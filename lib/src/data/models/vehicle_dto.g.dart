// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_dto.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetVehicleDtoCollection on Isar {
  IsarCollection<VehicleDto> get vehicleDtos => this.collection();
}

const VehicleDtoSchema = CollectionSchema(
  name: r'VehicleDto',
  id: -1427109829832447942,
  properties: {
    r'brand': PropertySchema(
      id: 0,
      name: r'brand',
      type: IsarType.string,
    ),
    r'efficiencyWhPerKm': PropertySchema(
      id: 1,
      name: r'efficiencyWhPerKm',
      type: IsarType.double,
    ),
    r'maxChargingPowerKw': PropertySchema(
      id: 2,
      name: r'maxChargingPowerKw',
      type: IsarType.double,
    ),
    r'maxDcChargingPowerKw': PropertySchema(
      id: 3,
      name: r'maxDcChargingPowerKw',
      type: IsarType.double,
    ),
    r'model': PropertySchema(
      id: 4,
      name: r'model',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 5,
      name: r'name',
      type: IsarType.string,
    ),
    r'supportedConnectors': PropertySchema(
      id: 6,
      name: r'supportedConnectors',
      type: IsarType.stringList,
    ),
    r'usableBatteryKwh': PropertySchema(
      id: 7,
      name: r'usableBatteryKwh',
      type: IsarType.double,
    ),
    r'vehicleId': PropertySchema(
      id: 8,
      name: r'vehicleId',
      type: IsarType.string,
    ),
    r'year': PropertySchema(
      id: 9,
      name: r'year',
      type: IsarType.long,
    )
  },
  estimateSize: _vehicleDtoEstimateSize,
  serialize: _vehicleDtoSerialize,
  deserialize: _vehicleDtoDeserialize,
  deserializeProp: _vehicleDtoDeserializeProp,
  idName: r'id',
  indexes: {
    r'vehicleId': IndexSchema(
      id: 2011968157433523416,
      name: r'vehicleId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'vehicleId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _vehicleDtoGetId,
  getLinks: _vehicleDtoGetLinks,
  attach: _vehicleDtoAttach,
  version: '3.1.0+1',
);

int _vehicleDtoEstimateSize(
  VehicleDto object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.brand.length * 3;
  bytesCount += 3 + object.model.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.supportedConnectors.length * 3;
  {
    for (var i = 0; i < object.supportedConnectors.length; i++) {
      final value = object.supportedConnectors[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.vehicleId.length * 3;
  return bytesCount;
}

void _vehicleDtoSerialize(
  VehicleDto object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.brand);
  writer.writeDouble(offsets[1], object.efficiencyWhPerKm);
  writer.writeDouble(offsets[2], object.maxChargingPowerKw);
  writer.writeDouble(offsets[3], object.maxDcChargingPowerKw);
  writer.writeString(offsets[4], object.model);
  writer.writeString(offsets[5], object.name);
  writer.writeStringList(offsets[6], object.supportedConnectors);
  writer.writeDouble(offsets[7], object.usableBatteryKwh);
  writer.writeString(offsets[8], object.vehicleId);
  writer.writeLong(offsets[9], object.year);
}

VehicleDto _vehicleDtoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = VehicleDto();
  object.brand = reader.readString(offsets[0]);
  object.efficiencyWhPerKm = reader.readDouble(offsets[1]);
  object.id = id;
  object.maxChargingPowerKw = reader.readDouble(offsets[2]);
  object.maxDcChargingPowerKw = reader.readDouble(offsets[3]);
  object.model = reader.readString(offsets[4]);
  object.name = reader.readString(offsets[5]);
  object.supportedConnectors = reader.readStringList(offsets[6]) ?? [];
  object.usableBatteryKwh = reader.readDouble(offsets[7]);
  object.vehicleId = reader.readString(offsets[8]);
  object.year = reader.readLong(offsets[9]);
  return object;
}

P _vehicleDtoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readDouble(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readStringList(offset) ?? []) as P;
    case 7:
      return (reader.readDouble(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _vehicleDtoGetId(VehicleDto object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _vehicleDtoGetLinks(VehicleDto object) {
  return [];
}

void _vehicleDtoAttach(IsarCollection<dynamic> col, Id id, VehicleDto object) {
  object.id = id;
}

extension VehicleDtoByIndex on IsarCollection<VehicleDto> {
  Future<VehicleDto?> getByVehicleId(String vehicleId) {
    return getByIndex(r'vehicleId', [vehicleId]);
  }

  VehicleDto? getByVehicleIdSync(String vehicleId) {
    return getByIndexSync(r'vehicleId', [vehicleId]);
  }

  Future<bool> deleteByVehicleId(String vehicleId) {
    return deleteByIndex(r'vehicleId', [vehicleId]);
  }

  bool deleteByVehicleIdSync(String vehicleId) {
    return deleteByIndexSync(r'vehicleId', [vehicleId]);
  }

  Future<List<VehicleDto?>> getAllByVehicleId(List<String> vehicleIdValues) {
    final values = vehicleIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'vehicleId', values);
  }

  List<VehicleDto?> getAllByVehicleIdSync(List<String> vehicleIdValues) {
    final values = vehicleIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'vehicleId', values);
  }

  Future<int> deleteAllByVehicleId(List<String> vehicleIdValues) {
    final values = vehicleIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'vehicleId', values);
  }

  int deleteAllByVehicleIdSync(List<String> vehicleIdValues) {
    final values = vehicleIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'vehicleId', values);
  }

  Future<Id> putByVehicleId(VehicleDto object) {
    return putByIndex(r'vehicleId', object);
  }

  Id putByVehicleIdSync(VehicleDto object, {bool saveLinks = true}) {
    return putByIndexSync(r'vehicleId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByVehicleId(List<VehicleDto> objects) {
    return putAllByIndex(r'vehicleId', objects);
  }

  List<Id> putAllByVehicleIdSync(List<VehicleDto> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'vehicleId', objects, saveLinks: saveLinks);
  }
}

extension VehicleDtoQueryWhereSort
    on QueryBuilder<VehicleDto, VehicleDto, QWhere> {
  QueryBuilder<VehicleDto, VehicleDto, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension VehicleDtoQueryWhere
    on QueryBuilder<VehicleDto, VehicleDto, QWhereClause> {
  QueryBuilder<VehicleDto, VehicleDto, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<VehicleDto, VehicleDto, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterWhereClause> idBetween(
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

  QueryBuilder<VehicleDto, VehicleDto, QAfterWhereClause> vehicleIdEqualTo(
      String vehicleId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'vehicleId',
        value: [vehicleId],
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterWhereClause> vehicleIdNotEqualTo(
      String vehicleId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'vehicleId',
              lower: [],
              upper: [vehicleId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'vehicleId',
              lower: [vehicleId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'vehicleId',
              lower: [vehicleId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'vehicleId',
              lower: [],
              upper: [vehicleId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension VehicleDtoQueryFilter
    on QueryBuilder<VehicleDto, VehicleDto, QFilterCondition> {
  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition> brandEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'brand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition> brandGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'brand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition> brandLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'brand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition> brandBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'brand',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition> brandStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'brand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition> brandEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'brand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition> brandContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'brand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition> brandMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'brand',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition> brandIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'brand',
        value: '',
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition>
      brandIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'brand',
        value: '',
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition>
      efficiencyWhPerKmEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'efficiencyWhPerKm',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition>
      efficiencyWhPerKmGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'efficiencyWhPerKm',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition>
      efficiencyWhPerKmLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'efficiencyWhPerKm',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition>
      efficiencyWhPerKmBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'efficiencyWhPerKm',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition> idBetween(
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

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition>
      maxChargingPowerKwEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maxChargingPowerKw',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition>
      maxChargingPowerKwGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'maxChargingPowerKw',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition>
      maxChargingPowerKwLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'maxChargingPowerKw',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition>
      maxChargingPowerKwBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'maxChargingPowerKw',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition>
      maxDcChargingPowerKwEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maxDcChargingPowerKw',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition>
      maxDcChargingPowerKwGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'maxDcChargingPowerKw',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition>
      maxDcChargingPowerKwLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'maxDcChargingPowerKw',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition>
      maxDcChargingPowerKwBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'maxDcChargingPowerKw',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition> modelEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'model',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition> modelGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'model',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition> modelLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'model',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition> modelBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'model',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition> modelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'model',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition> modelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'model',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition> modelContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'model',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition> modelMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'model',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition> modelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'model',
        value: '',
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition>
      modelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'model',
        value: '',
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition> nameContains(
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

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition> nameMatches(
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

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition>
      supportedConnectorsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'supportedConnectors',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition>
      supportedConnectorsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'supportedConnectors',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition>
      supportedConnectorsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'supportedConnectors',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition>
      supportedConnectorsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'supportedConnectors',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition>
      supportedConnectorsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'supportedConnectors',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition>
      supportedConnectorsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'supportedConnectors',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition>
      supportedConnectorsElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'supportedConnectors',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition>
      supportedConnectorsElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'supportedConnectors',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition>
      supportedConnectorsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'supportedConnectors',
        value: '',
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition>
      supportedConnectorsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'supportedConnectors',
        value: '',
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition>
      supportedConnectorsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'supportedConnectors',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition>
      supportedConnectorsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'supportedConnectors',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition>
      supportedConnectorsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'supportedConnectors',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition>
      supportedConnectorsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'supportedConnectors',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition>
      supportedConnectorsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'supportedConnectors',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition>
      supportedConnectorsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'supportedConnectors',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition>
      usableBatteryKwhEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'usableBatteryKwh',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition>
      usableBatteryKwhGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'usableBatteryKwh',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition>
      usableBatteryKwhLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'usableBatteryKwh',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition>
      usableBatteryKwhBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'usableBatteryKwh',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition> vehicleIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vehicleId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition>
      vehicleIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'vehicleId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition> vehicleIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'vehicleId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition> vehicleIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'vehicleId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition>
      vehicleIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'vehicleId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition> vehicleIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'vehicleId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition> vehicleIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'vehicleId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition> vehicleIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'vehicleId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition>
      vehicleIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vehicleId',
        value: '',
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition>
      vehicleIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'vehicleId',
        value: '',
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition> yearEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'year',
        value: value,
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition> yearGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'year',
        value: value,
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition> yearLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'year',
        value: value,
      ));
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterFilterCondition> yearBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'year',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension VehicleDtoQueryObject
    on QueryBuilder<VehicleDto, VehicleDto, QFilterCondition> {}

extension VehicleDtoQueryLinks
    on QueryBuilder<VehicleDto, VehicleDto, QFilterCondition> {}

extension VehicleDtoQuerySortBy
    on QueryBuilder<VehicleDto, VehicleDto, QSortBy> {
  QueryBuilder<VehicleDto, VehicleDto, QAfterSortBy> sortByBrand() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'brand', Sort.asc);
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterSortBy> sortByBrandDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'brand', Sort.desc);
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterSortBy> sortByEfficiencyWhPerKm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'efficiencyWhPerKm', Sort.asc);
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterSortBy>
      sortByEfficiencyWhPerKmDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'efficiencyWhPerKm', Sort.desc);
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterSortBy>
      sortByMaxChargingPowerKw() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxChargingPowerKw', Sort.asc);
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterSortBy>
      sortByMaxChargingPowerKwDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxChargingPowerKw', Sort.desc);
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterSortBy>
      sortByMaxDcChargingPowerKw() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxDcChargingPowerKw', Sort.asc);
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterSortBy>
      sortByMaxDcChargingPowerKwDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxDcChargingPowerKw', Sort.desc);
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterSortBy> sortByModel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'model', Sort.asc);
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterSortBy> sortByModelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'model', Sort.desc);
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterSortBy> sortByUsableBatteryKwh() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'usableBatteryKwh', Sort.asc);
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterSortBy>
      sortByUsableBatteryKwhDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'usableBatteryKwh', Sort.desc);
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterSortBy> sortByVehicleId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleId', Sort.asc);
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterSortBy> sortByVehicleIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleId', Sort.desc);
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterSortBy> sortByYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'year', Sort.asc);
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterSortBy> sortByYearDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'year', Sort.desc);
    });
  }
}

extension VehicleDtoQuerySortThenBy
    on QueryBuilder<VehicleDto, VehicleDto, QSortThenBy> {
  QueryBuilder<VehicleDto, VehicleDto, QAfterSortBy> thenByBrand() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'brand', Sort.asc);
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterSortBy> thenByBrandDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'brand', Sort.desc);
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterSortBy> thenByEfficiencyWhPerKm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'efficiencyWhPerKm', Sort.asc);
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterSortBy>
      thenByEfficiencyWhPerKmDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'efficiencyWhPerKm', Sort.desc);
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterSortBy>
      thenByMaxChargingPowerKw() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxChargingPowerKw', Sort.asc);
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterSortBy>
      thenByMaxChargingPowerKwDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxChargingPowerKw', Sort.desc);
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterSortBy>
      thenByMaxDcChargingPowerKw() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxDcChargingPowerKw', Sort.asc);
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterSortBy>
      thenByMaxDcChargingPowerKwDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxDcChargingPowerKw', Sort.desc);
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterSortBy> thenByModel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'model', Sort.asc);
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterSortBy> thenByModelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'model', Sort.desc);
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterSortBy> thenByUsableBatteryKwh() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'usableBatteryKwh', Sort.asc);
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterSortBy>
      thenByUsableBatteryKwhDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'usableBatteryKwh', Sort.desc);
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterSortBy> thenByVehicleId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleId', Sort.asc);
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterSortBy> thenByVehicleIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleId', Sort.desc);
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterSortBy> thenByYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'year', Sort.asc);
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QAfterSortBy> thenByYearDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'year', Sort.desc);
    });
  }
}

extension VehicleDtoQueryWhereDistinct
    on QueryBuilder<VehicleDto, VehicleDto, QDistinct> {
  QueryBuilder<VehicleDto, VehicleDto, QDistinct> distinctByBrand(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'brand', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QDistinct>
      distinctByEfficiencyWhPerKm() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'efficiencyWhPerKm');
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QDistinct>
      distinctByMaxChargingPowerKw() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'maxChargingPowerKw');
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QDistinct>
      distinctByMaxDcChargingPowerKw() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'maxDcChargingPowerKw');
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QDistinct> distinctByModel(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'model', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QDistinct>
      distinctBySupportedConnectors() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'supportedConnectors');
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QDistinct> distinctByUsableBatteryKwh() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'usableBatteryKwh');
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QDistinct> distinctByVehicleId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'vehicleId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<VehicleDto, VehicleDto, QDistinct> distinctByYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'year');
    });
  }
}

extension VehicleDtoQueryProperty
    on QueryBuilder<VehicleDto, VehicleDto, QQueryProperty> {
  QueryBuilder<VehicleDto, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<VehicleDto, String, QQueryOperations> brandProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'brand');
    });
  }

  QueryBuilder<VehicleDto, double, QQueryOperations>
      efficiencyWhPerKmProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'efficiencyWhPerKm');
    });
  }

  QueryBuilder<VehicleDto, double, QQueryOperations>
      maxChargingPowerKwProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'maxChargingPowerKw');
    });
  }

  QueryBuilder<VehicleDto, double, QQueryOperations>
      maxDcChargingPowerKwProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'maxDcChargingPowerKw');
    });
  }

  QueryBuilder<VehicleDto, String, QQueryOperations> modelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'model');
    });
  }

  QueryBuilder<VehicleDto, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<VehicleDto, List<String>, QQueryOperations>
      supportedConnectorsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'supportedConnectors');
    });
  }

  QueryBuilder<VehicleDto, double, QQueryOperations>
      usableBatteryKwhProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'usableBatteryKwh');
    });
  }

  QueryBuilder<VehicleDto, String, QQueryOperations> vehicleIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'vehicleId');
    });
  }

  QueryBuilder<VehicleDto, int, QQueryOperations> yearProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'year');
    });
  }
}
