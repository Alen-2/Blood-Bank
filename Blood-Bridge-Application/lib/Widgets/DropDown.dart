import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropDown extends StatefulWidget {
  Function dropDownHandler;
  var text;
  var selectedValue;
  final List<String> items;

  DropDown({super.key, 
    required this.items,
    required this.dropDownHandler,
    required this.text,
  });
  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.h),
        color: const Color(0xFFF9DEE4),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          value: widget.selectedValue,
          hint: Text(widget.text, style: const TextStyle(color: Colors.black54)),
          items: widget.items.map(
            (String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(
                  items,
                  style: const TextStyle(color: Colors.black54),
                ),
              );
            },
          ).toList(),
          dropdownMaxHeight: 200.h,
          dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
          ),
          onChanged: (val) {
            setState(
              () {
                widget.selectedValue = val.toString();
                widget.dropDownHandler(widget.selectedValue);
              },
            );
          },
        ),
      ),
    );
  }
}
