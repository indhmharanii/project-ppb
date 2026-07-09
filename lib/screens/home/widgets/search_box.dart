import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const SearchBox({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      shadowColor: Colors.black.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(22),

      child: TextField(
        onChanged: onChanged,

        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),

        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,

          hintText: "Search doctor...",
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 15,
          ),

          prefixIcon: const Padding(
            padding: EdgeInsets.only(
              left: 18,
              right: 10,
            ),
            child: Icon(
              Icons.search_rounded,
              size: 28,
              color: Color(0xff2F80ED),
            ),
          ),

          prefixIconConstraints: const BoxConstraints(
            minWidth: 60,
          ),

          contentPadding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 10,
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: BorderSide.none,
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: const BorderSide(
              color: Color(0xff2F80ED),
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}