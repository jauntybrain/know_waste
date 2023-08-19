import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod/riverpod.dart';

final packageInfoProvider = Provider<PackageInfoService>((ref) => PackageInfoService());

/// Stores information regarding the current device
class PackageInfoService {
  late final PackageInfo _packageInfo;

  String get version => '${_packageInfo.version}+${_packageInfo.buildNumber}';

  /// Logs proper info depending on the platform running the app
  Future<void> init() async {
    _packageInfo = await PackageInfo.fromPlatform();
  }
}
