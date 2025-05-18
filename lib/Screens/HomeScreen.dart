import 'package:assingment/Screens/DetailScreen.dart';
import 'package:assingment/Services/ApiService.dart';
import 'package:assingment/model/ProductModel.dart';
import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final apiService = ApiService();
  var seletedCategory = 'all';
  var fillterList = [];
  var feachData = [];
  var price = RangeValues(1, 500);
  static const caterogy = [
    'all',
    "beauty",
    "fragrances",
    "furniture",
    "groceries",
    "home-decoration",
    "kitchen-accessories",
    "laptops",
    "mens-shirts",
    "mens-shoes",
    "mens-watches",
    "mobile-accessories",
    "motorcycle",
    "skin-care",
    "smartphones",
    "sports-accessories",
    "sunglasses",
    "tablets",
    "tops",
    "vehicle",
    "womens-bags",
    "womens-dresses",
    "womens-jewellery",
    "womens-shoes",
    "womens-watches",
  ];

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  void feachProfuct()async{
    feachData = await apiService.getAllProducts()??[];
    setState(() {
      print('data get $feachData');
      fillterList = feachData;
    });

  }
  @override
  void initState() {
    super.initState();
     feachProfuct();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Screen')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text('Category'),
                    SizedBox(width: 10),
                    DropdownButton(
                      value: seletedCategory,
                      items:
                      caterogy.map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text(capitalize(e)),
                        );
                      }).toList(),
                      onChanged: (value) {
                        seletedCategory = value ?? 'all';
                        applyFillter();
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('Price'),
                    SizedBox(width: 10),
                    RangeSlider(
                      labels: RangeLabels(
                        price.start.round().toString(),
                        price.end.round().toString(),
                      ),
                      divisions: 500,
                      values: price,
                      min: 1,
                      max: 500,
                      onChanged: (value) {
                        price = value;
                        applyFillter();
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              itemCount:fillterList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.6
              ),
              itemBuilder:
                  (context, index) => ProductItemView(product: fillterList[index]),
            ),
          ),
        ],
      ),
    );
  }
  void applyFillter() {
    setState(() {
      fillterList = feachData.where((product) {
        final inCategory = seletedCategory == 'all' || product.category == seletedCategory;
        final inPrice = product.price >=price.start && product.price <= price.end;
        print('is in $inPrice');
        return inCategory && inPrice;
      }).toList();
    });
  }
}

class ProductItemView extends StatelessWidget {
  final ProductModel product;

  const ProductItemView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Detailscreen(product: product,)),
        );
      },
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(product.thumbnail),
            Text(product.title),
            Text('\$ ${product.price}'),
          ],
        ),
      ),
    );
  }
}
