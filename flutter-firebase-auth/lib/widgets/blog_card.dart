import 'package:firebase_auth_demo/screens/blog_detail_screen.dart';
import 'package:flutter/material.dart';
import '../models/blog_post.dart';
import '../screens/blog_detail_screen.dart';

class BlogCard extends StatefulWidget {
  final BlogPost post;
  const BlogCard({super.key, required this.post});

  @override
  State<BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlogDetailPage(post: widget.post),
            ),
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(color: Colors.white10, blurRadius: 5),
            ],
            border: Border.all(
              color: isHovered ? Colors.purple : Colors.transparent,
              width: 1,
            ),
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(widget.post.imageUrl, height: 120, width: double.infinity, fit: BoxFit.cover),
              const SizedBox(height: 10),
              Text(
                widget.post.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isHovered ? Colors.purple : Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Text(
                  widget.post.summary,
                  style: TextStyle(
                    color: isHovered ? Colors.purple : Colors.white,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
