import 'package:mobx/mobx.dart';

class ContadorController {
  final _counter = Observable<int>(0);
  late Action increment;

  late Computed _saudacaoComputed;

  final _fullName =
      Observable<FullName>(FullName(first: 'first', last: 'last'));

  ContadorController() {
    increment = Action(() => _incrementCounter());
    _saudacaoComputed = Computed(() => 'Olá ${_fullName.value.first}');
  }

  String get saudacao => _saudacaoComputed.value;

  int get counter => _counter.value;
  FullName get fullName => _fullName.value;

  void _incrementCounter() {
    _counter.value++;
    // ! BAIXO NÃO MUDA DE HASHCODE ASSIM NÃO ALTERA O ESTADO
    // _fullName.value.first = 'Marcos';
    // _fullName.value.last = 'Otake';
    _fullName.value = _fullName.value.copyWith(
        first: 'Marcos ${_counter.value}', last: 'Otake ${_counter.value}');
  }
}

class FullName {
  String first;
  String last;
  FullName({
    required this.first,
    required this.last,
  });

  FullName copyWith({
    String? first,
    String? last,
  }) {
    return FullName(
      first: first ?? this.first,
      last: last ?? this.last,
    );
  }
}
