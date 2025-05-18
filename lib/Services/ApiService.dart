import 'dart:convert'as converter;
import '../model/ProductModel.dart';
import 'package:http/http.dart' as http;

const BASEURL = 'https://dummyjson.com';

class ApiService{

  Future<List<ProductModel>?> getAllProducts() async{
    List<ProductModel>  products = [];
    try{
      final uri = Uri.parse('$BASEURL/products');
      var responce = await http.get(uri);
      if(responce.statusCode==200){
        var json = converter.jsonDecode(responce.body);
        var productsJson  = json['products'] as List<dynamic>;
        productsJson.forEach((element) {
          products.add(ProductModel(
            id: element['id'],
              title: element['title'],
              discription: element['description'],
              category: element['category'],
              price: element['price'],
              images: element['images'],
              thumbnail: element['thumbnail']
          ));
        },);
        return products;
      }else{
        return null;
      }
    }catch(e){
      print(e);
      return null;
    }

  }
  
  Future<List<ProductModel>> getProductByCategory(String category) async {
    List<ProductModel> listOfProdutct = [];
    try{
      final uri = Uri.parse('${BASEURL}/products/category/$category');
      var responce = await http.get(uri);
      if(responce.statusCode==200){
        var json = converter.jsonDecode(responce.body);
        var productsJson  = json['products'] as List<dynamic>;
        productsJson.forEach((element) {
          listOfProdutct.add(ProductModel(
              id: element['id'],
              title: element['title'],
              discription: element['description'],
              category: element['category'],
              price: element['price'],
              images: element['images'],
              thumbnail: element['thumbnail']
          ));
        },);
        return listOfProdutct;
      }else{
        return listOfProdutct;
      }
    }catch(e){
      print(e);
      return listOfProdutct;
    }
  }
}