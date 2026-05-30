import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splittr/core/global/presentation/blocs/global_bloc.dart';

class GlobalBlocsWidget extends StatelessWidget {
  const GlobalBlocsWidget({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => GlobalBloc())],
      child: child,
    );
  }
}
