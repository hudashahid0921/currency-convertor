import 'package:flutter/material.dart';
import '../models/blog_post.dart';
import 'blog_screen.dart';

class BlogDetailPage extends StatelessWidget {
  final BlogPost post;
  const BlogDetailPage({Key? key, required this.post}) : super(key: key);

  List<BlogPost> get relatedBlogs =>
      BlogScreen.blogPosts.where((r) => r.title != post.title).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(post.title, style: const TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Adjust layout based on screen width (responsive design)
            if (constraints.maxWidth > 600) {
              // Large screen (tablet or desktop)
              return Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: _buildMainBlogContent(),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    flex: 1,
                    child: _buildRelatedBlogs(),
                  ),
                ],
              );
            } else {
              // Small screen (phone)
              return Column(
                children: [
                  _buildMainBlogContent(),
                  const SizedBox(height: 24),
                  _buildRelatedBlogs(),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildMainBlogContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                post.imageUrl,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              post.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 12),
          ..._buildStyledContent(post.content),
        ],
      ),
    );
  }

  Widget _buildRelatedBlogs() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFD1C4E9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Related Blogs',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: relatedBlogs.length,
              itemBuilder: (context, index) {
                final r = relatedBlogs[index];
                return _RelatedBlogTile(post: r);
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildStyledContent(String content) {
    final lines = content.split('\n');

    return lines.map((line) {
      final isHeading = line.trim().isNotEmpty &&
          line.trim().length < 60 &&
          RegExp(r'^[A-Z]').hasMatch(line.trim());

      if (isHeading) {
        return Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 8),
          child: Text(
            line.trim(),
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        );
      }

      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Text(
          line.trim(),
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white70,
            height: 1.5,
          ),
        ),
      );
    }).toList();
  }
}

class _RelatedBlogTile extends StatefulWidget {
  final BlogPost post;
  const _RelatedBlogTile({Key? key, required this.post}) : super(key: key);

  @override
  State<_RelatedBlogTile> createState() => _RelatedBlogTileState();
}

class _RelatedBlogTileState extends State<_RelatedBlogTile> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlogDetailPage(post: widget.post),
            ),
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(vertical: 6),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _isHovering
                ? const Color.fromARGB(255, 212, 207, 214)
                : const Color(0xFFD1C4E9),
            borderRadius: BorderRadius.circular(10),
            boxShadow: _isHovering
                ? [
                    BoxShadow(
                      color: Colors.purpleAccent.withOpacity(0.6),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  widget.post.imageUrl,
                  height: 45,
                  width: 45,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 250),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: _isHovering
                            ? Colors.purpleAccent
                            : const Color.fromARGB(255, 15, 15, 15),
                      ),
                      child: Text(widget.post.title),
                    ),
                    const SizedBox(height: 4),
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 250),
                      style: TextStyle(
                        fontSize: 13,
                        color: _isHovering
                            ? Colors.purpleAccent
                            : const Color.fromARGB(255, 50, 50, 50),
                      ),
                      child: Text(
                        widget.post.summary,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
