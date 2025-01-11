import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_maker/features/qr_generator/presentation/widgets/customize_section.dart';
import 'package:qr_maker/features/qr_generator/presentation/widgets/qr_preview_section.dart';
import 'package:qr_maker/features/qr_generator/presentation/widgets/url_input_section.dart';

class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            // 왼쪽 패널
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  // URL 입력 섹션
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: UrlInputSection(),
                    ),
                  ),
                  SizedBox(height: 16),
                  // 커스터마이즈 섹션
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: CustomizeSection(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16),
            // 오른쪽 패널
            Expanded(
              flex: 3,
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: QrPreviewSection(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
