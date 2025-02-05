import 'package:flutter/material.dart';
import 'dart:async';

class SOSButton extends StatefulWidget {
  final VoidCallback onPressed;

  const SOSButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  _SOSButtonState createState() => _SOSButtonState();
}

class _SOSButtonState extends State<SOSButton> {
  double _scale = 1.0;
  Color _buttonColor = Colors.red;
  bool _isPressed = false;
  List<int> _waveKeys = []; // 🔹 Lista de claves únicas para manejar las ondas
  Timer? _waveTimer;
  int _waveCounter = 0; // 🔹 Contador para diferenciar las ondas

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        print("Botón presionado - Cambiando color a rojo oscuro");
        setState(() {
          _scale = 1.0;
          _buttonColor = Colors.red.shade700;
          _isPressed = true;
        });
        widget.onPressed();
        _startWaveEffect();
      },
      onTapUp: (_) {
        print("Botón soltado - Cambiando color a rojo normal");
        _stopWaveEffect();
        setState(() {
          _scale = 1.0;
          _buttonColor = Colors.red;
          _isPressed = false;
        });
      },
      onTapCancel: () {
        _stopWaveEffect();
        setState(() {
          _scale = 1.0;
          _buttonColor = Colors.red;
          _isPressed = false;
        });
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          ..._waveKeys
              .map((key) => _buildWaveEffect(key))
              .toList(), // 🔹 Renderiza todas las ondas sin límite
          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            curve: Curves.easeOut,
            transform: Matrix4.identity()..scale(_scale),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _buttonColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.redAccent.withOpacity(0.5),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            width: 100,
            height: 100,
            alignment: Alignment.center,
            child: Text(
              "S.O.S",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Genera ondas infinitas mientras el botón está presionado
  void _startWaveEffect() {
     setState(() {
        _waveKeys.add(_waveCounter++); // 🔹 Añade una onda con una clave única
      });
      
    _waveTimer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      if (!_isPressed) {
        timer.cancel();
        return;
      }
      setState(() {
        _waveKeys.add(_waveCounter++); // 🔹 Añade una onda con una clave única
      });

      // 🔹 Cada onda se eliminará automáticamente después de 3 segundos para mantener fluidez
      Future.delayed(Duration(milliseconds: 3000), () {
        setState(() {
          if (_waveKeys.isNotEmpty) _waveKeys.removeAt(0);
        });
      });
    });
  }

  /// Detiene la generación de ondas al soltar el botón
  void _stopWaveEffect() {
    _waveTimer?.cancel();
    Future.delayed(Duration(milliseconds: 3000), () {
      setState(() {
        // _waveKeys.clear(); // 🔹 Se eliminan todas las ondas al soltar el botón
        if (!_isPressed) _waveKeys.clear();
      });
    });
  }

  /// Genera una nueva onda animada sin interrupciones
  Widget _buildWaveEffect(int key) {
    return TweenAnimationBuilder(
      key: ValueKey(key), // 🔹 Clave única para evitar problemas de renderizado
      tween: Tween<double>(begin: 1.0, end: 5.0),
      duration: Duration(milliseconds: 3000), // 🔹 Mayor duración para fluidez
      builder: (context, scale, child) {
        return Transform.scale(
          scale: scale,
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color:
                    Colors.red.withOpacity((1 - (scale - 1)).clamp(0.0, 1.0)),
                width: 4,
              ),
            ),
          ),
        );
      },
    );
  }
}
