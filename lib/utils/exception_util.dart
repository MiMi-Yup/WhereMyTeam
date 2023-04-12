import 'alert_util.dart';
import 'app_exception.dart';

class ExceptionUtil {
  static void handle(e) {
    AlertUtil.hideLoading();
    if (e is AppException) {
      // error from UI
      if (e.message != null) {
        AlertUtil.showToast(e.message!);
      }
    } else {
      //maybe server error
      if (e.message != null) {
        AlertUtil.showToast(e.message!);
      }
    }
  }
}
