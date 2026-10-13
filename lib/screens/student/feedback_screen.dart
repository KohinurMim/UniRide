import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class FeedbackScreen extends StatefulWidget {
  final VoidCallback onBack;

  const FeedbackScreen({
    super.key,
    required this.onBack,
  });

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  String selectedIssue = 'Late Bus';
  final TextEditingController messageController = TextEditingController();

  final List<Map<String, dynamic>> issueTypes = [
    {
      'title': 'Late Bus',
      'icon': Icons.access_time_rounded,
    },
    {
      'title': 'Overcrowded',
      'icon': Icons.groups_rounded,
    },
    {
      'title': 'Route Issue',
      'icon': Icons.alt_route_rounded,
    },
    {
      'title': 'Other',
      'icon': Icons.more_horiz_rounded,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.onBack,
        ),
        title: const Text('Feedback / Complaint'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'What type of issue?',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.5,
              ),
              itemCount: issueTypes.length,
              itemBuilder: (context, index) {
                final issue = issueTypes[index];
                final isSelected = selectedIssue == issue['title'];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIssue = issue['title'];
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primaryLight : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected ? AppColors.primary : AppColors.border,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          issue['icon'] as IconData,
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.textSecondary,
                          size: 26,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          issue['title'] as String,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight:
                                isSelected ? FontWeight.bold : FontWeight.w500,
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            const Text(
              'Message (Optional)',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: messageController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Please describe the issue...',
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildAttachmentButton(Icons.image_outlined),
                const SizedBox(width: 10),
                _buildAttachmentButton(Icons.camera_alt_outlined),
              ],
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Feedback submitted successfully!'),
                    backgroundColor: AppColors.success,
                  ),
                );
                widget.onBack();
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttachmentButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Icon(
        icon,
        color: AppColors.textSecondary,
        size: 20,
      ),
    );
  }
}
