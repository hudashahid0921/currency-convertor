// File: lib/widgets/blog_card.dart
import 'package:flutter/material.dart';
import '../models/blog_post.dart';
import '../screens/blog_detail_screen.dart';

class BlogCard extends StatefulWidget {
  final BlogPost post;
  const BlogCard({Key? key, required this.post}) : super(key: key);

  @override
  _BlogCardState createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => BlogDetailPage(post: widget.post)),
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isHovered ? Colors.purple : Colors.transparent,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: isHovered ? Colors.purple.withOpacity(0.3) : Colors.black54,
                blurRadius: isHovered ? 8 : 4,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  widget.post.imageUrl,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.post.title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isHovered ? Colors.purple : Colors.white,
                      ),
                    ),
                     Text(
                      widget.post.summary,
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: isHovered ? Colors.purple : Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.post.content,
                      style: TextStyle(fontSize: 18, 
                      color: isHovered ? Colors.purple : Colors.white,
                      ),
                      maxLines: 6,
                      overflow: TextOverflow.ellipsis,
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