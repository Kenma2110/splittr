part of 'group_details_page.dart';

class _GroupDetailsForm extends StatelessWidget {
  const _GroupDetailsForm({required this.group});

  final Group group;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: group.name ?? 'Group Details'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildInviteCodeCard(context),
        ],
      ),
    );
  }

  Widget _buildInviteCodeCard(BuildContext context) {
    final inviteCode = group.inviteCode;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: context.colorScheme.outlineVariant,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Invite Code',
                style: context.textTheme.labelMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 4),
              Text(inviteCode!),
            ],
          ),
          IconButton.filledTonal(
            onPressed: () async {
              await Clipboard.setData(ClipboardData(text: inviteCode));

              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Invite code copied to clipboard!'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            icon: const Icon(Icons.copy_rounded),
            tooltip: 'Copy Code',
          ),
        ],
      ),
    );
  }
}
