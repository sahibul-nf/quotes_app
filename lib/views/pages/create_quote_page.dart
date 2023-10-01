import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_picker/flutter_font_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:group_button/group_button.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../controllers/quotes_controller.dart';
import '../../controllers/user_controller.dart';
import '../../models/quote_model.dart';
import '../../utils/font_family.dart';
import '../themes/colors.dart';
import '../themes/typography.dart';
import '../widgets/color_picker.dart';
import '../widgets/icon_solid_light.dart';
import '../widgets/snackbar.dart';

class CreateQuotePage extends ConsumerStatefulWidget {
  const CreateQuotePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateQuotePageState();
}

class _CreateQuotePageState extends ConsumerState<CreateQuotePage> {
  Color backgroundColor = MyColors.primary;
  Color textColor = Colors.white;
  double fontSize = 20;
  TextAlign textAlign = TextAlign.center;
  FontWeight fontWeight = FontWeight.normal;
  PickerFont? selectedFont = PickerFont(fontFamily: 'Inter');

  final fontSizeType = ['S', 'M', 'L', 'XL'];
  final textAlignType = ['L', 'C', 'R'];
  final fontWeightType = ['Normal', 'Bold'];

  final fontWeightController = GroupButtonController(selectedIndex: 0);
  final textAlignController = GroupButtonController(selectedIndex: 1);
  final fontSizeController = GroupButtonController(selectedIndex: 1);

  var contentController = TextEditingController();
  var authorController = TextEditingController();
  var professionController = TextEditingController();

