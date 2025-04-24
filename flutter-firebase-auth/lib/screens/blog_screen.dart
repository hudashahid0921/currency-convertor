import 'package:flutter/material.dart';
import '../models/blog_post.dart';
import '../widgets/blog_card.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});

  final List<BlogPost> blogPosts = const [
    BlogPost(
      title: 'Cryptocurrency',
      summary: 'Etiam feugiat lorem non metus. Curabitur blandit tempus porttitor.',
      content: 'Detailed content about Cryptocurrency and market trends...',
      imageUrl: 'https://via.placeholder.com/400x200.png?text=Cryptocurrency',
    ),
    BlogPost(
      title: 'Forex',
      summary: 'Integer posuere erat a ante venenatis dapibus posuere velit aliquet.',
      content: 'Complete guide to forex trading, strategies, and risks...',
      imageUrl: 'https://via.placeholder.com/400x200.png?text=Forex',
    ),
    BlogPost(
      title: 'Inflation',
      summary: 'Cras justo odio, dapibus ac facilisis in, egestas eget quam.',
      content: 'Learn how inflation affects currency values globally...',
      imageUrl: 'https://via.placeholder.com/400x200.png?text=Inflation',
    ),
    BlogPost(
      title: 'Stablecoin',
      summary: 'Maecenas sed diam eget risus varius blandit sit amet non magna.',
      content: 'Everything about stablecoins and their role in DeFi...',
      imageUrl: 'https://via.placeholder.com/400x200.png?text=Stablecoin',
    ),
    BlogPost(
      title: 'Exchange',
      summary: 'Praesent commodo cursus magna, vel scelerisque nisl consectetur.',
      content: 'Choosing the best currency exchange platforms...',
      imageUrl: 'https://via.placeholder.com/400x200.png?text=Exchange',
    ),
    BlogPost(
      title: 'Tokenomics',
      summary: 'Nullam id dolor id nibh ultricies vehicula ut id elit.',
      content: 'How token supply and demand affect pricing...',
      imageUrl: 'https://via.placeholder.com/400x200.png?text=Tokenomics',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Latest Blogs',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                'Explore the world of currencies with insightful articles.\nStay updated with trends and news.',
                style: TextStyle(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                itemCount: blogPosts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) => BlogCard(post: blogPosts[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
