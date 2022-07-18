import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:truvideo_enterprise/service/support/_interface.dart';

class AutoHealthCheckDialog extends StatefulWidget {
  final Function? onFinish;
  const AutoHealthCheckDialog({this.onFinish, Key? key}) : super(key: key);

  @override
  State<AutoHealthCheckDialog> createState() => _AutoHealthStateCheckDialog();
}

class _AutoHealthStateCheckDialog extends State<AutoHealthCheckDialog> {
  String status = '';
  bool loading = true;
  @override
  void initState() {
    sendHealthCheck();
    super.initState();
  }

  Future<void> sendHealthCheck() async {
    SupportService service = GetIt.I.get();
    await service.autoSendInfo(
      onProgressChange: (newStatus) => setState(() {
        status = newStatus;
      }),
    );
    if (widget.onFinish != null) widget.onFinish!();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(status),
        const SizedBox(
          width: 15,
        ),
        if (loading) const CircularProgressIndicator()
      ],
    );
  }
}
