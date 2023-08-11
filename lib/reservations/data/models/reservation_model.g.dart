// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetReservationModelCollection on Isar {
  IsarCollection<ReservationModel> get reservationModels => this.collection();
}

const ReservationModelSchema = CollectionSchema(
  name: r'reservation_model',
  id: 5528383710499537101,
  properties: {
    r'event': PropertySchema(
      id: 0,
      name: r'event',
      type: IsarType.long,
    ),
    r'guest': PropertySchema(
      id: 1,
      name: r'guest',
      type: IsarType.long,
    ),
    r'id': PropertySchema(
      id: 2,
      name: r'id',
      type: IsarType.long,
    ),
    r'numberOfTickets': PropertySchema(
      id: 3,
      name: r'numberOfTickets',
      type: IsarType.long,
    ),
    r'status': PropertySchema(
      id: 4,
      name: r'status',
      type: IsarType.string,
    )
  },
  estimateSize: _reservationModelEstimateSize,
  serialize: _reservationModelSerialize,
  deserialize: _reservationModelDeserialize,
  deserializeProp: _reservationModelDeserializeProp,
  idName: r'localId',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _reservationModelGetId,
  getLinks: _reservationModelGetLinks,
  attach: _reservationModelAttach,
  version: '3.1.0+1',
);

int _reservationModelEstimateSize(
  ReservationModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.status;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _reservationModelSerialize(
  ReservationModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.event);
  writer.writeLong(offsets[1], object.guest);
  writer.writeLong(offsets[2], object.id);
  writer.writeLong(offsets[3], object.numberOfTickets);
  writer.writeString(offsets[4], object.status);
}

ReservationModel _reservationModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ReservationModel(
    event: reader.readLongOrNull(offsets[0]),
    guest: reader.readLongOrNull(offsets[1]),
    id: reader.readLongOrNull(offsets[2]),
    numberOfTickets: reader.readLongOrNull(offsets[3]),
    status: reader.readStringOrNull(offsets[4]),
  );
  object.localId = id;
  return object;
}

P _reservationModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _reservationModelGetId(ReservationModel object) {
  return object.localId;
}

List<IsarLinkBase<dynamic>> _reservationModelGetLinks(ReservationModel object) {
  return [];
}

void _reservationModelAttach(
    IsarCollection<dynamic> col, Id id, ReservationModel object) {
  object.localId = id;
}

extension ReservationModelQueryWhereSort
    on QueryBuilder<ReservationModel, ReservationModel, QWhere> {
  QueryBuilder<ReservationModel, ReservationModel, QAfterWhere> anyLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ReservationModelQueryWhere
    on QueryBuilder<ReservationModel, ReservationModel, QWhereClause> {
  QueryBuilder<ReservationModel, ReservationModel, QAfterWhereClause>
      localIdEqualTo(Id localId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: localId,
        upper: localId,
      ));
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterWhereClause>
      localIdNotEqualTo(Id localId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: localId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: localId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: localId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: localId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterWhereClause>
      localIdGreaterThan(Id localId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: localId, includeLower: include),
      );
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterWhereClause>
      localIdLessThan(Id localId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: localId, includeUpper: include),
      );
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterWhereClause>
      localIdBetween(
    Id lowerLocalId,
    Id upperLocalId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerLocalId,
        includeLower: includeLower,
        upper: upperLocalId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ReservationModelQueryFilter
    on QueryBuilder<ReservationModel, ReservationModel, QFilterCondition> {
  QueryBuilder<ReservationModel, ReservationModel, QAfterFilterCondition>
      eventIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'event',
      ));
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterFilterCondition>
      eventIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'event',
      ));
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterFilterCondition>
      eventEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'event',
        value: value,
      ));
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterFilterCondition>
      eventGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'event',
        value: value,
      ));
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterFilterCondition>
      eventLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'event',
        value: value,
      ));
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterFilterCondition>
      eventBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'event',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterFilterCondition>
      guestIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'guest',
      ));
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterFilterCondition>
      guestIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'guest',
      ));
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterFilterCondition>
      guestEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'guest',
        value: value,
      ));
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterFilterCondition>
      guestGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'guest',
        value: value,
      ));
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterFilterCondition>
      guestLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'guest',
        value: value,
      ));
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterFilterCondition>
      guestBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'guest',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterFilterCondition>
      idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterFilterCondition>
      idEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterFilterCondition>
      idGreaterThan(
    int? value, {
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

  QueryBuilder<ReservationModel, ReservationModel, QAfterFilterCondition>
      idLessThan(
    int? value, {
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

  QueryBuilder<ReservationModel, ReservationModel, QAfterFilterCondition>
      idBetween(
    int? lower,
    int? upper, {
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

  QueryBuilder<ReservationModel, ReservationModel, QAfterFilterCondition>
      localIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localId',
        value: value,
      ));
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterFilterCondition>
      localIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'localId',
        value: value,
      ));
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterFilterCondition>
      localIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'localId',
        value: value,
      ));
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterFilterCondition>
      localIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'localId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterFilterCondition>
      numberOfTicketsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'numberOfTickets',
      ));
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterFilterCondition>
      numberOfTicketsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'numberOfTickets',
      ));
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterFilterCondition>
      numberOfTicketsEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'numberOfTickets',
        value: value,
      ));
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterFilterCondition>
      numberOfTicketsGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'numberOfTickets',
        value: value,
      ));
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterFilterCondition>
      numberOfTicketsLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'numberOfTickets',
        value: value,
      ));
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterFilterCondition>
      numberOfTicketsBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'numberOfTickets',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterFilterCondition>
      statusIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'status',
      ));
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterFilterCondition>
      statusIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'status',
      ));
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterFilterCondition>
      statusEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterFilterCondition>
      statusGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterFilterCondition>
      statusLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterFilterCondition>
      statusBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterFilterCondition>
      statusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterFilterCondition>
      statusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterFilterCondition>
      statusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterFilterCondition>
      statusMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'status',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterFilterCondition>
      statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterFilterCondition>
      statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'status',
        value: '',
      ));
    });
  }
}