  void createQuote() {
    String userId = ref.watch(userProvider)!.id;

    String author = authorController.text;
    String profession = professionController.text;

    if (author.isEmpty) {
      author = ref.watch(userProvider)?.username ?? "";
    }

    if (profession.isEmpty) {
      profession = ref.watch(userProvider)?.profession ?? "";
    }

    // create quote object
    final quote = Quote(
      userId: userId,
      content: contentController.text,
      author: author,
      profession: profession,
      backgroundColor: backgroundColor.value,
      textColor: textColor.value,
      fontSize: fontSize,
      fontWeight: fontWeight,
      textAlign: textAlign,
      fontFamily: selectedFont!.fontFamily,
    );

    // show loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(
          color: MyColors.primary,
        ),
      ),
    );

    // trigger provider to create quote
    ref.read(quotesProvider.notifier).createQuote(quote).then((_) {
      // refresh quotes by me list
      ref.refresh(quotesProvider);

      // hide loading
      Navigator.pop(context);
      // back
      Navigator.pop(context);
    }).onError((error, stackTrace) {
      // hide loading
      Navigator.pop(context);

      // show snackbar
      showSnackbar(context, error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leadingWidth: 76,
        toolbarHeight: 66,
        leading: IconSolidLight(
          icon: PhosphorIcons.regular.caretLeft,
          onTap: () => Navigator.pop(context),
        ),
        actions: [
          UnconstrainedBox(
            child: TextButton(
              onPressed: () {
                if (contentController.text.isNotEmpty) {
                  createQuote();
                } else {
                  showSnackbar(context, "Quote cannot be empty!");
                }
              },
              child: Text(
                "DONE",
                style: MyTypography.body1.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Write a Quote",
                style: MyTypography.h2,
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Container(
                    height: 300,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30.0,
                      vertical: 20.0,
                    ),
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: Center(
                      child: IntrinsicWidth(
                        child: TextField(
                          controller: contentController,
                          cursorColor: textColor,
                          style: selectedFont != null
                              ? selectedFont!.toTextStyle().copyWith(
                                    color: textColor,
                                    fontSize: fontSize,
                                    fontWeight: fontWeight,
                                  )
                              : MyTypography.body1.copyWith(
                                  color: textColor,
                                  fontSize: fontSize,
                                  fontWeight: fontWeight,
                                ),
                          maxLines: null,
                          minLines: null,
                          expands: true,
                          textAlign: textAlign,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            hintText: "Write a quote here",
                            hintStyle: selectedFont != null
                                ? selectedFont!.toTextStyle().copyWith(
                                      color: textColor,
                                      fontSize: fontSize,
                                    )
                                : MyTypography.body1.copyWith(
                                    fontWeight: fontWeight,
                                    color: Colors.grey[200],
                                    fontSize: fontSize,
                                  ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 30.0,
                    ),
                    decoration: DottedDecoration(
                      color: Colors.white,
                      strokeWidth: 2,
                      dash: const [5, 10],
                      shape: Shape.circle,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                      left: 30.0,
                      right: 30.0,
                      top: 5.0,
                      bottom: 10.0,
                    ),
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                    ),
                    child: Row(
                      children: [
                        Flexible(
                          child: TextField(
                            controller: authorController,
                            cursorColor: textColor,
                            decoration: InputDecoration(
                              hintText: "Author name",
                              border: InputBorder.none,
                              hintStyle: MyTypography.body2.copyWith(
                                fontWeight: fontWeight,
                                color: textColor,
                              ),
                            ),
                            style: MyTypography.body2.copyWith(
                              color: textColor,
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          height: 30,
                          width: 1,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                          ),
                        ),
                        Flexible(
                          child: TextField(
                            controller: professionController,
                            cursorColor: textColor,
                            textAlign: TextAlign.end,
                            decoration: InputDecoration(
                              hintText: "Profession",
                              border: InputBorder.none,
                              hintStyle: MyTypography.body2.copyWith(
                                fontWeight: fontWeight,
                                color: textColor,
                              ),
                            ),
                            style: MyTypography.body2.copyWith(
                              color: textColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // note
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  "Note: If you dont fill Author name and Profession, we will use your name and profession.",
                  style: MyTypography.caption1.copyWith(
                    color: MyColors.black,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Font Weight
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Font Weight",
                    style: MyTypography.body1.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  GroupButton(
                    buttons: fontWeightType,
                    controller: fontWeightController,
                    buttonIndexedBuilder: (selected, index, context) {
                      FontWeight fontWeight = FontWeight.normal;

                      if (index != 0) {
                        fontWeight = FontWeight.bold;
                      }

                      return Container(
                        width: 100,
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: selected ? MyColors.secondary : Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            fontWeightType[index],
                            style: MyTypography.body1.copyWith(
                              fontWeight: fontWeight,
                            ),
                          ),
                        ),
                      );
                    },
                    options: GroupButtonOptions(
                      selectedColor: MyColors.primary,
                    ),
                    onSelected: (value, index, isSelected) {
                      setState(() {
                        if (index != 0) {
                          fontWeight = FontWeight.bold;
                        } else {
                          fontWeight = FontWeight.normal;
                        }
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Text Align
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Text Align",
                    style: MyTypography.body1.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  GroupButton(
                    buttons: textAlignType,
                    controller: textAlignController,
                    buttonIndexedBuilder: (selected, index, context) {
                      IconData? icon;
                      switch (index) {
                        case 0:
                          icon = PhosphorIcons.regular.textAlignLeft;
                          break;
                        case 1:
                          icon = PhosphorIcons.regular.textAlignCenter;
                          break;
                        case 2:
                          icon = PhosphorIcons.regular.textAlignRight;
                          break;
                        default:
                      }

                      return Container(
                        width: 50,
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: selected ? MyColors.secondary : Colors.white,
                        ),
                        child: Center(
                          child: Icon(icon),
                        ),
                      );
                    },
                    options: GroupButtonOptions(
                      selectedColor: MyColors.primary,
                    ),
                    onSelected: (value, index, isSelected) {
                      setState(() {
                        switch (index) {
                          case 0:
                            textAlign = TextAlign.left;
                            break;
                          case 1:
                            textAlign = TextAlign.center;
                            break;
                          case 2:
                            textAlign = TextAlign.right;
                            break;
                          default:
                        }
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Font Size
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Font Size",
                    style: MyTypography.body1.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  GroupButton(
                    buttons: fontSizeType,
                    controller: fontSizeController,
                    buttonIndexedBuilder: (selected, index, context) {
                      double? fontSize;
                      switch (index) {
                        case 0:
                          fontSize = 12;
                          break;
                        case 1:
                          fontSize = 14;
                          break;
                        case 2:
                          fontSize = 16;
                          break;
                        case 3:
                          fontSize = 18;
                          break;
                        default:
                      }

                      return Container(
                        width: 50,
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: selected ? MyColors.secondary : Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            fontSizeType[index],
                            style: MyTypography.body1.copyWith(
                              fontSize: fontSize,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    },
                    options: GroupButtonOptions(
                      selectedColor: MyColors.primary,
                    ),
                    onSelected: (value, index, isSelected) {
                      setState(() {
                        switch (value) {
                          case 'S':
                            fontSize = 18;
                            break;
                          case 'M':
                            fontSize = 20;
                            break;
                          case 'L':
                            fontSize = 24;
                            break;
                          case 'XL':
                            fontSize = 28;
                            break;
                          default:
                        }
                      });
                    },
                  )
                ],
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Font Family",
                    style: MyTypography.body1.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 40,
                            ),
                            child: Material(
                              borderRadius: BorderRadius.circular(20),
                              child: FontPicker(
                                googleFonts: myGoogleFonts,
                                initialFontFamily: selectedFont?.fontFamily,
                                showInDialog: true,
                                onFontChanged: (font) {
                                  setState(() {
                                    selectedFont = font;
                                  });
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey[300]!,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          selectedFont != null
                              ? Text(
                                  selectedFont!.fontFamily,
                                  style: selectedFont!.toTextStyle(),
                                )
                              : Text(
                                  "Select font",
                                  style: MyTypography.body2,
                                ),
                          Icon(
                            PhosphorIcons.regular.caretDown,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ColorPicker(
                label: "Background Color",
                selectedColor: backgroundColor,
                onColorSelected: (color) {
                  setState(() {
                    backgroundColor = color;
                  });
                },
              ),
              const SizedBox(height: 10),
              ColorPicker(
                label: "Text Color",
                selectedColor: textColor,
                onColorSelected: (color) {
                  setState(() {
                    textColor = color;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
