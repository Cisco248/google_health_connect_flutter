import 'package:flutter_health_connect/src/enums/availability.dart';
import 'package:flutter_health_connect/src/enums/metric.dart';
import 'package:flutter_health_connect/src/enums/record_type.dart';
import 'package:flutter_health_connect/src/models/aggregation.dart';
import 'package:flutter_health_connect/src/models/changes.dart';
import 'package:flutter_health_connect/src/models/daily_summary.dart';
import 'package:flutter_health_connect/src/models/permission.dart';
import 'package:flutter_health_connect/src/models/records/_base.dart';
import 'package:flutter_health_connect/src/platform/method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

/// Platform-specific implementations should set this with their own
/// platform-specific class that extends [HealthConnectPlatform] when
/// they register themselves.

/// Initializes the platform implementation.
/// Returns Health Connect availability.
/// Checks which of [permissions] are currently granted.
/// Requests [permissions] via the Health Connect permission UI.
/// Returns all currently granted Health Connect permissions known to the plugin.
/// Opens Health Connect settings.
/// Opens the app's Health Connect permission management screen.
/// Reads records of [type] between [startTime] and [endTime] (UTC instants).
/// Inserts [records] and returns their Health Connect IDs.
/// Deletes a single record by type and ID.
/// Deletes records of [type] in a time range.
/// Aggregates [metric] between [startTime] and [endTime].
/// Builds a daily summary for the local calendar day of [date].
/// Obtains a changes token for [recordTypes].
/// Fetches incremental changes for [token].

abstract class HealthConnectPlatform extends PlatformInterface {
  HealthConnectPlatform() : super(token: _token);

  static final Object _token = Object();
  static HealthConnectPlatform _instance = MethodChannelHealthConnect();
  static HealthConnectPlatform get instance => _instance;
  static set instance(HealthConnectPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> initialize({required bool enableLogging}) {
    throw UnimplementedError('initialize() has not been implemented.');
  }

  Future<Availability> getAvailability() {
    throw UnimplementedError('getAvailability() has not been implemented.');
  }

  Future<PermissionStatus> checkPermissions(List<Permission> permissions) {
    throw UnimplementedError('checkPermissions() has not been implemented.');
  }

  Future<bool> requestPermissions(List<Permission> permissions) {
    throw UnimplementedError('requestPermissions() has not been implemented.');
  }

  Future<Set<Permission>> getGrantedPermissions() {
    throw UnimplementedError(
      'getGrantedPermissions() has not been implemented.',
    );
  }

  Future<void> openHealthConnectSettings() {
    throw UnimplementedError(
      'openHealthConnectSettings() has not been implemented.',
    );
  }

  Future<void> openAppPermissions() {
    throw UnimplementedError('openAppPermissions() has not been implemented.');
  }

  Future<List<BaseRecord>> readRecords({
    required RecordType type,
    required DateTime startTime,
    required DateTime endTime,
  }) {
    throw UnimplementedError('readRecords() has not been implemented.');
  }

  Future<List<String>> writeRecords(List<BaseRecord> records) {
    throw UnimplementedError('writeRecords() has not been implemented.');
  }

  Future<void> deleteRecord({
    required RecordType type,
    required String recordId,
  }) {
    throw UnimplementedError('deleteRecord() has not been implemented.');
  }

  Future<void> deleteRecordsByTimeRange({
    required RecordType type,
    required DateTime startTime,
    required DateTime endTime,
  }) {
    throw UnimplementedError(
      'deleteRecordsByTimeRange() has not been implemented.',
    );
  }

  Future<AggregationResult> aggregate({
    required Metric metric,
    required DateTime startTime,
    required DateTime endTime,
  }) {
    throw UnimplementedError('aggregate() has not been implemented.');
  }

  Future<DailySummary> getDailyHealthSummary({required DateTime date}) {
    throw UnimplementedError(
      'getDailyHealthSummary() has not been implemented.',
    );
  }

  Future<ChangesToken> getChangesToken({
    required List<RecordType> recordTypes,
  }) {
    throw UnimplementedError('getChangesToken() has not been implemented.');
  }

  Future<Changes> getChanges(ChangesToken token) {
    throw UnimplementedError('getChanges() has not been implemented.');
  }
}
