import 'package:flutter/cupertino.dart';
import 'package:kabab/models/category.dart';
import 'package:kabab/models/sectionModelItem.dart';

class Categories with ChangeNotifier {
  List<Category> _items = [
    Category(
      id: 'c1',
      title: 'المحمدي',
      image: 'assets/images/p.jpeg',
      map: {
        'mokablat': [
          SectionModelItem(
            id: 'mo1',
            title: 'سلطة',
            image: 'assets/images/app.jpg',
            market: 'المحمدي',
            price: '9',
            cansPrices: {'small': '9', 'medium': '17', 'large': '28'},
          ),
          SectionModelItem(
            id: 'mo2',
            title: 'حمص',
            image: 'assets/images/app.jpg',
            market: 'المحمدي',
            price: '9',
            cansPrices: {'small': '9', 'medium': '17', 'large': '28'},
          ),
          SectionModelItem(
              id: 'mo3', title: 'دجاج', image: 'assets/images/app.jpg'),
          SectionModelItem(
              id: 'mo4', title: 'كفتة', image: 'assets/images/app.jpg'),
          SectionModelItem(
              id: 'mo5', title: 'بابا غنوج', image: 'assets/images/app.jpg'),
          SectionModelItem(
              id: 'mo6', title: 'فتوش', image: 'assets/images/app.jpg'),
        ],
        'maindishs': [
          SectionModelItem(
              id: 'mn1', title: 'كباب مسحب', image: 'assets/images/app.jpg')
        ],
        'meals': [
          SectionModelItem(
              id: 'me1', title: 'كباب فحم', image: 'assets/images/app.jpg')
        ],
        'New': [
          SectionModelItem(
              id: 'n1', title: 'كباب ', image: 'assets/images/app.jpg')
        ],
        'sandwishes': [
          SectionModelItem(
              id: 's1', title: 'شاورما', image: 'assets/images/app.jpg')
        ],
        'savingdishs': [
          SectionModelItem(
              id: 'sd1', title: 'فراخ', image: 'assets/images/app.jpg')
        ],
        'withmealdishs': [
          SectionModelItem(
              id: 'wmd1', title: 'جمص', image: 'assets/images/app.jpg')
        ],
        'drinks': [
          SectionModelItem(
              id: 'd1', title: 'بيبسي', image: 'assets/images/app.jpg')
        ]
      },
    ),
    Category(
      id: 'c2',
      title: 'الصباحى',
      image: 'assets/images/pro.jpg',
      map: {
        'mokablat': [
          SectionModelItem(
            id: 'mk1',
            title: 'حمص',
            image: 'assets/images/app.jpg',
            market: 'الصباحى',
            price: '9',
            cansPrices: {'small': '9', 'medium': '17', 'large': '28'},
          ),
          SectionModelItem(
            id: 'mk2',
            title: 'حمص',
            image: 'assets/images/app.jpg',
            market: 'الصباحى',
            price: '9',
            cansPrices: {'small': '9', 'medium': '17', 'large': '28'},
          ),
        ],
        'maindishs': [
          SectionModelItem(
              id: 'mn1', title: 'سلطة', image: 'assets/images/app.jpg')
        ],
        'meals': [
          SectionModelItem(
              id: 'me1', title: 'كباب فحم', image: 'assets/images/app.jpg')
        ],
        'New': [
          SectionModelItem(
              id: 'n1', title: 'كباب ', image: 'assets/images/app.jpg')
        ],
        'sandwishes': [
          SectionModelItem(
              id: 's1', title: 'شاورما', image: 'assets/images/app.jpg')
        ],
        'savingdishs': [
          SectionModelItem(
              id: 'sd1', title: 'فراخ', image: 'assets/images/app.jpg')
        ],
        'withmealdishs': [
          SectionModelItem(
              id: 'wmd1', title: 'جمص', image: 'assets/images/app.jpg')
        ],
        'drinks': [
          SectionModelItem(
              id: 'd1', title: 'بيبسي', image: 'assets/images/app.jpg')
        ]
      },
    ),
    Category(
      id: 'c3',
      title: 'الحلبي',
      image: 'assets/images/shaw.jpg',
      map: {
        'mokablat': [
          SectionModelItem(
            id: 'mb1',
            title: 'حمص',
            image: 'assets/images/app.jpg',
            market: 'الحلبي',
            price: '9',
            cansPrices: {'small': '9', 'medium': '17', 'large': '28'},
          ),
        ],
        'maindishs': [
          SectionModelItem(
              id: 'mn1', title: 'سلطة', image: 'assets/images/app.jpg')
        ],
        'meals': [
          SectionModelItem(
              id: 'me1', title: 'كباب فحم', image: 'assets/images/app.jpg')
        ],
        'New': [
          SectionModelItem(
              id: 'n1', title: 'كباب ', image: 'assets/images/app.jpg')
        ],
        'sandwishes': [
          SectionModelItem(
              id: 's1', title: 'شاورما', image: 'assets/images/app.jpg')
        ],
        'savingdishs': [
          SectionModelItem(
              id: 'sd1', title: 'فراخ', image: 'assets/images/app.jpg')
        ],
        'withmealdishs': [
          SectionModelItem(
              id: 'wmd1', title: 'جمص', image: 'assets/images/app.jpg')
        ],
        'drinks': [
          SectionModelItem(
              id: 'd1', title: 'بيبسي', image: 'assets/images/app.jpg')
        ]
      },
    ),
    Category(
      id: 'c4',
      title: 'الدمشقي',
      image: 'assets/images/crip.jpeg',
      map: {
        'mokablat': [
          SectionModelItem(
              id: 'mo1', title: 'سلطة', image: 'assets/images/app.jpg'),
          SectionModelItem(
              id: 'mo2', title: 'سلطة', image: 'assets/images/app.jpg'),
        ],
        'maindishs': [
          SectionModelItem(
              id: 'mn1', title: 'سلطة', image: 'assets/images/app.jpg')
        ],
        'meals': [
          SectionModelItem(
              id: 'me1', title: 'كباب فحم', image: 'assets/images/app.jpg')
        ],
        'New': [
          SectionModelItem(
              id: 'n1', title: 'كباب ', image: 'assets/images/app.jpg')
        ],
        'sandwishes': [
          SectionModelItem(
              id: 's1', title: 'شاورما', image: 'assets/images/app.jpg')
        ],
        'savingdishs': [
          SectionModelItem(
              id: 'sd1', title: 'فراخ', image: 'assets/images/app.jpg')
        ],
        'withmealdishs': [
          SectionModelItem(
              id: 'wmd1', title: 'جمص', image: 'assets/images/app.jpg')
        ],
        'drinks': [
          SectionModelItem(
              id: 'd1', title: 'بيبسي', image: 'assets/images/app.jpg')
        ]
      },
    ),
    Category(
      id: 'c5',
      title: 'الحاتي',
      image: 'assets/images/fore.jpg',
      map: {
        'mokablat': [
          SectionModelItem(
              id: 'mo1', title: 'سلطة', image: 'assets/images/app.jpg'),
          SectionModelItem(
              id: 'mo2', title: 'سلطة', image: 'assets/images/app.jpg'),
        ],
        'maindishs': [
          SectionModelItem(
              id: 'mn1', title: 'سلطة', image: 'assets/images/app.jpg')
        ],
        'meals': [
          SectionModelItem(
              id: 'me1', title: 'كباب فحم', image: 'assets/images/app.jpg')
        ],
        'New': [
          SectionModelItem(
              id: 'n1', title: 'كباب ', image: 'assets/images/app.jpg')
        ],
        'sandwishes': [
          SectionModelItem(
              id: 's1', title: 'شاورما', image: 'assets/images/app.jpg')
        ],
        'savingdishs': [
          SectionModelItem(
              id: 'sd1', title: 'فراخ', image: 'assets/images/app.jpg')
        ],
        'withmealdishs': [
          SectionModelItem(
              id: 'wmd1', title: 'جمص', image: 'assets/images/app.jpg')
        ],
        'drinks': [
          SectionModelItem(
              id: 'd1', title: 'بيبسي', image: 'assets/images/app.jpg')
        ]
      },
    )
  ];

  List<Category> get items {
    return [..._items];
  }
}
