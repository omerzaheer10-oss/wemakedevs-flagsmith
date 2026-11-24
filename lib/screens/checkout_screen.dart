import 'package:flutter/material.dart';
import 'package:flagsmith/flagsmith.dart';

class CheckoutScreen extends StatelessWidget {
  final bool showAnnualPlanFirst;
  final FlagsmithClient flagsmithClient;

  const CheckoutScreen({
    super.key,
    this.showAnnualPlanFirst = true,
    required this.flagsmithClient,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2563EB),
        elevation: 0,
        title: const Text(
          'Upgrade Your Plan',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 450),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(
                  Icons.campaign_rounded,
                  size: 72,
                  color: Color(0xFFEA580C),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Join the Movement!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF1E3A8A),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Pick a subscription plan that works for you. Full color, no glowing nonsense.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF4B5563),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 32),
                if (showAnnualPlanFirst) ...[
                  _buildColorfulCard(
                    title: 'Annual Power Plan',
                    price: '₹9,999',
                    subtitle: '/ year',
                    cardColor: const Color(0xFFFDE047),
                    textColor: const Color(0xFF854D0E),
                    borderColor: const Color(0xFFEAB308),
                    isHighlighted: true,
                    badgeText: 'BEST VALUE',
                  ),
                  const SizedBox(height: 20),
                  _buildColorfulCard(
                    title: 'Monthly Pass',
                    price: '₹999',
                    subtitle: '/ month',
                    cardColor: Colors.white,
                    textColor: const Color(0xFF1F2937),
                    borderColor: const Color(0xFFD1D5DB),
                    isHighlighted: false,
                  ),
                ] else ...[
                  _buildColorfulCard(
                    title: 'Monthly Pass',
                    price: '₹999',
                    subtitle: '/ month',
                    cardColor: const Color(0xFF6EE7B7),
                    textColor: const Color(0xFF064E3B),
                    borderColor: const Color(0xFF10B981),
                    isHighlighted: true,
                    badgeText: 'POPULAR',
                  ),
                  const SizedBox(height: 20),
                  _buildColorfulCard(
                    title: 'Annual Power Plan',
                    price: '₹9,999',
                    subtitle: '/ year',
                    cardColor: Colors.white,
                    textColor: const Color(0xFF1F2937),
                    borderColor: const Color(0xFFD1D5DB),
                    isHighlighted: false,
                  ),
                ],
                const SizedBox(height: 40),
                SizedBox(
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEA580C),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () async {
                      // Build a unique ID that includes their choice so it shows up in Flagsmith
                      String planSelected = showAnnualPlanFirst ? 'annual' : 'monthly';
                      String userId = 'simulated_user_${DateTime.now().millisecondsSinceEpoch}_$planSelected';

                      // Register this identity in Flagsmith to simulate traffic
                      await flagsmithClient.getFeatureFlags(user: Identity(identifier: userId));

                      debugPrint('Data sent to Flagsmith for: $userId');
                    },
                    child: const Text(
                      'Continue to Payment',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildColorfulCard({
    required String title,
    required String price,
    required String subtitle,
    required Color cardColor,
    required Color textColor,
    required Color borderColor,
    required bool isHighlighted,
    String? badgeText,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isHighlighted ? borderColor : Colors.transparent,
          width: 2,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            offset: Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                Container(
                  height: 28,
                  width: 28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isHighlighted ? textColor : Colors.transparent,
                    border: Border.all(
                      color: textColor,
                      width: 2,
                    ),
                  ),
                  child: isHighlighted
                      ? const Icon(Icons.check, size: 18, color: Colors.white)
                      : null,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            price,
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w900,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            subtitle,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: textColor.withValues(alpha: 0.7)
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (badgeText != null)
            Positioned(
              top: -12,
              right: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFEF4444),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  badgeText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}