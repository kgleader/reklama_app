import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingService {
  void showLoading(BuildContext context) {
    showDialog(
      context: context,
      builder: (conbtext) {
        return const CupertinoAlertDialog(
          title: Text('Жүктөлүп жатат'),
          content: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: CupertinoActivityIndicator(
                radius: 20,
                color: Colors.blue,
              ),
            ),
          ),
        );
      },
    );
  }
}
