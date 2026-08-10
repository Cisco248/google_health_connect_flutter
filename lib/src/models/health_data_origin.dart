/// Identifies the application that produced a health record.
class HealthDataOrigin {
  /// Creates a data origin.
  const HealthDataOrigin({
    this.packageName,
    this.applicationName,
  });

  /// Android package name of the contributing app, when available.
  final String? packageName;

  /// Human-readable application label, when available.
  final String? applicationName;

  /// Creates an instance from a platform map.
  factory HealthDataOrigin.fromMap(Map<Object?, Object?> map) {
    return HealthDataOrigin(
      packageName: map['packageName'] as String?,
      applicationName: map['applicationName'] as String?,
    );
  }

  /// Serializes to a platform map.
  Map<String, Object?> toMap() => {
        'packageName': packageName,
        'applicationName': applicationName,
      };

  @override
  String toString() =>
      'HealthDataOrigin(packageName: $packageName, applicationName: $applicationName)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HealthDataOrigin &&
          packageName == other.packageName &&
          applicationName == other.applicationName;

  @override
  int get hashCode => Object.hash(packageName, applicationName);
}
