import 'package:flutter/material.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:senior_project/Providers/groups_provider.dart";
import "package:senior_project/Providers/users_provider.dart";
import "package:senior_project/templates/custom_body_group.dart";
import "package:senior_project/templates/custom_scaffold.dart";
import "group_item.dart";
import "add_group.dart";

class GroupsScreen extends ConsumerWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groups = ref.watch(groupsProvider); // ✅ Now listens to updates

    return CustomScaffold(
      title: "Groups",
      content: CustomBodyGroup(
        content: GridView.builder(
          itemCount: groups.length + 1,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemBuilder: (context, index) {
            if (index == groups.length) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddGroup()),
                  );
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
            } else {
              return GestureDetector(
                onTap: () async{
                  ref.read(selectedGroupIdProvider.notifier).state = groups[index].id;
                  String groupId = groups[index].id.toString();
                  // Call loadUserRole to load the user's role in the group
                  await ref.read(userRoleProvider.notifier).loadUserRole(groupId);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          GroupItemScreen(name: groups[index].name),
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,                         
                        children: [
                          Icon(Icons.group, size: 40, color: Colors.white),
                          Text(groups[index].name,style: TextStyle(color: Colors.white),),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
