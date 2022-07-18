import 'package:truvideo_enterprise/widget/common/dialog/widget.dart';

class CustomDialogController {
  CustomDialogWidgetState? _state;

  attach(CustomDialogWidgetState? state) {
    _state = state;
  }

  close({dynamic result}) async {
    await _state?.close(result: result);
  }

  bool get isLoading => _state?.isLoading ?? false;

  setLoading(bool loading) {
    _state?.setLoading(loading);
  }

  refresh() {
    // ignore: invalid_use_of_protected_member
    _state?.setState(() {});
  }
}
