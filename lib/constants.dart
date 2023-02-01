import 'dart:io';

import 'package:bussiness_management/data/model/product_category_model.dart';
import 'package:bussiness_management/injection.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:path_provider/path_provider.dart';

Color darkOrange = const Color(0xFFf7941f);

Color lightOrange = const Color(0xFFfbaf3a);

Color lightWhite = const Color(0xFF7d7d7f);

Color mainColor = const Color.fromRGBO(9, 32, 66, 1);

Color backgroundColor = const Color(0xff0a2c35);

Color mainBgColor = const Color(0xff274851);

Color primaryColor = const Color(0xfff2bd57);

Color whiteColor = const Color(0xfff7f7f7);

Color textColor = const Color(0xff898989);

Color greyColor = const Color.fromARGB(255, 114, 137, 150);

int numOfDocToGet = 10;

Gradient btnGradient = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF025d91),
      Color(0xFF1b3c71),
    ]);

Gradient orangeGradient = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: [darkOrange, lightOrange]);

Gradient bgGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [const Color.fromRGBO(50, 70, 98, 1), mainColor]);

Widget title(String val) => Text(val,
    style: GoogleFonts.playfairDisplay(
      textStyle: TextStyle(fontSize: 25, letterSpacing: 1.4),
    ));

class CustomerSource {
  static String faceBook = 'facebook';
  static String telegram = 'telegram';
  static String whatsapp = 'whatsapp';
  static String instagram = 'instagram';
  static String family = 'family';
  static String customer = 'customer';
  static String custromerReferal = 'customer referal';
  static String showroom = 'showroom';

  static List<String> list = [
    faceBook,
    telegram,
    whatsapp,
    instagram,
    family,
    customer,
    custromerReferal,
    showroom
  ];
}

class PaymentMethod {
  static String CBE = 'CBE';
  static String Cash = 'Cash';
  static String Telebirr = 'Telebiir';
  static String Amole = 'Amole';
  static String Awash = 'Awash';
  static String others = 'others';

  static List<String> list = [CBE, Cash, Telebirr, Amole, Awash, others];
}

class DeliveryOption {
  static String pickUp = 'Pick up';
  static String delivery = 'Delivery';

  static List<String> list = [pickUp, delivery];
}

class ItemHistoryType {
  static String used = 'Used';
  static String buyed = 'Buyed';

  static List<String> list = [used, buyed];
}

class Gender {
  static String Male = "Male";
  static String Female = "Female";

  static List<String> list = [Male, Female];
}

class KK {
  static String Bole = "Bole";
  static String KolfeKeranyo = "Kolfe Keranyo";
  static String Gulele = "Gullele";
  static String Yeka = "Yeka";
  static String AddisKetema = "Addis Ketema";
  static String AkakyKaliti = "Akaki Kality";
  static String Kirkos = "Kirkos";
  static String Lidata = "Lideta";
  static String NifasSilk = "Nifas Silk";
  static String Arada = "Arada";
  static String LemiKura = "Lemi Kura";

  static List<String> list = [
    Bole,
    KolfeKeranyo,
    Gulele,
    Yeka,
    AddisKetema,
    AkakyKaliti,
    Kirkos,
    Lidata,
    NifasSilk,
    Arada,
    LemiKura,
  ];
}

class Units {
  static String Kg = "Kg";
  static String Pcs = "Pcs";
  static String Galon = "Galon";
  static String Packet = "Packet";

  static List<String> list = [Kg, Pcs, Galon, Packet];
}

class OrderStatus {
  static String Pending = "Pending";
  static String Delivered = 'Delivered';

  static List<String> list = [Pending, Delivered];
}

class ProductCategory {
  static String Bed = "Bed";
  static String BadyBed = "Baby bed";
  static String BunkBed = "Bunk bed";
  static String SingleBed = "Single bed";
  static String BookShelf = "Book shelf";
  static String ShoeShelf = "Shoe shelf";
  static String CoffeTable = "Coffee table";
  static String SofaTable = "Sofa table";
  static String KitchenCabinet = "Kitchen cabinet";
  static String Wardrode = "Wardrobe";
  static String Drawer = "Drawer";
  static String Door = "Door";
  static String DressingTable = "Dressing table";
  static String OfficeTable = "Office table";
  static String Reception = "Reception";
  static String TvRack = "Tv rack";
  static String Custom = "Custom";

  static List<String> list = [
    Bed,
    BadyBed,
    BunkBed,
    SingleBed,
    BookShelf,
    ShoeShelf,
    CoffeTable,
    SofaTable,
    KitchenCabinet,
    Wardrode,
    Drawer,
    Door,
    DressingTable,
    OfficeTable,
    Reception,
    TvRack,
    Custom,
  ];

  static List<ProductCategoryModel> listWIcons = list
      .map(
        (cat) => ProductCategoryModel(
            name: cat, assetImage: 'assets/$cat.png', quantity: 0),
      )
      .toList();
}

class ItemCategory {
  static String Finishing = "Finishing";
  static String Wood = "Wood";
  static String Accessories = "Accessories";

  static List<String> list = [Finishing, Wood, Accessories];
}

class ExpenseState {
  static String payed = 'Payed';
  static String unpayed = 'UnPayed';

  static List<String> list = [payed, unpayed];
}

class ExpenseCategory {
  static String rawMaterial = 'Raw Material';
  static String electricity = 'Electricity';
  static String showRoom = 'Show Room';
  static String employee = 'Employee';
  static String tools = 'Tools';
  static String transport = 'Transport';
  static String government = 'Government';

  static List<String> list = [
    rawMaterial,
    electricity,
    showRoom,
    employee,
    tools,
    transport,
    government
  ];
}

class UserPriority {
  static String Admin = 'Admin';
  static String Shopkeeper = 'Shopkeeper';
  static String Delivery = 'Delivery';
  static String Editor = 'Editor';

  static List<String> list = [Admin, Shopkeeper, Delivery, Editor];
}

class FirebaseConstants {
  static String products = 'products';
  static String customers = 'customers';
  static String items = 'items';
  static String orders = 'orders';
  static String expenses = 'expenses';
  static String users = 'users';
  static String orderCharts = "orderCharts";
  static String expenseCharts = "expenseCharts";
}

void toast(String message, ToastType toastType, {bool isLong = false}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: isLong ? Toast.LENGTH_SHORT : Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: toastType == ToastType.error ? Colors.red : Colors.green,
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastType { success, error }

enum RequestState { idle, loaded, loading, error }

Future<File?> displayImage(String imgUrl, String name, String dir) async {
  final filePath =
      "/storage/emulated/0/Android/data/com.example.bussiness_management/files/Images/$dir/$name.jpg";
  if (await File(filePath).exists()) {
    return File(filePath);
  } else {
    try {
      final imageId = await ImageDownloader.downloadImage(
        imgUrl,
        destination: AndroidDestinationType.custom(
          directory: 'Images',
          subDirectory: "$dir/$name.jpg",
        )..inExternalFilesDir(),
      );
      if (imageId != null) {
        var path = await ImageDownloader.findPath(imageId);
        return File(path!);
      } else {
        return File("");
      }
    } catch (e) {
      // toast(e.toString(), ToastType.error);
      return File("");
    }
  }
}
