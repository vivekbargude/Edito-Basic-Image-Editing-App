import 'dart:io';

import 'package:assignmentapp/default_button.dart';
import 'package:assignmentapp/image_text.dart';
import 'package:assignmentapp/text_info.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   TextEditingController textEditingController = TextEditingController();
   TextEditingController creatorText = TextEditingController();
  List<File> _images = [];
  int currentIndex = 0;
  int _currentPage = 0;
  PageController? _pageController;
  double _fontSize = 16.0;
  double _imageHeight = 200.0;
  Color _selectedColor = Colors.black;
  double _volume = 0.5; // Initial volume value

  // Define a list of IconData object

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    final pickedImages = await picker.pickMultiImage();

    if (pickedImages != null) {
      setState(() {
        _images = pickedImages.map((image) => File(image.path)).toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Editor'),
        leading: IconButton(
          icon: Icon(Icons.upload),
          onPressed: () {
            _pickImages();
            texts = [];
          },
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,

              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: _images.length,
              itemBuilder: (context, index) {
                return _buildImagePage(_images[index]);
              },
            ),

            for (int i = 0; i < texts.length; i++)
                  Positioned(
                    left: texts[i].left,
                    top: texts[i].top,
                    child: GestureDetector(
                      onLongPress: () {
                        setState(() {
                          currentIndex = i;
                          // removeText(context);
                        });
                      },
                  onTap: () => setCurrentIndex(context,i),
                      child: Draggable(
                        feedback: ImageText(textInfo: texts[i]),
                        child: ImageText(textInfo: texts[i]),
                        onDragEnd: (drag) {
                          final renderBox =
                              context.findRenderObject() as RenderBox;
                          Offset off = renderBox.globalToLocal(drag.offset);
                          setState(() {
                            texts[i].top = off.dy - 96;
                            texts[i].left = off.dx;
                          });
                        },
                      ),
                    ),
                  ),

               creatorText.text.isNotEmpty
                    ? Positioned(
                        left: 0,
                        bottom: 0,
                        child: Text(
                          creatorText.text,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(
                                0.3,
                              )),
                        ),
                      )
                    : const SizedBox.shrink(),
          
            Positioned(
              left: 0,
              right: 0,
              bottom: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _images.length,
                  (index) => _buildDot(index),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color.fromARGB(255, 229, 170, 239),
        height: 90,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [

            IconButton(
              icon: const Icon(
                Icons.edit,
                color: Colors.black,
              ),
              onPressed: (){
                addNewDialog(context);
              },
              tooltip: 'Add Text',
            ),

            IconButton(
              icon: const Icon(
                Icons.add,
                color: Colors.black,
              ),
              onPressed: ()=> increaseFontSize(),
              tooltip: 'Increase Font Size',
            ),

            IconButton(
              icon: const Icon(
                Icons.remove,
                color: Colors.black,
              ),
              onPressed: ()=> decreaseFontSize(),
              tooltip: 'Decrease Font Size',
            ),

            IconButton(
              icon: const Icon(
                Icons.format_align_center,
                color: Colors.black,
              ),
              onPressed: ()=>alignCenter(),
              tooltip: 'Align Center',
            ),

            IconButton(
              icon: const Icon(
                Icons.format_align_left,
                color: Colors.black,
              ),
              onPressed: ()=>alignLeft(),
              tooltip: 'Align Left',
            ),

            IconButton(
              icon: const Icon(
                Icons.format_align_right,
                color: Colors.black,
              ),
              onPressed: ()=>alignRight(),
              tooltip: 'Align Right',
            ),

            IconButton(
              icon: const Icon(
                Icons.font_download,
                color: Colors.black,
              ),
              onPressed: ()=>_showPopupMenu(context),
              tooltip: 'Bold',
            ),

            IconButton(
              icon: const Icon(
                Icons.arrow_upward,
                color: Colors.black,
              ),
              onPressed: ()=> increaseLineSize(),
              tooltip: 'Bold',
            ),

            IconButton(
              icon: const Icon(
                Icons.arrow_downward,
                color: Colors.black,
              ),
              onPressed: ()=> decreaseLineSize(),
              tooltip: 'Bold',
            ),

             const SizedBox(
              width: 5,
            ),
            Tooltip(
              message: 'White',
              child: GestureDetector(
                  onTap: () => changeTextColor(Colors.white),
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                  )),
            ),

            const SizedBox(
              width: 5,
            ),
            Tooltip(
              message: 'White',
              child: GestureDetector(
                  onTap: () => changeTextColor(Colors.black),
                  child: const CircleAvatar(
                    backgroundColor: Colors.black,
                  )),
            ),

            const SizedBox(
              width: 5,
            ),
            Tooltip(
              message: 'White',
              child: GestureDetector(
                  onTap: () => changeTextColor(Colors.green),
                  child: const CircleAvatar(
                    backgroundColor: Colors.green,
                  )),
            ),

            const SizedBox(
              width: 5,
            ),
            Tooltip(
              message: 'White',
              child: GestureDetector(
                  onTap: () => changeTextColor(Colors.red),
                  child: const CircleAvatar(
                    backgroundColor: Colors.red,
                  )),
            ),

            const SizedBox(
              width: 5,
            ),
            Tooltip(
              message: 'White',
              child: GestureDetector(
                  onTap: () => changeTextColor(Colors.blue),
                  child: const CircleAvatar(
                    backgroundColor: Colors.blue,
                  )),
            ),

            const SizedBox(
              width: 5,
            ),
            Tooltip(
              message: 'White',
              child: GestureDetector(
                  onTap: () => changeTextColor(Colors.orange),
                  child: const CircleAvatar(
                    backgroundColor: Colors.orange,
                  )),
            ),

            const SizedBox(
              width: 5,
            ),
            Tooltip(
              message: 'White',
              child: GestureDetector(
                  onTap: () => changeTextColor(Colors.pink),
                  child: const CircleAvatar(
                    backgroundColor: Colors.pink,
                  )),
            ),

            

            

            
          ],
        )
      ),
    );
  }

  setCurrentIndex(BuildContext context, index) {
    setState(() {
      currentIndex = index;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Selected For Styling',
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  increaseLineSize() {
    setState(() {
      texts[currentIndex].FontHeight -= 1.0;
    });
  }

  decreaseLineSize() {
    setState(() {
      texts[currentIndex].FontHeight += 1.0;
    });
  }

   increaseFontSize() {
    setState(() {
      texts[currentIndex].fontSize += 2;
    });
  }

  decreaseFontSize() {
    setState(() {
      texts[currentIndex].fontSize -= 2;
    });
  }

  alignLeft() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.left;
    });
  }

  changeFontFamily(String? fontFamily){
    setState(() {
      texts[currentIndex].fontFamily = fontFamily;
    });
  }

  alignCenter() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.center;
    });
  }

  alignRight() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.right;
    });
  }

  

  String _getIconText(IconData icon) {
    // Add logic to return text for each icon
    if (icon == Icons.format_size) {
      return "Size";
    } else if (icon == Icons.font_download) {
      return "Font";
    } else if (icon == Icons.align_horizontal_center) {
      return "Align";
    } else if (icon == Icons.palette) {
      return "Palette";
    } else if (icon == Icons.height) {
      return "Height";
    } else if (icon == Icons.add) {
      return "Add text";
    } else if (icon == Icons.volume_up) {
      return "Volume";
    } else {
      return "";
    }
  }

  Widget _buildImagePage(File image) {
    return Container(
      color: Colors.amberAccent,
      padding: EdgeInsets.all(27.0),
      child: AspectRatio(
        aspectRatio: 9 / 16,
        child: Image.file(
          image,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _buildDot(int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      height: 10.0,
      width: 10.0,
      decoration: BoxDecoration(
        color: _currentPage == index
            ? Colors.blue
            : Colors.grey.withOpacity(0.8),
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
  }

  void _showPopupMenu(BuildContext context) {
  List<String> fontFamilies = [
    'roboto',
    'openSans',
    'montserrat',
    'lato',
    'nunito',
    'poppins',
  ];

  // Show the modal bottom sheet
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: fontFamilies.map((font) {
              return ListTile(
                title: _buildPopupMenuItem(font),
                onTap: () {
                  String? fontFamily;
                        if(font=='roboto'){
                          fontFamily = GoogleFonts.roboto().fontFamily;
                        }else if(font=='openSans'){
                          fontFamily = GoogleFonts.openSans().fontFamily;
                        }else if(font=='montserrat'){
                          fontFamily = GoogleFonts.montserrat().fontFamily;

                        }else if(font=='lato'){
                          fontFamily = GoogleFonts.lato().fontFamily;

                        }else if(font=='nunito'){
                          fontFamily = GoogleFonts.nunito().fontFamily;

                        }else if(font=='poppins'){
                          fontFamily = GoogleFonts.poppins().fontFamily;

                        }
                        changeFontFamily(fontFamily);
                  Navigator.pop(context); 
                },
              );
            }).toList(),
          ),
        ),
      );
    },
  );
}


  Widget _buildPopupMenuItem(String? font) {
    String? fontFamily;
    if(font=='roboto'){
      fontFamily = GoogleFonts.roboto().fontFamily;
    }else if(font=='openSans'){
      fontFamily = GoogleFonts.openSans().fontFamily;
    }else if(font=='montserrat'){
      fontFamily = GoogleFonts.montserrat().fontFamily;

    }else if(font=='lato'){
      fontFamily = GoogleFonts.lato().fontFamily;

    }else if(font=='nunito'){
      fontFamily = GoogleFonts.nunito().fontFamily;

    }else if(font=='poppins'){
      fontFamily = GoogleFonts.poppins().fontFamily;

    }
    return Row(
      children: [
        Icon(Icons.font_download),
        SizedBox(width: 8),
        Text(
          font!,
          style: TextStyle(fontFamily: fontFamily),
        ),
      ],
    );
  }



    List<TextInfo> texts = [];
    addNewText(BuildContext context) {
    setState(() {

      if(texts!=null){texts.add(
        TextInfo(
          text: textEditingController.text,
          left: 25,
          top: 25,
          color: Colors.black,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal,
          fontSize: 20,
          textAlign: TextAlign.left,
          FontHeight: 1.5,
          fontFamily: GoogleFonts.roboto().fontFamily
        ),
      );
      textEditingController.clear();
      Navigator.of(context).pop();}
    });
  }

  

 
  List<Widget> _getColorPalette(BuildContext context) {
    List<Color> colors = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.yellow,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.pink,
      Colors.brown,
      Colors.grey,
    ];

    return [
      GridView.count(
        shrinkWrap: true,
        crossAxisCount: 4,
        children: List.generate(
          colors.length,
          (index) => _buildColorChip(context, colors[index]),
        ),
      ),
    ];
  }

  changeTextColor(Color color) {
    setState(() {
      texts[currentIndex].color = color;
    });
  }


  addNewDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text(
          'Add New Text',
        ),
        content: TextField(
          controller: textEditingController,
          maxLines: 5,
          decoration: const InputDecoration(
            suffixIcon: Icon(
              Icons.edit,
            ),
            filled: true,
            hintText: 'Your Text Here..',
          ),
        ),
        actions: <Widget>[
          DefaultButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Back'),
            color: Colors.white,
            textColor: Colors.black,
          ),
          DefaultButton(
            onPressed: () => addNewText(context),
            child: const Text('Add Text'),
            color: Colors.red,
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildColorChip(BuildContext context, Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedColor = color;
          Navigator.pop(context);
          print('Selected color: $_selectedColor');
        });
      },
      child: Container(
        width: 30,
        height: 30,
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
