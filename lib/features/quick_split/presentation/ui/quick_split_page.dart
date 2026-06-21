import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sky_bloc/sky_bloc.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:splittr/constants/constants.dart';
import 'package:splittr/core/route_handler/route_handler.dart';
import 'package:splittr/di/injection.dart';
import 'package:splittr/features/quick_split/presentation/blocs/quick_split_bloc.dart';
import 'package:splittr/features/quick_split/presentation/ui/components/quick_split_input_card.dart';
import 'package:splittr/features/quick_split/presentation/ui/components/split_history_list.dart';
import 'package:splittr/utils/bloc_utils/bloc_utils.dart';

part 'quick_split_form.dart';

class QuickSplitPage extends BasePage<QuickSplitBloc, QuickSplitState> {
  const QuickSplitPage({required this.args, super.key});

  final Map<String, dynamic>? args;

  @override
  QuickSplitBloc createBloc() => getIt<QuickSplitBloc>()..started(args: args);

  @override
  Widget buildPage(BuildContext context) {
    return BlocBuilder<QuickSplitBloc, QuickSplitState>(
      builder: (context, state) {
        final isHistoryView = state is Loaded;

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(isHistoryView ? 'Split History' : 'Quick Split'),
            leading: Container(
              margin: const EdgeInsets.only(left: 15, top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  if (isHistoryView) {
                    getBloc<QuickSplitBloc>(context).clearData();
                  } else {
                    Navigator.of(context).pop();
                  }
                },
              ),
            ),
            actions: [
              if (!isHistoryView)
                IconButton(
                  icon: const Icon(Icons.history_rounded),
                  tooltip: 'History',
                  onPressed: () {
                    getBloc<QuickSplitBloc>(context).add(
                      const QuickSplitEvent.loadHistory(),
                    );
                  },
                )
              else
                IconButton(
                  icon: const Icon(Icons.calculate_rounded),
                  tooltip: 'New Split',
                  onPressed: () {
                    getBloc<QuickSplitBloc>(context).clearData();
                  },
                ),
              const SizedBox(width: 8),
            ],
          ),
          body: switch (state) {
            ChangeLoaderState(:final store) when store.loading => const Center(
                child: CircularProgressIndicator(),
              ),
            OnFailure(:final failure) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline_rounded,
                        size: 64,
                        color: Theme.of(context).colorScheme.error,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Failed to load history',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        failure.message,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.error,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: () {
                          getBloc<QuickSplitBloc>(context).add(
                            const QuickSplitEvent.loadHistory(),
                          );
                        },
                        icon: const Icon(Icons.refresh_rounded),
                        label: const Text('Retry'),
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () {
                          getBloc<QuickSplitBloc>(context).clearData();
                        },
                        child: const Text('Back to Form'),
                      ),
                    ],
                  ),
                ),
              ),
            Loaded(:final history) => SplitHistoryList(history: history),
            _ => const _QuickSplitForm(),
          },
        );
      },
    );
  }

  @override
  void handleStateChange(BuildContext context, QuickSplitState state) {
    return switch (state) {
      InvalidAmount(:final invalidAmount) =>
        invalidAmount.isEmpty
            ? AppSnackBar.show(context, message: 'Empty amount are not allowed')
            : AppSnackBar.show(
                context,
                message: '$invalidAmount is an invalid amount',
              ),
      EmptyName() => AppSnackBar.show(
        context,
        message: 'Empty names are not allowed',
      ),
      QuickSettle _ => _navigateToQuickSettlePage(
        context: context,
        state: state,
      ),
      _ => () {},
    };
  }

  void _navigateToQuickSettlePage({
    required BuildContext context,
    required QuickSplitState state,
  }) {
    unawaited(
      RouteHandler.push(
        context,
        RouteId.quickSettle,
        args: {
          StringConstants.splitTitle: state.store.splitTitle,
          StringConstants.peopleRecords: state.store.peopleRecords.map((
            peopleRecord,
          ) {
            return (
              name: peopleRecord.name,
              amount: double.tryParse(peopleRecord.amount) ?? 0,
            );
          }).toList(),
        },
      ),
    );
  }
}
