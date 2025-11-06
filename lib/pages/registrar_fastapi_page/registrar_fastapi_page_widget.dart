import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegistrarFastAPIPageWidget extends StatefulWidget {
  const RegistrarFastAPIPageWidget({super.key});

  static String routeName = 'registrarFastAPI_page';
  static String routePath = '/registerFastAPI';

  @override
  State<RegistrarFastAPIPageWidget> createState() =>
      _RegistrarFastAPIPageWidgetState();
}

class _RegistrarFastAPIPageWidgetState
    extends State<RegistrarFastAPIPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  final _usernameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmFocus = FocusNode();

  bool _passwordVisible = false;
  bool _confirmVisible = false;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();

    _usernameFocus.dispose();
    _emailFocus.dispose();
    _phoneFocus.dispose();
    _passwordFocus.dispose();
    _confirmFocus.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (_isSubmitting) return;

    final email = _emailController.text.trim();
    final username = _usernameController.text.trim();
    final telefono = _phoneController.text.trim();
    final password = _passwordController.text;
    final confirm = _confirmController.text;

    final usernameRegex = RegExp(r'^[a-zA-Z0-9_.]+$');
    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');

    if (username.isEmpty || !usernameRegex.hasMatch(username)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'El usuario debe contener solo letras, números, “_” o “.” y sin espacios',
            style: TextStyle(color: FlutterFlowTheme.of(context).primaryText),
          ),
          backgroundColor: FlutterFlowTheme.of(context).secondary,
        ),
      );
      return;
    }

    if (email.isEmpty || !emailRegex.hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Ingresa un correo válido',
            style: TextStyle(color: FlutterFlowTheme.of(context).primaryText),
          ),
          backgroundColor: FlutterFlowTheme.of(context).secondary,
        ),
      );
      return;
    }

    if (password.isEmpty || password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'La contraseña debe tener al menos 6 caracteres',
            style: TextStyle(color: FlutterFlowTheme.of(context).primaryText),
          ),
          backgroundColor: FlutterFlowTheme.of(context).secondary,
        ),
      );
      return;
    }

    if (password != confirm) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Las contraseñas no son iguales',
            style: TextStyle(color: FlutterFlowTheme.of(context).primaryText),
          ),
          backgroundColor: FlutterFlowTheme.of(context).secondary,
        ),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    final response = await FastAPIRegisterCall.call(
      name: username,
      email: email,
      password: password,
      telefono: telefono.isNotEmpty ? telefono : null,
    );

    setState(() => _isSubmitting = false);

    final status = response.statusCode;
    if (status == 200 || status == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Usuario creado con éxito',
            style: TextStyle(color: FlutterFlowTheme.of(context).primaryText),
          ),
          backgroundColor: FlutterFlowTheme.of(context).secondary,
        ),
      );
      context.pushNamed(LoginPageWidget.routeName);
      return;
    }

    final serverMessage =
        getJsonField((response.jsonBody ?? ''), r'''$.message''')?.toString() ??
            getJsonField((response.jsonBody ?? ''), r'''$.detail''')
                ?.toString() ??
            getJsonField((response.jsonBody ?? ''), r'''$.error''')?.toString();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          (serverMessage?.isNotEmpty == true)
              ? serverMessage!
              : 'El registro ha fallado',
          style: TextStyle(color: FlutterFlowTheme.of(context).primaryText),
        ),
        backgroundColor: FlutterFlowTheme.of(context).secondary,
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    Widget? suffix,
  }) {
    return InputDecoration(
      isDense: true,
      hintText: hint,
      hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
            font: GoogleFonts.fredoka(
              fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
              fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
            ),
            color: FlutterFlowTheme.of(context).secondaryText,
            letterSpacing: 0.0,
          ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: FlutterFlowTheme.of(context).alternate,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(28.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: FlutterFlowTheme.of(context).primary,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(28.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: FlutterFlowTheme.of(context).error,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(28.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: FlutterFlowTheme.of(context).error,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(28.0),
      ),
      filled: true,
      fillColor: FlutterFlowTheme.of(context).secondaryBackground,
      contentPadding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 12.0, 16.0),
      suffixIcon: suffix,
    );
  }

  Widget _buildClearableField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String hint,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
  }) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onTapOutside: (_) {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      decoration: _inputDecoration(
        hint: hint,
        suffix: (controller.text.isNotEmpty && !_isSubmitting)
            ? IconButton(
                icon: Icon(Icons.clear,
                    color: FlutterFlowTheme.of(context).secondaryText),
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  controller.clear();
                  setState(() {});
                },
              )
            : null,
      ),
      style: FlutterFlowTheme.of(context).bodyMedium.override(
            font: GoogleFonts.fredoka(
              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
            ),
            color: FlutterFlowTheme.of(context).primaryText,
            letterSpacing: 0.0,
          ),
      onChanged: (_) => setState(() {}),
      enabled: !_isSubmitting,
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required bool visible,
    required ValueChanged<bool> onVisibilityChanged,
    required String hint,
  }) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      obscureText: !visible,
      onTapOutside: (_) {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      decoration: _inputDecoration(
        hint: hint,
        suffix: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                visible ? Icons.visibility : Icons.visibility_off,
                color: FlutterFlowTheme.of(context).secondaryText,
              ),
              onPressed:
                  _isSubmitting ? null : () => onVisibilityChanged(!visible),
            ),
            if (controller.text.isNotEmpty && !_isSubmitting)
              IconButton(
                icon: Icon(Icons.clear,
                    color: FlutterFlowTheme.of(context).secondaryText),
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  controller.clear();
                  setState(() {});
                },
              ),
          ],
        ),
      ),
      style: FlutterFlowTheme.of(context).bodyMedium.override(
            font: GoogleFonts.fredoka(
              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
            ),
            color: FlutterFlowTheme.of(context).primaryText,
            letterSpacing: 0.0,
          ),
      onChanged: (_) => setState(() {}),
      enabled: !_isSubmitting,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              FlutterFlowTheme.of(context).primaryDark,
              FlutterFlowTheme.of(context).primary,
              FlutterFlowTheme.of(context).primaryAccent,
              Colors.white
            ],
            begin: Alignment.topCenter,
            end: Alignment.center,
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                'assets/images/background_login11.png',
                fit: BoxFit.fitWidth,
                alignment: Alignment.bottomCenter,
              ),
            ),
            Scaffold(
              key: scaffoldKey,
              backgroundColor: Colors.transparent,
              body: SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 440.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                final maxWidth =
                                    constraints.maxWidth == double.infinity
                                        ? MediaQuery.sizeOf(context).width
                                        : constraints.maxWidth;

                                const aspectRatio = 3.5;
                                final width = maxWidth * 0.7;
                                final height = width / aspectRatio;

                                return SizedBox(
                                  width: width,
                                  height: height,
                                  child: Image.asset(
                                    'assets/images/Logo.png',
                                    fit: BoxFit.cover,
                                    alignment: Alignment.center,
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            'Crear cuenta',
                            textAlign: TextAlign.left,
                            style: FlutterFlowTheme.of(context).titleLarge.override(
                                  font: GoogleFonts.fredoka(
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context).primaryText,
                                  letterSpacing: 0.0,
                                ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Regístrate para comenzar',
                            style: FlutterFlowTheme.of(context).labelMedium.override(
                                  font: GoogleFonts.fredoka(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context).secondaryText,
                                  letterSpacing: 0.0,
                                ),
                          ),
                          SizedBox(height: 24.0),

                          // Card contenedor de inputs
                          Card(
                            elevation: 3.0,
                            color: FlutterFlowTheme.of(context).secondaryBackground,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  _buildClearableField(
                                    controller: _usernameController,
                                    focusNode: _usernameFocus,
                                    hint: 'Usuario',
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                  ),
                                  SizedBox(height: 12.0),
                                  _buildClearableField(
                                    controller: _emailController,
                                    focusNode: _emailFocus,
                                    hint: 'Correo electrónico',
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                  ),
                                  SizedBox(height: 12.0),
                                  _buildClearableField(
                                    controller: _phoneController,
                                    focusNode: _phoneFocus,
                                    hint: 'Teléfono (opcional)',
                                    keyboardType: TextInputType.phone,
                                    textInputAction: TextInputAction.next,
                                  ),
                                  SizedBox(height: 12.0),
                                  _buildPasswordField(
                                    controller: _passwordController,
                                    focusNode: _passwordFocus,
                                    visible: _passwordVisible,
                                    onVisibilityChanged: (v) =>
                                        setState(() => _passwordVisible = v),
                                    hint: 'Contraseña',
                                  ),
                                  SizedBox(height: 12.0),
                                  _buildPasswordField(
                                    controller: _confirmController,
                                    focusNode: _confirmFocus,
                                    visible: _confirmVisible,
                                    onVisibilityChanged: (v) =>
                                        setState(() => _confirmVisible = v),
                                    hint: 'Confirmar contraseña',
                                  ),
                                  SizedBox(height: 8.0),
                                  AnimatedSwitcher(
                                    duration: Duration(milliseconds: 200),
                                    child: (_confirmController.text.isNotEmpty &&
                                            _passwordController.text.isNotEmpty &&
                                            _confirmController.text !=
                                                _passwordController.text)
                                        ? Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'Las contraseñas no coinciden',
                                              style: FlutterFlowTheme.of(context)
                                                  .bodySmall
                                                  .override(
                                                    font: GoogleFonts.fredoka(
                                                      fontWeight:
                                                          FlutterFlowTheme.of(context)
                                                              .bodySmall
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(context)
                                                              .bodySmall
                                                              .fontStyle,
                                                    ),
                                                    color:
                                                        FlutterFlowTheme.of(context)
                                                            .error,
                                                    letterSpacing: 0.0,
                                                  ),
                                            ),
                                          )
                                        : SizedBox.shrink(),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: 24.0),
                          FFButtonWidget(
                            onPressed: _isSubmitting ? null : _handleRegister,
                            text: _isSubmitting ? 'Registrando…' : 'Crear cuenta',
                            options: FFButtonOptions(
                              width: double.infinity,
                              height: 48.0,
                              color: FlutterFlowTheme.of(context).warning,
                              textStyle:
                                  FlutterFlowTheme.of(context).titleSmall.override(
                                        font: GoogleFonts.fredoka(
                                          fontWeight: FontWeight.w600,
                                          fontStyle: FlutterFlowTheme.of(context)
                                              .titleSmall
                                              .fontStyle,
                                        ),
                                        color: Colors.white,
                                        letterSpacing: 0.0,
                                      ),
                              elevation: 4.0,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(28.0),
                            ),
                          ),
                          SizedBox(height: 12.0),
                          TextButton(
                            onPressed: _isSubmitting
                                ? null
                                : () => context.pushNamed(LoginPageWidget.routeName),
                            child: Text(
                              '¿Ya tienes cuenta? Iniciar sesión',
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.fredoka(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context).primary,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
