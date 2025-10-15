import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/loading/loading_widget.dart';
import '/components/usuario_error/usuario_error_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'login_page_model.dart';
export 'login_page_model.dart';

class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({super.key});

  static String routeName = 'login_page';
  static String routePath = '/login';

  @override
  State<LoginPageWidget> createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  late LoginPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoginPageModel());

    _model.textController1 ??= TextEditingController();
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??= TextEditingController();
    _model.textFieldFocusNode2 ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: PopScope(
        canPop: false,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          body: Stack(
            children: [
              // Overlay sutil para mejorar legibilidad del texto
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        FlutterFlowTheme.of(context).primaryDark,
                        FlutterFlowTheme.of(context).primary,
                        Colors.white,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.center,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  'assets/images/background_login11.png',
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.bottomCenter,
                ),
              ),
              SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      fit: FlexFit.loose,
                      child: Container(
                        width: 439.0,
                        child: Stack(
                          children: [
                            Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: SingleChildScrollView(
                                primary: false,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/LOGO_3.png',
                                      fit: BoxFit.contain,
                                      alignment: Alignment.center,
                                    ),

                                    // TextFiled Correo
                                    Container(
                                      width: double.infinity,
                                      constraints: const BoxConstraints(
                                          minHeight: 100.0),
                                      decoration: const BoxDecoration(
                                        color: Color(0x00FFFFFF),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(16.0, 12.0, 16.0, 0.0),
                                        child: Container(
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(
                                                16.0, 12.0, 16.0, 0.0),
                                            child: TextFormField(
                                              controller:
                                                  _model.textController1,
                                              focusNode:
                                                  _model.textFieldFocusNode1,
                                              onChanged: (_) =>
                                                  EasyDebounce.debounce(
                                                '_model.textController1',
                                                const Duration(
                                                    milliseconds: 2000),
                                                () => safeSetState(() {}),
                                              ),
                                              autofocus: false,
                                              obscureText: false,
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              textInputAction:
                                                  TextInputAction.next,
                                              autofillHints: const [
                                                AutofillHints.email
                                              ],
                                              enableSuggestions: false,
                                              autocorrect: false,
                                              maxLines: 1,
                                              decoration: InputDecoration(
                                                isDense: true,
                                                labelText: 'Correo',
                                                labelStyle: FlutterFlowTheme.of(
                                                        context)
                                                    .labelLarge
                                                    .override(
                                                      font: GoogleFonts.fredoka(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelLarge
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelLarge
                                                                .fontStyle,
                                                      ),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryDark,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelLarge
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelLarge
                                                              .fontStyle,
                                                    ),
                                                hintText:
                                                    'Ingresa tu correo electrónico',
                                                hintStyle: FlutterFlowTheme.of(
                                                        context)
                                                    .labelMedium
                                                    .override(
                                                      font: GoogleFonts.fredoka(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontStyle,
                                                      ),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryDark,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .fontStyle,
                                                    ),
                                                prefixIcon: Icon(
                                                  Icons.alternate_email_rounded,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryDark,
                                                ),
                                                suffixIcon: AnimatedSwitcher(
                                                  duration: const Duration(
                                                      milliseconds: 200),
                                                  child: (_model.textController1
                                                          .text.isNotEmpty)
                                                      ? Icon(
                                                          Icons.check_circle,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryDark,
                                                        )
                                                      : const SizedBox.shrink(),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          24.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryDark,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          24.0),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          24.0),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          24.0),
                                                ),
                                                filled: true,
                                                fillColor:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground
                                                        .withOpacity(0.9),
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 18.0,
                                                  vertical: 18.0,
                                                ),
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    font: GoogleFonts.fredoka(
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryDark,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                              validator: _model
                                                  .textController1Validator
                                                  .asValidator(context),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    // TextField Contraseña
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      child: Container(
                                        width: double.infinity,
                                        decoration: const BoxDecoration(
                                          color: Color(0x00FFFFFF),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(16.0, 0.0, 16.0, 12.0),
                                          child: Container(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      16.0, 12.0, 16.0, 12.0),
                                              child: TextFormField(
                                                controller:
                                                    _model.textController2,
                                                focusNode:
                                                    _model.textFieldFocusNode2,
                                                autofocus: false,
                                                obscureText:
                                                    !_model.passwordVisibility,
                                                keyboardType: TextInputType
                                                    .visiblePassword,
                                                textInputAction:
                                                    TextInputAction.done,
                                                autofillHints: const [
                                                  AutofillHints.password
                                                ],
                                                enableSuggestions: false,
                                                autocorrect: false,
                                                maxLines: 1,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  labelText: 'Contraseña',
                                                  labelStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .labelLarge
                                                      .override(
                                                        font:
                                                            GoogleFonts.fredoka(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelLarge
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelLarge
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryDark,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelLarge
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelLarge
                                                                .fontStyle,
                                                      ),
                                                  hintText:
                                                      'Ingresa tu contraseña',
                                                  hintStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .labelMedium
                                                      .override(
                                                        font:
                                                            GoogleFonts.fredoka(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryDark,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontStyle,
                                                      ),
                                                  prefixIcon: Icon(
                                                    Icons.lock_rounded,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryDark,
                                                  ),
                                                  suffixIcon: InkWell(
                                                    onTap: () => safeSetState(
                                                      () => _model
                                                              .passwordVisibility =
                                                          !_model
                                                              .passwordVisibility,
                                                    ),
                                                    focusNode: FocusNode(
                                                        skipTraversal: true),
                                                    child: Icon(
                                                      _model.passwordVisibility
                                                          ? Icons
                                                              .visibility_outlined
                                                          : Icons
                                                              .visibility_off_outlined,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryDark,
                                                      size: 19.0,
                                                    ),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                      color: Colors.transparent,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            24.0),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryDark,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            24.0),
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .error,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            24.0),
                                                  ),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .error,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            24.0),
                                                  ),
                                                  filled: true,
                                                  fillColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryBackground
                                                          .withOpacity(0.9),
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                    horizontal: 18.0,
                                                    vertical: 18.0,
                                                  ),
                                                ),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      font: GoogleFonts.fredoka(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                validator: _model
                                                    .textController2Validator
                                                    .asValidator(context),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 24.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      20.0, 0.0, 20.0, 0.0),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  GoRouter.of(context)
                                                      .prepareAuthEvent();
                                                  final user = await authManager
                                                      .signInWithGoogle(
                                                          context);
                                                  if (user == null) {
                                                    return;
                                                  }
                                                  _model.apiResultLoginWordPress =
                                                      await WordPressLoginCall
                                                          .call(
                                                    username: currentUserEmail,
                                                    password: currentUserEmail,
                                                  );

                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Procesando tu solicitud...',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                        ),
                                                      ),
                                                      duration: Duration(
                                                          milliseconds: 4000),
                                                      backgroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                    ),
                                                  );
                                                  if ((_model
                                                          .apiResultLoginWordPress
                                                          ?.succeeded ??
                                                      true)) {
                                                    FFAppState().token =
                                                        getJsonField(
                                                      (_model.apiResultLoginWordPress
                                                              ?.jsonBody ??
                                                          ''),
                                                      r'''$.token''',
                                                    ).toString();
                                                    FFAppState().userSessionID =
                                                        getJsonField(
                                                      (_model.apiResultLoginWordPress
                                                              ?.jsonBody ??
                                                          ''),
                                                      r'''$.id''',
                                                    );
                                                    FFAppState().userEmail =
                                                        getJsonField(
                                                      (_model.apiResultLoginWordPress
                                                              ?.jsonBody ??
                                                          ''),
                                                      r'''$.user_email''',
                                                    ).toString();
                                                    safeSetState(() {});

                                                    context.pushNamedAuth(
                                                        HomePageWidget
                                                            .routeName,
                                                        context.mounted);

                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          'Usuario logueado con exito',
                                                          style: TextStyle(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                          ),
                                                        ),
                                                        duration: Duration(
                                                            milliseconds: 4000),
                                                        backgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                      ),
                                                    );
                                                  } else {
                                                    _model.resultApiLoginAdmin =
                                                        await WordPressLoginCall
                                                            .call(
                                                      username: 'Admin API',
                                                      password: '@Sense2025',
                                                    );

                                                    _model.apiResultRegisterWordPress =
                                                        await WordPRessRegisterUserCall
                                                            .call(
                                                      username:
                                                          currentUserEmail,
                                                      email: currentUserEmail,
                                                      password:
                                                          currentUserEmail,
                                                      token: getJsonField(
                                                        (_model.resultApiLoginAdmin
                                                                ?.jsonBody ??
                                                            ''),
                                                        r'''$.token''',
                                                      ).toString(),
                                                    );

                                                    if ((_model
                                                            .apiResultRegisterWordPress
                                                            ?.succeeded ??
                                                        true)) {
                                                      _model.apiResultLoginAfterRegister =
                                                          await WordPressLoginCall
                                                              .call(
                                                        username:
                                                            currentUserEmail,
                                                        password:
                                                            currentUserEmail,
                                                      );

                                                      if ((_model
                                                              .apiResultLoginAfterRegister
                                                              ?.succeeded ??
                                                          true)) {
                                                        FFAppState().token =
                                                            getJsonField(
                                                          (_model.apiResultLoginAfterRegister
                                                                  ?.jsonBody ??
                                                              ''),
                                                          r'''$.token''',
                                                        ).toString();
                                                        FFAppState()
                                                                .userSessionID =
                                                            getJsonField(
                                                          (_model.apiResultLoginAfterRegister
                                                                  ?.jsonBody ??
                                                              ''),
                                                          r'''$.id''',
                                                        );
                                                        FFAppState().userEmail =
                                                            getJsonField(
                                                          (_model.apiResultLoginAfterRegister
                                                                  ?.jsonBody ??
                                                              ''),
                                                          r'''$.user_email''',
                                                        ).toString();
                                                        safeSetState(() {});

                                                        context.pushNamedAuth(
                                                            HomePageWidget
                                                                .routeName,
                                                            context.mounted);

                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                              'Usuartio logueado con exito',
                                                              style: TextStyle(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                              ),
                                                            ),
                                                            duration: Duration(
                                                                milliseconds:
                                                                    4000),
                                                            backgroundColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                          ),
                                                        );
                                                      } else {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                              'El usuario se ha registrado pero no ha iniciado sesión',
                                                              style: TextStyle(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                              ),
                                                            ),
                                                            duration: Duration(
                                                                milliseconds:
                                                                    4000),
                                                            backgroundColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                          ),
                                                        );
                                                      }
                                                    } else {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                            'Hubo un problema al registar al usuario',
                                                            style: TextStyle(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                            ),
                                                          ),
                                                          duration: Duration(
                                                              milliseconds:
                                                                  4000),
                                                          backgroundColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primary,
                                                        ),
                                                      );
                                                    }
                                                  }

                                                  safeSetState(() {});
                                                },
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  child: Image.asset(
                                                    'assets/images/Group_19.png',
                                                    width: 68.0,
                                                    height: 68.0,
                                                    fit: BoxFit.cover,
                                                    alignment:
                                                        Alignment(0.0, 0.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            if (!isAndroid)
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        20.0, 0.0, 20.0, 0.0),
                                                child: InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    var _shouldSetState = false;
                                                    GoRouter.of(context)
                                                        .prepareAuthEvent();
                                                    final user =
                                                        await authManager
                                                            .signInWithApple(
                                                                context);
                                                    if (user == null) {
                                                      return;
                                                    }
                                                    FFAppState()
                                                            .isActionComplete =
                                                        true;
                                                    safeSetState(() {});
                                                    _model.apiLoginAppleResponse =
                                                        await WordPressLoginCall
                                                            .call(
                                                      username:
                                                          currentUserEmail,
                                                      password: valueOrDefault<
                                                          String>(
                                                        '${currentUserUid}@%',
                                                        'passwordG',
                                                      ),
                                                    );

                                                    _shouldSetState = true;
                                                    if ((_model.apiLoginAppleResponse
                                                                ?.statusCode ??
                                                            200) ==
                                                        200) {
                                                      _model.getUserVerfiedApple =
                                                          await WordPressUserCall
                                                              .call(
                                                        token:
                                                            WordPressLoginCall
                                                                .token(
                                                          (_model.apiLoginAppleResponse
                                                                  ?.jsonBody ??
                                                              ''),
                                                        )?.firstOrNull,
                                                        author:
                                                            WordPressLoginCall
                                                                    .id(
                                                          (_model.apiLoginAppleResponse
                                                                  ?.jsonBody ??
                                                              ''),
                                                        )
                                                                ?.firstOrNull
                                                                ?.toString(),
                                                      );

                                                      _shouldSetState = true;
                                                      if (WordPressUserCall
                                                              .verificado(
                                                            (_model.getUserVerfiedApple
                                                                    ?.jsonBody ??
                                                                ''),
                                                          ) ==
                                                          true) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                              'Entraste como ${currentUserEmail}',
                                                              style: TextStyle(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                              ),
                                                            ),
                                                            duration: Duration(
                                                                milliseconds:
                                                                    4000),
                                                            backgroundColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondary,
                                                          ),
                                                        );
                                                      } else {
                                                        _model.loginDemoAVerified =
                                                            await WordPressLoginCall
                                                                .call(
                                                          username:
                                                              'Qolect Admin',
                                                          password:
                                                              '@QolectAdmin2023..',
                                                        );

                                                        _shouldSetState = true;
                                                        if ((_model.loginDemoAVerified
                                                                    ?.statusCode ??
                                                                200) ==
                                                            200) {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: Text(
                                                                'Tu cuenta, no está verificada',
                                                                style:
                                                                    TextStyle(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                ),
                                                              ),
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      4000),
                                                              backgroundColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondary,
                                                            ),
                                                          );
                                                        } else {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: Text(
                                                                'El usuario demo está deshabilitado',
                                                                style:
                                                                    TextStyle(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                ),
                                                              ),
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      4000),
                                                              backgroundColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondary,
                                                            ),
                                                          );
                                                          if (_shouldSetState)
                                                            safeSetState(() {});
                                                          return;
                                                        }

                                                        FFAppState().token =
                                                            WordPressLoginCall
                                                                    .token(
                                                          (_model.loginDemoAVerified
                                                                  ?.jsonBody ??
                                                              ''),
                                                        )!
                                                                .firstOrNull!;
                                                        FFAppState()
                                                                .userSessionID =
                                                            WordPressLoginCall
                                                                    .id(
                                                          (_model.loginDemoAVerified
                                                                  ?.jsonBody ??
                                                              ''),
                                                        )!
                                                                .firstOrNull!;
                                                        FFAppState().userEmail =
                                                            WordPressLoginCall
                                                                    .email(
                                                          (_model.loginDemoAVerified
                                                                  ?.jsonBody ??
                                                              ''),
                                                        )!
                                                                .firstOrNull!;
                                                        safeSetState(() {});
                                                        FFAppState()
                                                                .isActionComplete =
                                                            false;
                                                        safeSetState(() {});

                                                        context.pushNamedAuth(
                                                            HomePageWidget
                                                                .routeName,
                                                            context.mounted);

                                                        if (_shouldSetState)
                                                          safeSetState(() {});
                                                        return;
                                                      }

                                                      FFAppState()
                                                              .userSessionID =
                                                          WordPressLoginCall.id(
                                                        (_model.apiLoginAppleResponse
                                                                ?.jsonBody ??
                                                            ''),
                                                      )!
                                                              .firstOrNull!;
                                                      FFAppState().token =
                                                          WordPressLoginCall
                                                                  .token(
                                                        (_model.apiLoginAppleResponse
                                                                ?.jsonBody ??
                                                            ''),
                                                      )!
                                                              .firstOrNull!;
                                                      FFAppState().userEmail =
                                                          WordPressLoginCall
                                                                  .email(
                                                        (_model.apiLoginAppleResponse
                                                                ?.jsonBody ??
                                                            ''),
                                                      )!
                                                              .firstOrNull!;
                                                      safeSetState(() {});
                                                      FFAppState()
                                                              .isActionComplete =
                                                          false;
                                                      safeSetState(() {});
                                                    } else {
                                                      _model.loginDemoApple =
                                                          await WordPressLoginCall
                                                              .call(
                                                        username:
                                                            'Qolect Admin',
                                                        password:
                                                            '@QolectAdmin2023..',
                                                      );

                                                      _shouldSetState = true;
                                                      _model.registerUserApple =
                                                          await WordPRessRegisterUserCall
                                                              .call(
                                                        username:
                                                            currentUserEmail,
                                                        password:
                                                            '${currentUserUid}@%',
                                                        email: currentUserEmail,
                                                        token:
                                                            WordPressLoginCall
                                                                .token(
                                                          (_model.loginDemoApple
                                                                  ?.jsonBody ??
                                                              ''),
                                                        )?.firstOrNull,
                                                      );

                                                      _shouldSetState = true;
                                                      if ((_model.loginDemoApple
                                                                  ?.statusCode ??
                                                              200) ==
                                                          200) {
                                                        FFAppState().token =
                                                            WordPressLoginCall
                                                                    .token(
                                                          (_model.loginDemoApple
                                                                  ?.jsonBody ??
                                                              ''),
                                                        )!
                                                                .firstOrNull!;
                                                        FFAppState()
                                                                .userSessionID =
                                                            WordPressLoginCall
                                                                    .id(
                                                          (_model.loginDemoApple
                                                                  ?.jsonBody ??
                                                              ''),
                                                        )!
                                                                .firstOrNull!;
                                                        FFAppState().userEmail =
                                                            WordPressLoginCall
                                                                    .email(
                                                          (_model.loginDemoApple
                                                                  ?.jsonBody ??
                                                              ''),
                                                        )!
                                                                .firstOrNull!;
                                                        safeSetState(() {});
                                                      } else {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                              'El usuario demo está deshabilitado',
                                                              style: TextStyle(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                              ),
                                                            ),
                                                            duration: Duration(
                                                                milliseconds:
                                                                    4000),
                                                            backgroundColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondary,
                                                          ),
                                                        );
                                                        FFAppState()
                                                                .isActionComplete =
                                                            false;
                                                        safeSetState(() {});
                                                        if (_shouldSetState)
                                                          safeSetState(() {});
                                                        return;
                                                      }

                                                      FFAppState()
                                                              .isActionComplete =
                                                          false;
                                                      safeSetState(() {});
                                                    }

                                                    context.pushNamedAuth(
                                                        HomePageWidget
                                                            .routeName,
                                                        context.mounted);

                                                    if (_shouldSetState)
                                                      safeSetState(() {});
                                                  },
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    child: Image.asset(
                                                      'assets/images/Group_20_(1).png',
                                                      width: 68.0,
                                                      height: 68.0,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    //Botón Login
                                    Builder(
                                      builder: (context) => Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(32.0, 0.0, 32.0, 16.0),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: FFButtonWidget(
                                            onPressed: () async {
                                              var _shouldSetState = false;
                                              _model.apiLoginResult =
                                                  await WordPressLoginCall.call(
                                                username:
                                                    _model.textController1.text,
                                                password:
                                                    _model.textController2.text,
                                              );

                                              _shouldSetState = true;
                                              if ((_model.apiLoginResult
                                                              ?.statusCode ??
                                                          200)
                                                      .toString() ==
                                                  '200') {
                                                context.goNamed(
                                                  HomePageWidget.routeName,
                                                  extra: <String, dynamic>{
                                                    kTransitionInfoKey:
                                                        TransitionInfo(
                                                      hasTransition: true,
                                                      transitionType:
                                                          PageTransitionType
                                                              .fade,
                                                      duration: Duration(
                                                          milliseconds: 500),
                                                    ),
                                                  },
                                                );
                                              } else {
                                                await showDialog(
                                                  context: context,
                                                  builder: (dialogContext) {
                                                    return Dialog(
                                                      elevation: 0,
                                                      insetPadding:
                                                          EdgeInsets.zero,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      alignment:
                                                          AlignmentDirectional(
                                                                  0.0, 0.0)
                                                              .resolve(
                                                                  Directionality.of(
                                                                      context)),
                                                      child: WebViewAware(
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            FocusScope.of(
                                                                    dialogContext)
                                                                .unfocus();
                                                            FocusManager
                                                                .instance
                                                                .primaryFocus
                                                                ?.unfocus();
                                                          },
                                                          child:
                                                              UsuarioErrorWidget(),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );

                                                if (_shouldSetState)
                                                  safeSetState(() {});
                                                return;
                                              }

                                              FFAppState().userSessionID =
                                                  WordPressLoginCall.id(
                                                (_model.apiLoginResult
                                                        ?.jsonBody ??
                                                    ''),
                                              )!
                                                      .firstOrNull!;
                                              FFAppState().userEmail =
                                                  WordPressLoginCall.email(
                                                (_model.apiLoginResult
                                                        ?.jsonBody ??
                                                    ''),
                                              )!
                                                      .firstOrNull!;
                                              FFAppState().token =
                                                  WordPressLoginCall.token(
                                                (_model.apiLoginResult
                                                        ?.jsonBody ??
                                                    ''),
                                              )!
                                                      .firstOrNull!;
                                              safeSetState(() {});
                                              if (_shouldSetState)
                                                safeSetState(() {});
                                            },
                                            text: 'INICIAR SESIÓN',
                                            icon: const Icon(
                                              Icons.login_rounded,
                                              color: Colors.white,
                                              size: 20.0,
                                            ),
                                            options: FFButtonOptions(
                                              width: double.infinity,
                                              height: 52.0,
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      20.0, 0.0, 20.0, 0.0),
                                              iconPadding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      0.0, 0.0, 8.0, 0.0),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .warning,
                                              textStyle: FlutterFlowTheme.of(
                                                      context)
                                                  .titleSmall
                                                  .override(
                                                    font: GoogleFonts.fredoka(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .fontStyle,
                                                    ),
                                                    color: Colors.white,
                                                    fontSize: 15.0,
                                                    letterSpacing: 0.2,
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleSmall
                                                            .fontStyle,
                                                  ),
                                              elevation: 6.0,
                                              borderSide: const BorderSide(
                                                color: Colors.transparent,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(28.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    //Botón olvidaste tu contraseña
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 10.0, 0.0, 0.0),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          context.pushNamed(
                                              RestablecePageWidget.routeName);
                                        },
                                        child: Text(
                                          '¿Olvidaste tu contraseña?',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.fredoka(
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryDark,
                                                fontSize: 13.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.normal,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                      ),
                                    ),

                                    // Boton registrate
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 10.0, 0.0, 24.0),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          context.pushNamed(
                                              RegistrarUsuarioPageWidget
                                                  .routeName);
                                        },
                                        child: Text(
                                          '¿No tienes cuenta? Registrate',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.fredoka(
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryDark,
                                                fontSize: 13.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.normal,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                      ),
                                    ),

                                    // Button Explora la app
                                    FFButtonWidget(
                                      onPressed: () async {
                                        var _shouldSetState = false;
                                        _model.loginDemo =
                                            await WordPressLoginCall.call(
                                          username: 'demo@app.qolect.co',
                                          password: '@Sense2025',
                                        );

                                        _shouldSetState = true;
                                        if ((_model.loginDemo?.statusCode ??
                                                200) ==
                                            200) {
                                          FFAppState().token =
                                              WordPressLoginCall.token(
                                            (_model.loginDemo?.jsonBody ?? ''),
                                          )!
                                                  .firstOrNull!;
                                          FFAppState().userSessionID =
                                              WordPressLoginCall.id(
                                            (_model.loginDemo?.jsonBody ?? ''),
                                          )!
                                                  .firstOrNull!;
                                          FFAppState().userEmail =
                                              WordPressLoginCall.email(
                                            (_model.loginDemo?.jsonBody ?? ''),
                                          )!
                                                  .firstOrNull!;
                                          safeSetState(() {});
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'El usuario demo está deshabilitado',
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                ),
                                              ),
                                              duration:
                                                  Duration(milliseconds: 4000),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondary,
                                            ),
                                          );
                                          if (_shouldSetState)
                                            safeSetState(() {});
                                          return;
                                        }

                                        context.pushNamed(
                                            HomePageWidget.routeName);

                                        if (_shouldSetState)
                                          safeSetState(() {});
                                      },
                                      text: 'EXPLORA LA APP',
                                      options: FFButtonOptions(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.5,
                                        height: 40.0,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 0.0, 16.0, 0.0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color: Colors.transparent,
                                        elevation: 0.0,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              font: GoogleFonts.fredoka(
                                                fontWeight: FontWeight.w600,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              fontSize: 13.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .fontStyle,
                                            ),
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (FFAppState().isActionComplete)
                wrapWithModel(
                  model: _model.loadingModel,
                  updateCallback: () => safeSetState(() {}),
                  child: LoadingWidget(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
