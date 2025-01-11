import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_maker/features/qr_generator/provider/qr_config_provider.dart';

class UrlInputSection extends ConsumerWidget {
  const UrlInputSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // QR config의 현재 URL 값을 가져옴
    final currentUrl = ref.watch(qRConfigProvider).url;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'URL 입력',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: currentUrl,
          decoration: InputDecoration(
            hintText: 'https://example.com',
            border: const OutlineInputBorder(),
            suffixIcon: currentUrl.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      // URL 초기화
                      ref.read(qRConfigProvider.notifier).updateUrl('');
                    },
                  )
                : null,
            // URL 유효성 표시를 위한 prefix 아이콘
            prefixIcon: Icon(
              Icons.link,
              color: _isValidUrl(currentUrl) ? Colors.green : Colors.grey,
            ),
          ),
          onChanged: (value) {
            // URL 업데이트
            ref.read(qRConfigProvider.notifier).updateUrl(value);
          },
          // URL 입력 시 자동으로 https:// 추가
          onTap: () {
            if (currentUrl.isEmpty) {
              ref.read(qRConfigProvider.notifier).updateUrl('https://');
            }
          },
        ),
        if (currentUrl.isNotEmpty && !_isValidUrl(currentUrl))
          const Padding(
            padding: EdgeInsets.only(top: 8),
            child: Text(
              '올바른 URL을 입력해주세요',
              style: TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }

  // URL 유효성 검사
  bool _isValidUrl(String url) {
    if (url.isEmpty) return true;
    try {
      final uri = Uri.parse(url);
      return uri.scheme.isNotEmpty && uri.host.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
}
