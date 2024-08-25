import 'package:flutter_easyloading/flutter_easyloading.dart';

void showLoading() {
  EasyLoading.show(
    status: 'loading...',
    maskType: EasyLoadingMaskType.black,
  );
}

void dismissLoading() {
  EasyLoading.dismiss();
}
