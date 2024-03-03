import 'package:devtools_extensions/devtools_extensions.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const KeyframeDevToolsExtension());
}

class KeyframeDevToolsExtension extends StatefulWidget {
  const KeyframeDevToolsExtension({super.key});

  @override
  State<KeyframeDevToolsExtension> createState() => _KeyframeDevToolsExtensionState();
}

class _KeyframeDevToolsExtensionState extends State<KeyframeDevToolsExtension> {
  var text = 'vamo que vamo';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      serviceManager
          .service //
          ?.onExtensionEvent
          .where((e) => e.extensionKind?.startsWith('ext.keyframe') ?? false)
          .listen((event) {
        setState(() {
          text = '$event';
        });
      });
    });

    // registerExtension('ext.keyframe', (method, parameters) async {
    //   setState(() {
    //     text = '$method: $parameters';
    //   });

    //   return ServiceExtensionResponse.result(jsonEncode({'result': 'Hello from Keyframe!'}));
    // });
  }

  @override
  Widget build(BuildContext context) {
    return DevToolsExtension(
      child: Material(
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }
}
