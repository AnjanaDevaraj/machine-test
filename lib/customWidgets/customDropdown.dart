import 'package:employee_management_task/customWidgets/customText.dart';
import 'package:flutter/material.dart';

import '../utilities/appStrings.dart';

class CustomDropdown<T> extends StatelessWidget {
  final String? hintText;
  final List<T> items;
  final T? value;
  final ValueChanged<T?>? onChanged;

  const CustomDropdown({
    Key? key,
    this.hintText,
    required this.items,
    this.value,
    this.onChanged,
  }) : super(key: key);

  void _showModalSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: AppStrings.roles.length*60,
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Center(child: Text(items[index].toString())),
                onTap: () {
                  if (onChanged != null) {
                    onChanged!(items[index]);
                  }
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showModalSheet(context),
      child: Container(
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.shopping_bag_outlined, color: Colors.blue),
                SizedBox(width: 16),
                CustomText(text: (value != null && value.toString().isNotEmpty) ? value.toString() : hintText ?? 'Select an option',
                color: (value != null && value.toString().isNotEmpty) ? Colors.black :Colors.grey,),
              ],
            ),
           const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}
