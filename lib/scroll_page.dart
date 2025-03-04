import 'package:flutter/material.dart';

class ScrollPage extends StatefulWidget {
  const ScrollPage({super.key});

  @override
  State<ScrollPage> createState() => _ScrollPageState();
}

class _ScrollPageState extends State<ScrollPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            delegate: AppScrollHeader(
              maxHeight: 270,
              minHeight: 90,
              title: 'Scroll Page',
              backgroundImageAsset: 'assets/image_bg.jpg',
              onBack: () {
                Navigator.of(context).pop();
              },
              trailing: IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {},
              ),
            ),
            pinned: true,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(12),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 5 / 6,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              delegate: SliverChildListDelegate([
                const FoodItem(
                  asset: 'assets/burger.jpg',
                  title: 'Burger',
                ),
                const FoodItem(
                  asset: 'assets/pizza.webp',
                  title: 'Pizza',
                ),
                const FoodItem(
                  asset: 'assets/dosa.jpeg',
                  title: 'Dosa',
                ),
                const FoodItem(
                  asset: 'assets/idli.jpeg',
                  title: 'Idli',
                ),
                const FoodItem(
                  asset: 'assets/sandwich.webp',
                  title: 'Sandwich',
                ),
                const FoodItem(
                  asset: 'assets/noodles.jpg',
                  title: 'Noodles',
                ),
              ]),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(12),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const RestaurantCard(
                  title: 'Take It Cheesy',
                  asset: 'assets/restaurant1.webp',
                  description: "Italian Food • Cheese • \$30 for two",
                  rating: 4.3,
                ),
                const RestaurantCard(
                  title: 'The Burger House',
                  asset: 'assets/restaurant2.webp',
                  description: "Burgers • Fast Food • \$20 for two",
                  rating: 4.5,
                ),
                const RestaurantCard(
                  title: 'Pizza Palace',
                  asset: 'assets/restaurant3.webp',
                  description: "Italian Food • Pizza • \$25 for two",
                  rating: 4.2,
                ),
                const RestaurantCard(
                  title: 'Dosa Diner',
                  asset: 'assets/restaurant4.webp',
                  description: "Indian Food • Dosa • \$15 for two",
                  rating: 3.4,
                ),
                const RestaurantCard(
                  title: 'Idli Inn',
                  asset: 'assets/restaurant5.webp',
                  description: "South Indian Food • Healthy • \$10 for one",
                  rating: 4.0,
                ),
                const RestaurantCard(
                  title: 'Sandwich Shop',
                  asset: 'assets/restaurant6.webp',
                  description: "Sandwiches • Fast Food • \$14 for two",
                  rating: 4.1,
                ),
                const RestaurantCard(
                  title: 'Noodle Nook',
                  asset: 'assets/restaurant7.webp',
                  description: "Chinese • Noodles • \$20 for one",
                  rating: 3.8,
                ),
                const RestaurantCard(
                  title: 'Cheese Cake Cafe',
                  asset: 'assets/restaurant8.webp',
                  description: "Coffee • Cafe • \$30 for three",
                  rating: 4.6,
                ),
                const RestaurantCard(
                  title: 'Bread Basket',
                  asset: 'assets/restaurant9.webp',
                  description: "Italian • Bakery • \$10 for two",
                  rating: 4.0,
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class AppScrollHeader extends SliverPersistentHeaderDelegate {
  final double maxHeight;
  final double minHeight;
  final String title;
  final String backgroundImageAsset;
  final VoidCallback onBack;
  final Widget? trailing;

  AppScrollHeader({
    required this.maxHeight,
    required this.minHeight,
    required this.title,
    required this.backgroundImageAsset,
    required this.onBack,
    this.trailing,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double percent = shrinkOffset / (maxHeight - minHeight);
    final double fadeOut =
        Curves.easeOutCubic.transform(1 - percent.clamp(0.0, 1.0));
    final double fadeIn =
        Curves.fastOutSlowIn.transform(percent.clamp(0.0, 1.0));
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(24 * (0.7 - percent)),
        bottomRight: Radius.circular(24 * (0.7 - percent)),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Opacity(
            opacity: fadeOut,
            child: Image.asset(
              backgroundImageAsset,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
                left: 12,
                right: 12,
              ),
              height: minHeight,
              decoration: BoxDecoration(
                color: Color.lerp(Colors.white, Colors.transparent, fadeOut),
                border: Border(
                  bottom: BorderSide(
                    color: Color.lerp(Colors.black.withOpacity(0.1),
                        Colors.transparent, fadeOut)!,
                    width: 1,
                  ),
                ),
              ),
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  AppHeaderIconButon(
                    icon: Icons.arrow_back,
                    onPressed: onBack,
                    progress: fadeIn,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Opacity(
                      opacity: fadeIn,
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  if (trailing != null)
                    AppHeaderIconButon(
                      icon: Icons.more_vert,
                      onPressed: () {},
                      progress: fadeIn,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class AppHeaderIconButon extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final double progress;
  const AppHeaderIconButon(
      {super.key,
      required this.icon,
      required this.onPressed,
      required this.progress});

  @override
  State<AppHeaderIconButon> createState() => _AppHeaderIconButonState();
}

class _AppHeaderIconButonState extends State<AppHeaderIconButon> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color.lerp(Colors.black.withOpacity(0.6), Colors.transparent,
              widget.progress),
        ),
        child: Icon(
          widget.icon,
          color: Color.lerp(Colors.white, Colors.black, widget.progress),
          size: 24,
        ),
      ),
    );
  }
}

class FoodItem extends StatelessWidget {
  final String asset;
  final String title;
  const FoodItem({super.key, required this.asset, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(
          color: Colors.black.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                asset,
                fit: BoxFit.contain,
                alignment: Alignment.center,
              ),
            ),
          ),
          Positioned(
            bottom: 8,
            left: 12,
            right: 12,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class RestaurantCard extends StatelessWidget {
  final String title;
  final String asset;
  final String description;
  final double rating;
  const RestaurantCard({
    super.key,
    required this.title,
    required this.asset,
    required this.description,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black.withOpacity(0.4),
          width: 1,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(14)),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: Image.asset(
                  asset,
                  fit: BoxFit.cover,
                ),
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.all(12),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Stack(
              fit: StackFit.loose,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      description,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Positioned(
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.black,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          rating.toString(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
