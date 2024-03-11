import 'package:flutter/material.dart';

class InProgressTaskPage extends StatelessWidget {
  const InProgressTaskPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemBuilder: (context, index) => Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Title card',
                  style: Theme.of(context).textTheme.headlineSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Visibility(
                  visible: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 12,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: const Image(
                          image: NetworkImage(
                              'https://i0.wp.com/sigmamaleimage.com/wp-content/uploads/2023/03/placeholder-1-1.png?ssl=1'),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  'Long description Officiis commodi delectus accusamus quos laborum sapiente repellat ut quisquam. Commodi animi molestiae id tempora nihil laboriosam aspernatur ut. Nisi dolores magnam harum at enim. Similique eaque doloribus similique debitis voluptatem quam rerum. Illo aliquid vitae illo quasi aut id et ut quidem. Quis deleniti magnam accusamus facere sint voluptatibus.',
                  style: Theme.of(context).textTheme.bodySmall,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}