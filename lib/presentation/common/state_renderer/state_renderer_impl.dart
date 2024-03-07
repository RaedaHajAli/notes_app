// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:fullnoteapp/presentation/common/state_renderer/state_renderer.dart';

import '../../../app/constants.dart';
import '../../resources/strings_manager.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();
  String getMessage();
}

// Loading State (popup , full screen)
class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String? message;
  LoadingState({
    required this.stateRendererType,
   String message = AppStrings.loading,
  });
  @override
  String getMessage() => message ?? AppStrings.loading;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

//Error states (popup , full screen)

class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;
  ErrorState(
    this.stateRendererType,
    this.message,
  );
  @override
  String getMessage() =>message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}
//Content state

class ContentState extends FlowState {
  ContentState();

  @override
  String getMessage() => Constants.empty;

  @override
  StateRendererType getStateRendererType() => StateRendererType.contentState;
}
//Empty state (full screen)

class EmptyState extends FlowState {
  String message;
  EmptyState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.fullScreenEmptyState;
}


//Success State
class SuccessState extends FlowState {

  String message;
  SuccessState(
 
    this.message,
  );
  @override
  String getMessage() =>message;

  @override
  StateRendererType getStateRendererType() => StateRendererType.popupSuccessState;
}


// extension
extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreenWidget,
      Function retryActionFunction) {
    switch (runtimeType) {
      case LoadingState:
        if (getStateRendererType() == StateRendererType.popupLoadingState) {
          //show pop up loading
          //also the screen content is displayed
          showPopup(context, getStateRendererType(), getMessage());
          return contentScreenWidget;
        } else {
          //full screen Loading state
          return StateRenderer(
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              retryActionFunction: retryActionFunction);
        }
      case ErrorState:
       dismissDialog(context);
        if (getStateRendererType() == StateRendererType.popupErrorState) {
         
          showPopup(context, getStateRendererType(), getMessage());
          return contentScreenWidget;
        } else {
            //full screen Error state
          return StateRenderer(
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              retryActionFunction: retryActionFunction);

        }

      case ContentState:
        dismissDialog(context);
        return contentScreenWidget;
      case SuccessState:
       dismissDialog(context);
        showPopup(context, getStateRendererType(), getMessage());
          return contentScreenWidget; 


      default:
        dismissDialog(context);
        return contentScreenWidget;
    }
  }

  _isCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;
  dismissDialog(BuildContext context) {
    if (_isCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

  showPopup(BuildContext context, StateRendererType stateRendererType,
      String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) => showDialog(
        context: context,
        builder: (BuildContext context) => StateRenderer(
            stateRendererType: stateRendererType,
            message: message,
            retryActionFunction: () {})));
  }
}
