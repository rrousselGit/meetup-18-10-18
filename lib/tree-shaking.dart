import 'dart:async';

void unused() {
  print('foo');
}

void main() async {
  print('jere');
  while (true) {
    await Future.delayed(const Duration(seconds: 1));
  }
}