import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showLoading({required BuildContext context}){
  showDialog(barrierDismissible: false,context: context, builder: (BuildContext context){

    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        alignment: AlignmentDirectional.center,
        decoration: const BoxDecoration(),
        child: const Center(
          child:SizedBox(
            height: 70,
            width: 70,
            child: CircularProgressIndicator(strokeWidth: 6,),
          ),
        ),
      ),
    );
  });
}

void hideLoading({required BuildContext? dialogContext})async{
  if(dialogContext != null) Navigator.pop(dialogContext);
}