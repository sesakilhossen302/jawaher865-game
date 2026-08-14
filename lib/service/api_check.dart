import 'package:http/http.dart' as http;
import '../Utils/ToastMessage/toast_message.dart';

class ApiCheck {
  static bool isSuccess(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return true;
    } else {
      _handleError(response.statusCode);
      return false;
    }
  }

  static void _handleError(int statusCode) {
    switch (statusCode) {
      case 400:
        ToastMessage.showErrorToast('Bad Request');
        break;
      case 401:
        ToastMessage.showErrorToast('Unauthorized access');
        break;
      case 403:
        ToastMessage.showErrorToast('Forbidden');
        break;
      case 404:
        ToastMessage.showErrorToast('Resource not found');
        break;
      case 500:
        ToastMessage.showErrorToast('Internal Server Error');
        break;
      default:
        ToastMessage.showErrorToast('Error occurred: $statusCode');
    }
  }
}
