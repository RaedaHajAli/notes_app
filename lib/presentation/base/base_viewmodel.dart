abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModelOutputs {
  @override
  void start() {
    
  }
  @override
  void dispose() {
    
  }

 
}

abstract class BaseViewModelInputs {
  void start();
  void dispose();

}

mixin BaseViewModelOutputs {
  
}
