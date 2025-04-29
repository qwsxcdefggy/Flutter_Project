import 'package:flutter/material.dart';

class CardLayoutScreen extends StatelessWidget {
  const CardLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('卡片式布局示例'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // 基本卡片示例
              _buildBasicCard(),
              const SizedBox(height: 20),

              // 带图片的卡片
              _buildImageCard(),
              const SizedBox(height: 20),

              // 带动作按钮的卡片
              _buildActionCard(),
              const SizedBox(height: 20),

              // 列表式卡片组
              _buildCardList(),
            ],
          ),
        ),
      ),
    );
  }

  // 基本卡片
  Widget _buildBasicCard() {
    return Card(
      elevation: 4, // 阴影效果
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '基本卡片',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '这是一个基本的卡片布局示例，可以包含各种内容和样式。',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  // 带图片的卡片
  Widget _buildImageCard() {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      clipBehavior: Clip.antiAlias, // 防止子组件溢出
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            'https://picsum.photos/600/300?random=1',
            height: 160,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '带图片的卡片',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '这种卡片包含顶部图片和下方文字内容，适合展示图文信息。',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 带动作按钮的卡片
  Widget _buildActionCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              'https://picsum.photos/600/300?random=1',
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Text(
              '带动作的卡片',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '这种卡片底部包含操作按钮，用户可以执行特定操作。',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text('取消'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('确定'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 卡片列表
  Widget _buildCardList() {
    return Column(
      children: List.generate(3, (index) {
        return Padding(
          padding: EdgeInsets.only(bottom: index == 2 ? 0 : 16.0),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue[100],
                  child: Text('${index + 1}'),
                ),
                title: Text('卡片项目 ${index + 1}'),
                subtitle: Text('这是第 ${index + 1} 个卡片列表项目'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // 点击事件处理
                },
              ),
            ),
          ),
        );
      }),
    );
  }
}