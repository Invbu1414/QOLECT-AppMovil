import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

import 'whatsapp_fab_model.dart';
export 'whatsapp_fab_model.dart';

class WhatsappFabWidget extends StatefulWidget {
  const WhatsappFabWidget({super.key});

  @override
  State<WhatsappFabWidget> createState() => _WhatsappFabWidgetState();
}

class _WhatsappFabWidgetState extends State<WhatsappFabWidget> {
  late WhatsappFabModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => WhatsappFabModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        print('FloatingActionButton pressed ...');
      },
      backgroundColor: Color(0x004078A8),
      elevation: 8.0,
      child: Align(
        alignment: AlignmentDirectional(0.75, 0.0),
        child: InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            await actions.launchInBrowser(
              'https://api.whatsapp.com/send?phone=+573018119374&text=Hola%2C%20quiero%20armar%20mi%20plan%20de%20vacaciones%20%F0%9F%9B%AB.%0AViajo%20desde%20(Ingresa%20lugar%20de%20salida)%2C%20hac%C3%ADa%20(Ingresa%20lugar%20de%20destino)%20%F0%9F%98%8E',
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              'assets/images/Group_48.png',
              width: 60.0,
              height: 60.0,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
