import 'widget.dart';

class CustomBottomSheetController{
  CustomBottomSheetState? _state;

  attach(CustomBottomSheetState? state){
    _state = state;
  }

  Future<void> close()async{
    await _state?.close();
  }
}