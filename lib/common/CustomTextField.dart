import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodeze_flutter/utils/Theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodeze_flutter/extensions/UtilExtensions.dart';

class CustomTextField extends StatefulWidget {
  String? hint;
  TextEditingController? controller;
  Function(String)? onTextChanged;
  Function? onTap;
  Function? onSufficTap;
  Function(String)? validator;
  bool isObsure;
  bool collapsed;
  bool filled;
  bool boarder;
  bool isPassword;
  int? maxLength;
  int? maxLines;
  bool isNumber;
  bool enbled;
  bool? focus;
  bool? autofocus;
  FocusNode? focusNode;
  Color? fillColor;
  String activeSufix;
  String activePrefix;
  String inActivePrefix;
  String inActiveSufix;
  TextAlign? textAlign;
  TextStyle? textStyle;
  TextStyle? hintStyle;

  CustomTextField({
    this.hint,
    this.onTap,
    this.onSufficTap,
    this.autofocus = false,
    this.isPassword = false,
    this.hintStyle,
    this.controller,
    this.fillColor,
    this.onTextChanged,
    this.isObsure = false,
    this.collapsed = false,
    this.filled = false,
    this.boarder = true,
    this.maxLength,
    this.focusNode,
    this.focus,
    this.validator,
    this.isNumber = false,
    this.enbled = true,
    this.activePrefix = '',
    this.activeSufix = '',
    this.inActivePrefix = '',
    this.inActiveSufix = '',
    this.textAlign = TextAlign.start,
    this.textStyle,
    this.maxLines,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return FocusScope(
        child: Focus(
          onFocusChange: (focus) {
            setState(() {
              widget.focus = focus;
            });
          },
          child: TextFormField(

            autofocus: widget.autofocus!,
            focusNode: widget.focusNode,
            onChanged: (String value) {

              if(widget.onTextChanged!=null)
              widget.onTextChanged!(value);
            },
            validator: (ab) => widget.validator!(ab!),
            textAlign: widget.textAlign!,
            maxLength: widget.maxLength,
            enabled: widget.enbled,
            keyboardType: widget.isNumber ? TextInputType.numberWithOptions(decimal: true, signed: true) : TextInputType.text,
            inputFormatters: widget.isNumber ? [FilteringTextInputFormatter.allow(RegExp(r"[0-9\.]")),] : null,
            controller: widget.controller,
            obscureText: widget.isObsure,
            decoration: !widget.collapsed
                ? new InputDecoration(
              fillColor: widget.fillColor,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              suffixIcon: widget.activeSufix.isEmpty
                  ? null
                  : InkWell(
                onTap: () {
                  if (widget.isPassword)
                    setState(() {
                      widget.isObsure = !widget.isObsure;
                    });
                  else
                   {
                     widget.onSufficTap!();
                     print('kaif');

                          }
                },
                child: Container(
                  width: 22,
                  margin: 16.marginLeft(),
                  child: Row(
                    children: <Widget>[
                      SvgPicture.asset(
                        widget.isObsure
                            ? widget.inActiveSufix
                            : widget.activeSufix,
                      ),
                    ],
                  ),
                ),
              ),
              prefixIcon: widget.activePrefix.isEmpty
                  ? null
                  : Container(
                width: 22,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset(
                      widget.focus == null
                          ? widget.focusNode!.hasFocus
                          ? widget.activePrefix
                          : widget.inActivePrefix
                          : widget.focus!
                          ? widget.activePrefix
                          : widget.inActivePrefix,
                   color: colorPrimary, ),
                  ],
                ),
              ),
              hintText: widget.hint,
              hintStyle: widget.hintStyle == null
                  ? GoogleFonts.roboto(
                //fontWeight: FontWeight.bold,
                  fontSize: 15,
                  letterSpacing: 0.15,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff8f8f8f))
                  : widget.hintStyle,
              contentPadding: EdgeInsets.only(
                  bottom: 0, top: 0, left: widget.boarder ? 16 : 0.0),
            )
                : InputDecoration.collapsed(
                hintText: widget.hint,
                hintStyle: widget.hintStyle == null
                    ? GoogleFonts.roboto(
                  //fontWeight: FontWeight.bold,
                    fontSize: 15,
                    letterSpacing: 0.15,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff8f8f8f))
                    : widget.hintStyle),
            style: widget.textStyle == null
                ? GoogleFonts.roboto(
              //fontWeight: FontWeight.bold,
                fontSize: 15,
                letterSpacing: 0.15,
                fontWeight: FontWeight.w500,
                color: textColor)
                : widget.textStyle,
          ),
        ));
  }
}
