import 'package:flutter/material.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:senior_project/Providers/categories_provider.dart";
import "package:senior_project/Providers/groups_provider.dart";
import "package:senior_project/Providers/users_provider.dart";
import "package:senior_project/screens/groups/category_item.dart";
import "../dialog_utils.dart";

class CategoriesList extends ConsumerStatefulWidget {
  @override
  ConsumerState<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends ConsumerState<CategoriesList> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final groupId = ref.read(selectedGroupIdProvider);
      if (groupId != null) {
        ref.read(categoriesProvider.notifier).fetchCategories(groupId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLeader = ref.watch(userRoleProvider);
    final groupId = ref.watch(selectedGroupIdProvider);

    if (groupId == null) {
      return const Center(child: Text('No group selected'));
    }

    final categoriesState = ref.watch(categoriesProvider);
    final isLoading = ref.read(categoriesProvider.notifier).isLoading;
    

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Categories",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),
        ),
        SizedBox(height: 16),
        Expanded(
          child: isLoading
              ? const Center(child: CircularProgressIndicator()) // Show loader while fetching
              : categoriesState.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "No categories found",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        if (isLeader) _buildAddCategoryButton(context, ref), // Show add button only for leaders
                      ],
                    )
                  : GridView.builder(
                      itemCount: isLeader ? categoriesState.length + 1 : categoriesState.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                      itemBuilder: (context, index) {
                        if (index == categoriesState.length && isLeader) {
                          return _buildAddCategoryButton(context, ref);
                        } else {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CategoryItemScreen(title: categoriesState[index].categoryName),
                                ),
                              );
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Icon(Icons.category, size: 40, color: Colors.white),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  categoriesState[index].categoryName,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
        ),
      ],
    );
  }

  /// **Reusable Add Category Button**
  Widget _buildAddCategoryButton(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        addCategory(context, ref);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 40,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            "Add New",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
