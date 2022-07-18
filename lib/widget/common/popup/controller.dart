import 'widget.dart';

class CustomPopupController {
  CustomPopupWidgetState? _state;

  attach(CustomPopupWidgetState? state) {
    _state = state;
  }

  close() async {
    await _state?.close();
  }

  refresh() {
    // ignore: invalid_use_of_protected_member
    _state?.setState(() {});
  }
}
