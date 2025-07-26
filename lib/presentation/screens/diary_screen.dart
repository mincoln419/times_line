import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DiaryScreen extends ConsumerStatefulWidget {
  const DiaryScreen({super.key});

  @override
  ConsumerState<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends ConsumerState<DiaryScreen> {
  DateTime selectedDate = DateTime.now();
  final TextEditingController _feelingController = TextEditingController();
  final TextEditingController _regretController = TextEditingController();
  final TextEditingController _resolutionController = TextEditingController();

  @override
  void dispose() {
    _feelingController.dispose();
    _regretController.dispose();
    _resolutionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${selectedDate.year}년 ${selectedDate.month}월 ${selectedDate.day}일'),
        actions: [
          IconButton(
            onPressed: () => _selectDate(),
            icon: const Icon(Icons.calendar_month),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDiarySection(
              title: '느낀점',
              controller: _feelingController,
              hint: '오늘 느낀 점을 적어보세요',
              icon: Icons.favorite,
              color: Colors.red,
            ),
            const SizedBox(height: 24),
            _buildDiarySection(
              title: '후회하는 점',
              controller: _regretController,
              hint: '후회하는 점이 있다면 적어보세요',
              icon: Icons.sentiment_dissatisfied,
              color: Colors.orange,
            ),
            const SizedBox(height: 24),
            _buildDiarySection(
              title: '각오',
              controller: _resolutionController,
              hint: '내일의 각오를 적어보세요',
              icon: Icons.psychology,
              color: Colors.blue,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveDiary,
                child: const Text('저장'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDiarySection({
    required String title,
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: hint,
                border: const OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveDiary() {
    // TODO: 일기 저장 로직
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('일기가 저장되었습니다.')),
    );
  }

  void _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      setState(() {
        selectedDate = date;
      });
      // TODO: 선택된 날짜의 일기 로드
    }
  }
}
