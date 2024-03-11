
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


import '../../resources/color_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/images_manager.dart';
enum StateRendererType {
  // pop up states (Dialog)
  popupLoadingState,
  popupErrorState,
  popupSuccessState,

  // full screen states (fullscreen)
  fullScreenLoadingState,
  fullScreenErrorState,
  fullScreenEmptyState,

  //general states
  contentState
}

class StateRenderer extends StatelessWidget {
  final StateRendererType stateRendererType;
  final String message;
  final Function retryActionFunction;

  const StateRenderer(
      {required this.stateRendererType,
      this.message = AppStrings.loading,
      required this.retryActionFunction});

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(BuildContext context) {
    switch (stateRendererType) {
      case StateRendererType.popupLoadingState:
        return _getPopupDialog([_getAnimatedImage(JsonAssets.loading)]);
      case StateRendererType.popupErrorState:
        return _getPopupDialog([
          _getAnimatedImage(JsonAssets.error),
          _getMessage(message),
          _getRetryButton(AppStrings.ok, context)
        ]);
        case StateRendererType.popupSuccessState:
         return _getPopupDialog([
          _getAnimatedImage(JsonAssets.success),
          _getMessage(AppStrings.success),
          _getMessage(message),
          _getRetryButton(AppStrings.ok, context)
        ]);
      case StateRendererType.fullScreenLoadingState:
        return _getFullScreenContent(
            [_getAnimatedImage(JsonAssets.loading), _getMessage(message)]);
      case StateRendererType.fullScreenErrorState:
        return _getFullScreenContent([
          _getAnimatedImage(JsonAssets.error),
          _getMessage(message),
          _getRetryButton(AppStrings.tryAgain, context)
        ]);
      case StateRendererType.fullScreenEmptyState:
        return _getFullScreenContent([
          _getAnimatedImage(JsonAssets.empty),
          _getMessage(message),
        ]);
      case StateRendererType.contentState:
        return Container();

      
      default:
        return Container();
    }
  }

  Widget _getFullScreenContent(List<Widget> children) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getAnimatedImage(String animationName) {
    return SizedBox(
        height: 100,
        width: 100,
        child: Lottie.asset(animationName));
  }

  Widget _getMessage(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          message,
          style:const TextStyle(color: AppColor.deepPurple,fontSize: 18,)
         
        ),
      ),
    );
  }

  Widget _getRetryButton(String buttonTitle, BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
               style: const ButtonStyle(
                backgroundColor:MaterialStatePropertyAll(AppColor.pink)
                // 
               ),  
                onPressed: () {
                  if (stateRendererType ==
                      StateRendererType.fullScreenErrorState) {
                    // call retry function
                    retryActionFunction.call();
                  } else {
                    //pop up error state
                    Navigator.of(context).pop();
                  }
                },
                child: Text(buttonTitle))),
      ),
    );
  }

  Widget _getPopupDialog(List<Widget> children) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      elevation: 1.5,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            color: AppColor.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [const BoxShadow(color: Colors.black)]),
        child: _getDialogContent(children),
      ),
    );
  }

  Widget _getDialogContent(List<Widget> children) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }
}
