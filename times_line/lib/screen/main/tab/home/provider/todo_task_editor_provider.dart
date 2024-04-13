import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ControllerList extends StateNotifier<List<TextEditingController>> {
  final List<TextEditingController> _disposedList = [];

  ControllerList({String? text}) : super([TextEditingController(text: text)]);

  @override
  void dispose() {
    super.dispose();
    for(final target in _disposedList){
      target.dispose();
    }
  }

  void add({String? text}) {
    if(state.length < 24){
      state = [...state, TextEditingController(text: text)];
    }
  }

  void remove(int index) {
    if (index < 0 || index >= state.length) {
      return;
    }
    final target = state[index];
    _disposedList.add(target);
    state.remove(target);
    state = [...state];
  }

  void clear() {
    for (var element in state) {
      element.text = '';
    }
  }
}

final tecListProvider = StateNotifierProvider.autoDispose<
    ControllerList, List<TextEditingController>>((ref) => ControllerList());
