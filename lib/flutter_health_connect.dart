/// Flutter plugin for Android Health Connect.
///
/// Android only. Uses the official `androidx.health.connect:connect-client` SDK.
library;

export 'src/config/configuration.dart';
export 'src/enums/access.dart';
export 'src/enums/availability.dart';
export 'src/enums/metric.dart';
export 'src/enums/record_type.dart';
export 'src/exceptions/exception.dart';
export 'src/flutter_health_connect.dart';
export 'src/models/aggregation.dart';
export 'src/models/daily_summary.dart';
export 'src/models/changes.dart';
export 'src/models/health_data_origin.dart';
export 'src/models/permission.dart';
export 'src/models/records/activity.dart';
export 'src/models/records/body.dart';
export 'src/models/records/heart.dart';
export 'src/models/records/other.dart';
export 'src/models/records/sleep.dart';
export 'src/platform/platform.dart';
export 'src/models/records/_base.dart';
