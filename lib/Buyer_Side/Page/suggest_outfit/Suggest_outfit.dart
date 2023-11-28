import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:fahioapp_fyp/Buyer_Side/Page/suggest_outfit/select_image_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
//import 'package:responsive_sizer/responsive_sizer.dart';

import '../../bottamnav_scren.dart';
import 'outfitcontroller.dart';


class OutfitGeneration extends StatefulWidget {
  const OutfitGeneration({super.key});

  @override
  State<OutfitGeneration> createState() => _OutfitGenerationState();
}

class _OutfitGenerationState extends State<OutfitGeneration> {
  final TextEditingController _captionController = TextEditingController();
  bool load = false;
  File? _image;
  File? imageSavingInFirebase;
  Uint8List? img;
  double userRating = 0;
  bool saveButtonLoading = false;
  bool generationButtonLoading = false;


  List<String> filter = [];


  //to upload image
  Future<void> _showImageSourceDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Select Image Source',
            style:TextStyle(fontSize: 16,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Text(
                    'Gallery',
                    style: TextStyle(fontSize: 16,
                    ),
                  ),
                  onTap: () async {
                    Navigator.pop(context);
                    _image = await selectImage();
                    setState(() {});
                  },
                ),
                SizedBox(height: 10),
                GestureDetector(
                  child: Text(
                    'Camera',
                    style: TextStyle(fontSize: 16,
                    ),
                  ),
                  onTap: () async {
                    Navigator.pop(context);
                    _image = await captureImage();
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Fashio'.toUpperCase(),
            style: TextStyle(fontSize: 25,
              fontWeight: FontWeight.w800,

              color: Colors.orange
            ),
          ),
          leading: IconButton(
              onPressed: (){
                Get.to(BottomNavBar(currentIndex: 0,));
              },
              icon: Icon(Icons.arrow_back_ios)
          ),
          backgroundColor: Colors.grey[200],
          centerTitle: true,
        ),
        body: ListView(
          children: <Widget>[

            SizedBox(
              height: MediaQuery.of(context).size.height*0.02,
            ),
            Center(child: Text("Sugguest me OutFit" , style: TextStyle(fontSize: 20 , fontStyle: FontStyle.italic),),),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.02,
            ),
            GestureDetector(
              onTap: () {
                _showImageSourceDialog();
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 2,
                ),
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height*0.4,
                  color: Colors.grey[300],
                  child: _image != null
                      ? // Display the selected image
                  Center(
                    child: Stack(
                      children: [
                        //print('image22: $img');
                        img == null
                            ?
                        Image.file(
                          _image!,
                          fit: BoxFit.fitHeight,
                        )
                            : Image.memory(
                          img!,
                          fit: BoxFit.fitHeight,
                        ),

                        //create cross icon on top left corner
                        Positioned(
                          top: 10,
                          right: 10,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _image = null;
                                load = false;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              height: 30,
                              width: 30,
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                      : SizedBox(
                    // height: 40.h,
                    child: Center(
                      child: Text(
                        'Click Upload Outfit',
                        style: TextStyle(fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                //suggest outfit button
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.5,
                  child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        generationButtonLoading = true;
                      });
                      if(_image == null)
                      {
                        Get.snackbar('Please Upload Outfit', '');

                      }
                      else if(filter.isEmpty)
                      {
                        Get.snackbar('Please Select Filters', '');

                      }else {
                        print("Imagee uploading from galary: $_image");
                        Uint8List imgg = await generataApi(_image!.path);
                        final Uint8List imageData = Uint8List.fromList([
                          ...imgg,
                        ]);
                        img = imageData;
                        ui.Codec codec = await ui.instantiateImageCodec(Uint8List.fromList(imageData));
                        ui.FrameInfo frameInfo = await codec.getNextFrame();
                        Image image = Image.memory(Uint8List.fromList(imageData));
                        print("image saving in firebase: $frameInfo");
                      }
                      setState(() {
                        generationButtonLoading = false;
                      });
                      ;
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 224, 106, 0)
                      ),
                      foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.white,
                      ),
                    ),
                    child:generationButtonLoading
                        ? const Center(
                      child: CircularProgressIndicator(),
                    )
                        : Text(
                      'Outfit Generation',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),


            //filters
            img != null || _image != null
                ?
            Padding(
              padding: EdgeInsets.all(
                8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Filter by:',
                    style:TextStyle(fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 10),

                  //Gender Filter
                  Text(
                    'Gender',
                    style: TextStyle(fontSize: 16),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.3,
                        child: OutlinedButton(
                          onPressed: () {
                            setState(() {
                              if (!filter.contains('Male')) {
                                filter.remove('Female');
                                // filter.remove('female');
                                filter.add('Male');
                              } else {
                                filter.remove('Male');
                              }
                            });
                            print(filter);
                          },
                          style: ButtonStyle(
                            backgroundColor: filter.contains('Male')
                                ? MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 224, 106, 0),
                            )
                                : MaterialStateProperty.all<Color>(
                              Colors.white,
                            ),
                            foregroundColor: !filter.contains('Male')
                                ? MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 224, 106, 0),
                            )
                                : MaterialStateProperty.all<Color>(
                              Colors.white,
                            ),
                          ),
                          child: Text(
                            'Male',
                            style:TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.3,
                        child: OutlinedButton(
                          onPressed: () {
                            setState(() {
                              if (!filter.contains('Female')) {
                                filter.remove('Male');
                                //filter.remove('Pants');
                                filter.add('Female');
                              } else {
                                filter.remove('Female');
                              }
                            });
                            print(filter);
                          },
                          style: ButtonStyle(
                            backgroundColor: filter.contains('Female')
                                ? MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 224, 106, 0),
                            )
                                : MaterialStateProperty.all<Color>(
                              Colors.white,
                            ),
                            foregroundColor: !filter.contains('Female')
                                ? MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 224, 106, 0),
                            )
                                : MaterialStateProperty.all<Color>(
                              Colors.white,
                            ),
                          ),
                          child: Text(
                            'Female',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1),

                  //Color Filter
                  // Text(
                  //   'Color',
                  //   style: GoogleFonts.dmSans(
                  //     fontSize: 16.sp,
                  //   ),
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     SizedBox(
                  //       width: 25.w,
                  //       child: OutlinedButton(
                  //         onPressed: () {
                  //           setState(() {
                  //             if (!filter.contains('White')) {
                  //               filter.remove('Black');
                  //               filter.remove('Brown');
                  //               filter.add('White');
                  //             } else {
                  //               filter.remove('White');
                  //             }
                  //           });
                  //           print(filter);
                  //         },
                  //         style: ButtonStyle(
                  //           backgroundColor: filter.contains('White')
                  //               ? MaterialStateProperty.all<Color>(
                  //                   const Color.fromARGB(255, 0, 0, 0),
                  //                 )
                  //               : MaterialStateProperty.all<Color>(
                  //                   Colors.white,
                  //                 ),
                  //           foregroundColor: !filter.contains('White')
                  //               ? MaterialStateProperty.all<Color>(
                  //                   const Color.fromARGB(255, 0, 0, 0),
                  //                 )
                  //               : MaterialStateProperty.all<Color>(
                  //                   Colors.white,
                  //                 ),
                  //         ),
                  //         child: Text(
                  //           'White',
                  //           style: GoogleFonts.dmSans(
                  //             fontSize: 16.sp,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: 25.w,
                  //       child: OutlinedButton(
                  //         onPressed: () {
                  //           setState(() {
                  //             if (!filter.contains('Black')) {
                  //               filter.remove('Brown');
                  //               filter.remove('White');
                  //               filter.add('Black');
                  //             } else {
                  //               filter.remove('Black');
                  //             }
                  //           });
                  //           print(filter);
                  //         },
                  //         style: ButtonStyle(
                  //           backgroundColor: filter.contains('Black')
                  //               ? MaterialStateProperty.all<Color>(
                  //                   const Color.fromARGB(255, 0, 0, 0),
                  //                 )
                  //               : MaterialStateProperty.all<Color>(
                  //                   Colors.white,
                  //                 ),
                  //           foregroundColor: !filter.contains('Black')
                  //               ? MaterialStateProperty.all<Color>(
                  //                   const Color.fromARGB(255, 0, 0, 0),
                  //                 )
                  //               : MaterialStateProperty.all<Color>(
                  //                   Colors.white,
                  //                 ),
                  //         ),
                  //         child: Text(
                  //           'Black',
                  //           style: GoogleFonts.dmSans(
                  //             fontSize: 16.sp,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: 25.w,
                  //       child: OutlinedButton(
                  //         onPressed: () {
                  //           setState(() {
                  //             if (!filter.contains('Brown')) {
                  //               filter.remove('Black');
                  //               filter.remove('White');
                  //               filter.add('Brown');
                  //             } else {
                  //               filter.remove('Brown');
                  //             }
                  //           });
                  //           print(filter);
                  //         },
                  //         style: ButtonStyle(
                  //           backgroundColor: filter.contains('Brown')
                  //               ? MaterialStateProperty.all<Color>(
                  //                   const Color.fromARGB(255, 0, 0, 0),
                  //                 )
                  //               : MaterialStateProperty.all<Color>(
                  //                   Colors.white,
                  //                 ),
                  //           foregroundColor: !filter.contains('Brown')
                  //               ? MaterialStateProperty.all<Color>(
                  //                   const Color.fromARGB(255, 0, 0, 0),
                  //                 )
                  //               : MaterialStateProperty.all<Color>(
                  //                   Colors.white,
                  //                 ),
                  //         ),
                  //         child: Text(
                  //           'Brown',
                  //           style: GoogleFonts.dmSans(
                  //             fontSize: 16.sp,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),


                  //Season Filter
                  Text(
                    'Season',
                    style: TextStyle(fontSize: 16),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.3,
                        child: OutlinedButton(
                          onPressed: () {
                            setState(() {
                              if (!filter.contains('Summer')) {
                                filter.remove('Winter');
                                filter.remove('Spring');
                                filter.add('Summer');
                              } else {
                                filter.remove('Summer');
                              }
                            });
                            print(filter);
                          },
                          style: ButtonStyle(
                            backgroundColor: filter.contains('Summer')
                                ? MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 224, 106, 0),
                            )
                                : MaterialStateProperty.all<Color>(
                              Colors.white,
                            ),
                            foregroundColor: !filter.contains('Summer')
                                ? MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 224, 106, 0),
                            )
                                : MaterialStateProperty.all<Color>(
                              Colors.white,
                            ),
                          ),
                          child: Text(
                            'Summer',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.3,
                        child: OutlinedButton(
                          onPressed: () {
                            setState(() {
                              if (!filter.contains('Winter')) {
                                filter.remove('Summer');
                                filter.remove('Spring');
                                filter.add('Winter');
                              } else {
                                filter.remove('Winter');
                              }
                            });
                            print(filter);
                          },
                          style: ButtonStyle(
                            backgroundColor: filter.contains('Winter')
                                ? MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 224, 106, 0),
                            )
                                : MaterialStateProperty.all<Color>(
                              Colors.white,
                            ),
                            foregroundColor: !filter.contains('Winter')
                                ? MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 224, 106, 0),
                            )
                                : MaterialStateProperty.all<Color>(
                              Colors.white,
                            ),
                          ),
                          child: Text(
                            'Winter',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.3,
                        child: OutlinedButton(
                          onPressed: () {
                            setState(() {
                              if (!filter.contains('Spring')) {
                                filter.remove('Summer');
                                filter.remove('Winter');
                                filter.add('Spring');
                              } else {
                                filter.remove('Spring');
                              }
                            });
                            print(filter);
                          },
                          style: ButtonStyle(
                            backgroundColor: filter.contains('Spring')
                                ? MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 224, 106, 0),
                            )
                                : MaterialStateProperty.all<Color>(
                              Colors.white,
                            ),
                            foregroundColor: !filter.contains('Spring')
                                ? MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 224, 106, 0),
                            )
                                : MaterialStateProperty.all<Color>(
                              Colors.white,
                            ),
                          ),
                          child: Text(
                            'Spring',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),

                  //Occasion filter
                  Text(
                    'Occasion',
                    style: TextStyle(fontSize: 16),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.3,
                        child: OutlinedButton(
                          onPressed: () {
                            setState(() {
                              if (!filter.contains('Work')) {
                                filter.remove('Weekend');
                                filter.remove('Wedding');
                                filter.add('Work');
                              } else {
                                filter.remove('Work');
                              }
                            });
                            print(filter);
                          },
                          style: ButtonStyle(
                            backgroundColor: filter.contains('Work')
                                ? MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 224, 106, 0),
                            )
                                : MaterialStateProperty.all<Color>(
                              Colors.white,
                            ),
                            foregroundColor: !filter.contains('Work')
                                ? MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 224, 106, 0),
                            )
                                : MaterialStateProperty.all<Color>(
                              Colors.white,
                            ),
                          ),
                          child: Text(
                            'Work',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.3,
                        child: OutlinedButton(
                          onPressed: () {
                            setState(() {
                              if (!filter.contains('Weekend')) {
                                filter.remove('Work');
                                filter.remove('Wedding');
                                filter.add('Weekend');
                              } else {
                                filter.remove('Weekend');
                              }
                            });
                            print(filter);
                          },
                          style: ButtonStyle(
                            backgroundColor: filter.contains('Weekend')
                                ? MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 224, 106, 0),
                            )
                                : MaterialStateProperty.all<Color>(
                              Colors.white,
                            ),
                            foregroundColor: !filter.contains('Weekend')
                                ? MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 224, 106, 0),
                            )
                                : MaterialStateProperty.all<Color>(
                              Colors.white,
                            ),
                          ),
                          child: Text(
                            'Weekend',
                            style:TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.3,
                        child: OutlinedButton(
                          onPressed: () {
                            setState(() {
                              if (!filter.contains('Wedding')) {
                                filter.remove('Weekend');
                                filter.remove('Work');
                                filter.add('Wedding');
                              } else {
                                filter.remove('Wedding');
                              }
                            });
                            print(filter);
                          },
                          style: ButtonStyle(
                            backgroundColor: filter.contains('Wedding')
                                ? MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 224, 106, 0),
                            )
                                : MaterialStateProperty.all<Color>(
                              Colors.white,
                            ),
                            foregroundColor: !filter.contains('Wedding')
                                ? MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 224, 106, 0),
                            )
                                : MaterialStateProperty.all<Color>(
                              Colors.white,
                            ),
                          ),
                          child: Text(
                            'Wedding',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
              ]
                      ),
                    ],
                  ),
            )
                :
            Container(),
          ],
        ),
      ),
    );
  }

  Future<Uint8List> generataApi(String imagePath) async {
    final gender = filter.contains('Male') ? 'male' : 'female';
    String occasion = '';
    String season ='';
    if(filter.contains('Work'))
    {
      occasion = 'work';
    }else if(filter.contains('Weekend'))
    {
      occasion = 'weekend';
    }else
    {
      occasion = 'wedding';
    }
    if(filter.contains('Summer'))
    {
      season = 'summer';
    }else if(filter.contains('Winter'))
    {
      season = 'winter';
    }else
    {
      season = 'spring';
    }
    var request = http.MultipartRequest(
        "POST", Uri.parse("http://16.170.217.4:8000/get_recommendation?Gender=$gender&Ocassion=$occasion&Season=$season"));
    print("Api: $request");
    request.files
        .add(await http.MultipartFile.fromPath("file", imagePath));
    request.headers.addAll({"accept": "application/json"});
    print("Api: $request");
    final response = await request.send();
    if (response.statusCode == 200) {
      print('remove background success');
      print('outfit_generation_api_code: ${response.statusCode}');
      Get.snackbar('Outfit Generated Successful', '${response.statusCode}');
      http.Response imgRes = await http.Response.fromStream(response);
      print('image: ${imgRes.bodyBytes}');
      return imgRes.bodyBytes;
    } else {
      print('remove background failed');
      print('outfit_generation_api_code: ${response.statusCode}');
      Get.snackbar(
          'Error', '"Error occurred with response ${response.statusCode}"',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      throw Exception("Error occurred with response ${response.statusCode}");
    }
  }


  Future<void> generateApiAndSaveImage(String imagePath) async {
    final Uint8List? imageBytes = img;
    // Generate a unique file name based on the current timestamp
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    String savedImagePath = '/data/user/0/com.example.fashionai_app/cache/generated_outfit_$timestamp.jpg';

    await saveImageToFile(imageBytes!, savedImagePath);
    // Now you can use savedImagePath as needed.

    setState(() {
      imageSavingInFirebase = File(savedImagePath);
    });

    print("image222: $imageSavingInFirebase");
  }
  Future<void> saveImageToFile(Uint8List imageData, String filePath) async {
    File? file = File(filePath);
    // Create the directory if it doesn't exist
    await file.parent.create(recursive: true);
    // Write the byte data to the file
    await file.writeAsBytes(Uint8List.fromList(imageData));

    print('File saved at: $file');
  }


  Future<Uint8List> removeBgApi(String imagePath) async {
    var request = http.MultipartRequest(
        "POST", Uri.parse("https://api.remove.bg/v1.0/removebg"));
    request.files
        .add(await http.MultipartFile.fromPath("file", imagePath));
    request.headers.addAll({"accept": "application/json"});

    final response = await request.send();
    if (response.statusCode == 200) {
      http.Response imgRes = await http.Response.fromStream(response);
      return imgRes.bodyBytes;
    } else {
      Get.snackbar(
          'Error', '"Error occurred with response ${response.statusCode}"',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      throw Exception("Error occurred with response ${response.statusCode}");
    }
  }
}
