import 'package:birthmark/core/di/injector.dart';
import 'package:birthmark/features/birthdate/presentation/pages/birthdate_page.dart';
import 'package:birthmark/features/paywall/presentation/bloc/paywall_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum SubscriptionPlan { month, year }

class PaywallPage extends StatefulWidget {
  const PaywallPage({super.key});

  @override
  State<PaywallPage> createState() => _PaywallPageState();
}

class _PaywallPageState extends State<PaywallPage> {
  SubscriptionPlan _selectedPlan = SubscriptionPlan.year;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<PaywallBloc>(),
      child: BlocListener<PaywallBloc, PaywallState>(
        listener: (context, state) {
          if (state is PaywallPurchaseSuccess) {
            Navigator.of(context).pushAndRemoveUntil(
              CupertinoPageRoute(builder: (_) => const BirthDatePage()),
              (route) => false,
            );
          }
        },
        child: CupertinoPageScaffold(
          navigationBar: const CupertinoNavigationBar(
            middle: Text('Unlock Premium'),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    'Get Full Access',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Never miss a birthday again with premium features.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: CupertinoColors.systemGrey),
                  ),
                  const Spacer(),
                  _buildPlanSelector(
                    plan: SubscriptionPlan.month,
                    title: 'Monthly',
                    price: '\$2.99 / month',
                  ),
                  const SizedBox(height: 15),
                  _buildPlanSelector(
                    plan: SubscriptionPlan.year,
                    title: 'Yearly',
                    price: '\$19.99 / year',
                    subtitle: 'SAVE 45%',
                  ),
                  const Spacer(),
                  BlocBuilder<PaywallBloc, PaywallState>(
                    builder: (context, state) {
                      final isLoading = state is PaywallPurchaseInProgress;
                      return CupertinoButton.filled(
                        onPressed: isLoading
                            ? null
                            : () => context.read<PaywallBloc>().add(SubscriptionPurchased()),
                        child: isLoading ? const CupertinoActivityIndicator() : const Text('Continue'),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlanSelector({
    required SubscriptionPlan plan,
    required String title,
    required String price,
    String? subtitle,
  }) {
    final isSelected = _selectedPlan == plan;
    return GestureDetector(
      onTap: () => setState(() => _selectedPlan = plan),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? CupertinoColors.activeBlue.withOpacity(0.1) : CupertinoColors.secondarySystemFill,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? CupertinoColors.activeBlue : CupertinoColors.separator,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? CupertinoIcons.checkmark_circle_fill : CupertinoIcons.circle,
              color: isSelected ? CupertinoColors.activeBlue : CupertinoColors.inactiveGray,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
                  Text(price, style: const TextStyle(fontSize: 15, color: CupertinoColors.systemGrey)),
                ],
              ),
            ),
            if (subtitle != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: CupertinoColors.activeGreen, borderRadius: BorderRadius.circular(20)),
                child: Text(subtitle, style: const TextStyle(color: CupertinoColors.white, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
          ],
        ),
      ),
    );
  }
}