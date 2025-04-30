import 'package:flutter/material.dart';

class WaterfallFlow extends StatelessWidget {
  // 生成20个随机图片URL，每个图片设置不同的高度（200-400之间）
  final List<Map<String, dynamic>> images = List.generate(20, (i) {
    final height = 200 + (i % 5) * 50; // 高度在200-400之间变化
    return {
      'url': 'https://picsum.photos/300/$height?random=$i',
      'height': height.toDouble(),
    };
  });

  WaterfallFlow({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = screenWidth / 2 - 12; // 两列布局，考虑间距

    return Scaffold(
      appBar: AppBar(
        title: const Text('Waterfall Flow'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // 返回上一页
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Wrap(
          spacing: 8.0, // 水平间距
          runSpacing: 8.0, // 垂直间距
          children: images.map((image) {
            return SizedBox(
              width: itemWidth,
              height: image['height'] * (itemWidth / 300), // 保持图片原始宽高比
              child: Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                clipBehavior: Clip.antiAlias, // 确保圆角裁剪生效
                child: Stack(
                  children: [
                    // 图片部分
                    Image.network(
                      image['url'],
                      width: itemWidth,
                      height: image['height'] * (itemWidth / 300),
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(child: Icon(Icons.error));
                      },
                    ),

                    // 图片底部文字
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(0.7),
                              Colors.transparent,
                            ],
                          ),
                        ),
                        child: Text(
                          '高度: ${image['height'].toInt()}px',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}