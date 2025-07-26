import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:times_line/data/services/database_service.dart';
import 'package:times_line/data/models/template.dart';

class TemplateScreen extends ConsumerStatefulWidget {
  const TemplateScreen({super.key});

  @override
  ConsumerState<TemplateScreen> createState() => _TemplateScreenState();
}

class _TemplateScreenState extends ConsumerState<TemplateScreen> {
  List<Template> _templates = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTemplates();
  }

  Future<void> _loadTemplates() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final templates = await DatabaseService.getAllTemplates();
      setState(() {
        _templates = templates;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // 에러 처리
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('템플릿 관리'),
        actions: [
          IconButton(onPressed: _createTemplate, icon: const Icon(Icons.add)),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _templates.length,
              itemBuilder: (context, index) {
                final template = _templates[index];
                return _buildTemplateCard(template, index);
              },
            ),
    );
  }

  Widget _buildTemplateCard(Template template, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: template.isDefault ? Colors.blue : Colors.grey,
          child: const Icon(Icons.dashboard, color: Colors.white),
        ),
        title: Text(
          template.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('${template.tasks.length}개의 태스크'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (template.isDefault)
              const Chip(
                label: Text('기본'),
                backgroundColor: Colors.blue,
                labelStyle: TextStyle(color: Colors.white),
              ),
            PopupMenuButton<String>(
              onSelected: (value) => _handleMenuAction(value, index),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit),
                      SizedBox(width: 8),
                      Text('편집'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'duplicate',
                  child: Row(
                    children: [
                      Icon(Icons.copy),
                      SizedBox(width: 8),
                      Text('복제'),
                    ],
                  ),
                ),
                if (!template.isDefault)
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete, color: Colors.red),
                        SizedBox(width: 8),
                        Text('삭제', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
        onTap: () => _viewTemplateDetail(template.id.toString()),
      ),
    );
  }

  void _viewTemplateDetail(String templateId) {
    context.go('/template/$templateId');
  }

  void _createTemplate() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('새 템플릿'),
        content: const Text('새 템플릿을 생성하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: 템플릿 생성 로직
            },
            child: const Text('생성'),
          ),
        ],
      ),
    );
  }

  void _editTemplate(int index) {
    // TODO: 템플릿 편집 화면으로 이동
  }

  void _handleMenuAction(String action, int index) {
    switch (action) {
      case 'edit':
        _editTemplate(index);
        break;
      case 'duplicate':
        // TODO: 템플릿 복제
        break;
      case 'delete':
        _deleteTemplate(index);
        break;
    }
  }

  void _deleteTemplate(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('템플릿 삭제'),
        content: const Text('이 템플릿을 삭제하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          ElevatedButton(
            onPressed: () async {
              final template = _templates[index];
              await DatabaseService.deleteTemplate(template.id.toString());
              Navigator.pop(context);
              await _loadTemplates(); // 데이터 다시 로드
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('삭제'),
          ),
        ],
      ),
    );
  }
}
