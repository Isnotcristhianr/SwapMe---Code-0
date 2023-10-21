import '../app/data/models/product_model.dart';
import 'constants.dart';

class DummyHelper {
  const DummyHelper._();

  static List<ProductModel> products = [
    ProductModel(
      id: '1',
      image: Constants.product1,
      name: 'Blusa Basica',
      quantity: 1,
      price: 15.50,
      rating: 4.5,
      reviews: '12 reviews',
      size: 'M',
      isFavorite: false,
    ),
    ProductModel(
      id:' 2',
      image: Constants.product2,
      name: 'Blusa Shein',
      quantity: 1,
      price: 14.99,
      rating: 4.0,
      reviews: '10 reviews',
      size: 'M',
      isFavorite: false
    ),
    ProductModel(
      id: '3',
      image: Constants.product3,
      name: 'Buso Tigers Original',
      quantity: 1,
      price: 29.99,
      rating: 4.8,
      reviews: '22 reviews',
      size: 'L',
      isFavorite: false
    ),
    ProductModel(
      id: '4',
      image: Constants.product4,
      name: 'Sudadera Verano',
      quantity: 1,
      price: 20.99,
      rating: 3.9,
      reviews: '14 reviews',
      size: 'L',
      isFavorite: false
    ),
    ProductModel(
      id: '5',
      image: Constants.product5,
      name: 'Pamtalon Zara',
      quantity: 1,
      price: 10.99,
      rating: 4.1,
      reviews: '26 reviews',
      size: 'M',
      isFavorite: false
    ),
    ProductModel(
      id: '6',
      image: Constants.product6,
      name: 'Chamarra Piloto',
      quantity: 1,
      price: 24.99,
      rating: 4.0,
      reviews: '58 reviews',
      size: 'S',
      isFavorite: false
    ),
  ];

}