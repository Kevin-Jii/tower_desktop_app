import 'package:flutter/foundation.dart';
import '../../core/network/api_response.dart';
import '../../core/network/base_provider.dart';
import 'dingtalk_api.dart';
import 'models.dart';

class DingTalkProvider extends ChangeNotifier with ListProviderMixin<DingTalkRobot> {
  final DingTalkApi _api;
  DingTalkProvider(this._api);

  List<DingTalkRobot> get robots => items;

  Future<void> loadRobots({int? storeId}) async {
    await loadData(() async {
      try {
        final resp = await _api.list(storeId: storeId);
        return resp.when(
          success: (data) => ApiResponse<List<DingTalkRobot>>(
            code: 200,
            message: 'success',
            data: data,
          ),
          error: (message, statusCode) => ApiResponse<List<DingTalkRobot>>(
            code: statusCode ?? 500,
            message: message,
            data: null,
          ),
        );
      } catch (e, stack) {
        debugPrint('API 异常: $e\n$stack');
        return ApiResponse<List<DingTalkRobot>>(
          code: 500,
          message: '网络请求异常: $e',
          data: null,
        );
      }
    });
  }

  Future<bool> createRobot(CreateDingTalkRobotRequest payload) async {
    final result = await _api.create(payload);
    bool ok = false;

    result.when(
      success: (item) {
        ok = true;
      },
      error: (msg, code) {
        ok = false;
      },
    );

    if (ok) await loadRobots();
    return ok;
  }

  Future<bool> updateRobot(
      DingTalkRobot robot, UpdateDingTalkRobotRequest payload) async {
    final result = await _api.update(robot.id, payload);
    bool ok = false;

    result.when(
      success: (item) {
        ok = true;
      },
      error: (msg, code) {
        ok = false;
      },
    );

    if (ok) await loadRobots();
    return ok;
  }

  Future<bool> deleteRobot(DingTalkRobot robot) async {
    final result = await _api.delete(robot.id);
    bool ok = false;

    result.when(
      success: (_) {
        items.removeWhere((r) => r.id == robot.id);
        notifyListeners();
        ok = true;
      },
      error: (msg, code) {
        ok = false;
      },
    );

    return ok;
  }

  Future<bool> testPush(DingTalkRobot robot) async {
    final result = await _api.testRobot(robot);
    bool ok = false;

    result.when(
      success: (_) {
        notifyListeners();
        ok = true;
      },
      error: (msg, code) {
        ok = false;
      },
    );

    return ok;
  }
}
