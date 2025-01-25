import 'package:flutter/material.dart';
import 'package:missing/bloc/cubit.dart';

class CustomInputFields {
  static Widget buildTextField(
    BuildContext context, {
    required TextEditingController controller,
    required String hint,
    required FocusNode focus,
    TextInputType keyboardType = TextInputType.text,
  }) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    MyCubit cubit = MyCubit.get(context);

    return Container(
      height: screenHeight * 0.08,
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.black,
            fontSize: screenHeight * 0.025,
            fontWeight: FontWeight.w300,
          ),
          labelText: hint,
          labelStyle: TextStyle(
            color: focus.hasFocus ? Colors.orange : Colors.black,
            fontSize: screenHeight * 0.025,
            fontWeight: FontWeight.w300,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          contentPadding: EdgeInsets.symmetric(horizontal: screenHeight * 0.02),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.orange),
          ),
          fillColor: Colors.white,
          filled: true,
        ),
        controller: controller,
        focusNode: focus,
        keyboardType: keyboardType,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Field cannot be empty';
          }
          return null;
        },
      ),
    );
  }

  static Widget buildPasswordField(
    BuildContext context, {
    required TextEditingController controller,
    required String hint,
    required FocusNode focus,
    required bool isPasswordVisible,
    required VoidCallback onVisibilityToggle,
  }) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    MyCubit cubit = MyCubit.get(context);

    return Container(
      height: screenHeight * 0.08,
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.black,
            fontSize: screenHeight * 0.025,
            fontWeight: FontWeight.w300,
          ),
          labelText: hint,
          labelStyle: TextStyle(
            color: focus.hasFocus ? Colors.orange : Colors.black,
            fontSize: screenHeight * 0.025,
            fontWeight: FontWeight.w300,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          contentPadding: EdgeInsets.symmetric(horizontal: screenHeight * 0.02),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.orange),
          ),
          suffixIcon: IconButton(
            onPressed: onVisibilityToggle,
            icon: Icon(
              isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              size: screenHeight * 0.03,
            ),
          ),
          fillColor: Colors.white,
          filled: true,
        ),
        controller: controller,
        focusNode: focus,
        keyboardType: TextInputType.visiblePassword,
        obscureText: !isPasswordVisible,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Password cannot be empty';
          } else if (value.length < 8) {
            return 'Password must be at least 8 characters';
          }
          return null;
        },
      ),
    );
  }

  static Widget ButtonSin(
    BuildContext context, {
    Color textColor = Colors.purple,
    required String name,
    required VoidCallback onVisibilityToggle,
    required Color color,
  }) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: onVisibilityToggle,
      child: Container(
        alignment: Alignment.center,
        width: screenWidth * 0.7,
        height: screenHeight * 0.08,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: FittedBox(
          child: Text(
            name,
            style: TextStyle(
              color: (color != Color.fromARGB(200, 17, 186, 17))
                  ? textColor
                  : Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: screenHeight * 0.04,
            ),
          ),
        ),
      ),
    );
  }
}
