import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class Web1 extends StatefulWidget {
  @override
  State<Web1> createState() => _WebState();
}

class _WebState extends State<Web1> {
  final List<Map<String, String>> _localUrls = [
    {'name': '首页', 'path': '/'},
    {'name': '消息接口1', 'path': '/message'},
    {'name': '消息接口2', 'path': '/message2'},
    {'name': '其他页面', 'path': '/page2'},
  ];

  String _apiResponse = "";
  bool _isLoading = false;
  String _currentPath = ""; // 记录当前请求的路径

  Future<void> _launchLocalUrl(String path) async {
    setState(() {
      _currentPath = path;
    });

    if (path == '/message' || path == '/message2') {
      await _fetchApiMessage(path);
    } else {
      final Uri url = Uri.parse('http://localhost:8087$path');
      if (!await launchUrl(url)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('无法打开 $url')),
        );
      }
    }
  }

  Future<void> _fetchApiMessage(String path) async {
    setState(() => _isLoading = true);
    try {
      final response = await http.get(
        Uri.parse('http://localhost:8087$path'),
      );

      if (response.statusCode == 200) {
        setState(() {
          _apiResponse = response.body;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$path 返回: $_apiResponse'),
            duration: Duration(seconds: 3),
          ),
        );
      } else {
        setState(() {
          _apiResponse = '错误: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _apiResponse = '连接失败: $e';
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('本地网页列表 (8087)'),
      ),
      body: ListView( // 使用 ListView 替代 Column
        padding: EdgeInsets.all(8),
        children: [
          if (_apiResponse.isNotEmpty)
            Padding(
              padding: EdgeInsets.all(16),
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '请求路径: $_currentPath',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '响应内容: $_apiResponse',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          GridView.builder(
            shrinkWrap: true, // 让 GridView 的高度适应内容
            physics: NeverScrollableScrollPhysics(), // 禁用 GridView 内部滚动，交给 ListView 处理
            padding: EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.5,
            ),
            itemCount: _localUrls.length,
            itemBuilder: (context, index) {
              final item = _localUrls[index];
              final isMessageBtn = item['path'] == '/message' || item['path'] == '/message2';
              final isLoadingThisBtn = _isLoading && _currentPath == item['path'];

              return ElevatedButton(
                onPressed: _isLoading ? null : () => _launchLocalUrl(item['path']!),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isMessageBtn
                      ? item['path'] == '/message'
                      ? Colors.green
                      : Colors.orange
                      : Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: isLoadingThisBtn
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(item['name']!),
              );
            },
          ),
        ],
      ),
    );
  }
}