extension ReservationModelQueryObject
    on QueryBuilder<ReservationModel, ReservationModel, QFilterCondition> {}

extension ReservationModelQueryLinks
    on QueryBuilder<ReservationModel, ReservationModel, QFilterCondition> {}

extension ReservationModelQuerySortBy
    on QueryBuilder<ReservationModel, ReservationModel, QSortBy> {
  QueryBuilder<ReservationModel, ReservationModel, QAfterSortBy> sortByEvent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'event', Sort.asc);
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterSortBy>
      sortByEventDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'event', Sort.desc);
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterSortBy> sortByGuest() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'guest', Sort.asc);
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterSortBy>
      sortByGuestDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'guest', Sort.desc);
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterSortBy>
      sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterSortBy>
      sortByNumberOfTickets() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numberOfTickets', Sort.asc);
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterSortBy>
      sortByNumberOfTicketsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numberOfTickets', Sort.desc);
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterSortBy>
      sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterSortBy>
      sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }
}

extension ReservationModelQuerySortThenBy
    on QueryBuilder<ReservationModel, ReservationModel, QSortThenBy> {
  QueryBuilder<ReservationModel, ReservationModel, QAfterSortBy> thenByEvent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'event', Sort.asc);
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterSortBy>
      thenByEventDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'event', Sort.desc);
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterSortBy> thenByGuest() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'guest', Sort.asc);
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterSortBy>
      thenByGuestDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'guest', Sort.desc);
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterSortBy>
      thenByLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localId', Sort.asc);
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterSortBy>
      thenByLocalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localId', Sort.desc);
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterSortBy>
      thenByNumberOfTickets() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numberOfTickets', Sort.asc);
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterSortBy>
      thenByNumberOfTicketsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numberOfTickets', Sort.desc);
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterSortBy>
      thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QAfterSortBy>
      thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }
}

extension ReservationModelQueryWhereDistinct
    on QueryBuilder<ReservationModel, ReservationModel, QDistinct> {
  QueryBuilder<ReservationModel, ReservationModel, QDistinct>
      distinctByEvent() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'event');
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QDistinct>
      distinctByGuest() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'guest');
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QDistinct> distinctById() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id');
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QDistinct>
      distinctByNumberOfTickets() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'numberOfTickets');
    });
  }

  QueryBuilder<ReservationModel, ReservationModel, QDistinct> distinctByStatus(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }
}

extension ReservationModelQueryProperty
    on QueryBuilder<ReservationModel, ReservationModel, QQueryProperty> {
  QueryBuilder<ReservationModel, int, QQueryOperations> localIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'localId');
    });
  }

  QueryBuilder<ReservationModel, int?, QQueryOperations> eventProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'event');
    });
  }

  QueryBuilder<ReservationModel, int?, QQueryOperations> guestProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'guest');
    });
  }

  QueryBuilder<ReservationModel, int?, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ReservationModel, int?, QQueryOperations>
      numberOfTicketsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'numberOfTickets');
    });
  }

  QueryBuilder<ReservationModel, String?, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }
}
