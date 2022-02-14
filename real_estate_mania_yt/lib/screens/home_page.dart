import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import 'package:real_estate_mania_yt/models/category_model.dart';
import 'package:real_estate_mania_yt/models/property_model.dart';
import 'package:real_estate_mania_yt/screens/category_page.dart';
import 'package:real_estate_mania_yt/screens/details_page.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        // your conditions to render the widgets!
        if (_currentIndex == 0) {
          return SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          backgroundImage: AssetImage('images/user1.jpeg'),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome back!",
                              style: Theme.of(context).textTheme.caption,
                            ),
                            Text(
                              "Imran Sefat",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ],
                        ),
                        const Spacer(),
                        const Icon(LineIcons.bellAlt)
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(LineIcons.search),
                          hintText: "Search...",
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1 / 0.4,
                      ),
                      itemCount: categories.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CategoryButton(categoryModel: categories[index]);
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Recommendations",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 270,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: properties.length,
                        itemBuilder: (BuildContext context, int index) {
                          final PropertyModel propertyModel = properties[index];
                          return RecommendationCard(
                              propertyModel: propertyModel);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (_currentIndex == 1) {
          // favourite page
          return const Center(
            child: Text("Favourite Page"),
          );
        } else if (_currentIndex == 2) {
          // search page
          return const Center(
            child: Text("Search Page"),
          );
        } else if (_currentIndex == 3) {
          // settings page
          return const Center(
            child: Text("settings Page"),
          );
        }
        // this will not be the case but for null safety we are using this
        return const SizedBox();
      }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(12),
          ),
          child: SalomonBottomBar(
            unselectedItemColor: Colors.white,
            currentIndex: _currentIndex,
            onTap: (p0) {
              setState(() {
                _currentIndex = p0;
              });
            },
            items: [
              /// Home
              SalomonBottomBarItem(
                icon: const Icon(Icons.home),
                title: const Text("Home"),
                selectedColor: Colors.blue,
              ),

              /// Likes
              SalomonBottomBarItem(
                icon: const Icon(Icons.favorite_border),
                title: const Text("Likes"),
                selectedColor: Colors.pink,
              ),

              /// Search
              SalomonBottomBarItem(
                icon: const Icon(Icons.search),
                title: const Text("Search"),
                selectedColor: Colors.orange,
              ),

              /// Profile
              SalomonBottomBarItem(
                icon: const Icon(Icons.settings),
                title: const Text("Settings"),
                selectedColor: Colors.teal,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RecommendationCard extends StatelessWidget {
  const RecommendationCard({
    Key? key,
    required this.propertyModel,
  }) : super(key: key);

  final PropertyModel propertyModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailsPage(propertyModel: propertyModel),
        ),
      ),
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.15),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image(
                height: 120,
                width: double.infinity,
                image: AssetImage(propertyModel.thumbnail),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xffE5CE6A),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                "FOR SALE",
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              propertyModel.title,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              "${propertyModel.rooms} rooms - ${propertyModel.area} square foots - ${propertyModel.floors} floors",
              style: Theme.of(context).textTheme.caption!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final CategoryModel categoryModel;
  const CategoryButton({
    Key? key,
    required this.categoryModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryPage(
              categoryModel: categoryModel,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              categoryModel.title,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            Flexible(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image(
                  height: 50,
                  width: 50,
                  image: AssetImage('images/${categoryModel.assetPath}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
