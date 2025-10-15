enum DeliveryType { PICKUP, DELIVERY }

class Product {
  final int id;
  final String name;
  final double price;

  const Product({required this.id, required this.name, required this.price});

  @override
  String toString() => 'Product: $name (\$${price.toStringAsFixed(2)})';
}

class Customer {
  final String name;
  final String email;

  const Customer({required this.name, required this.email});

  @override
  String toString() => 'Customer: $name <$email>';
}

class Address {
  final String street;
  final String city;
  final String zipCode;

  const Address({
    required this.street,
    required this.city,
    required this.zipCode,
  });

  @override
  String toString() => '$street, $city ($zipCode)';
}

class Order {
  final int id;
  final Customer customer;
  final List<Product> products;
  final DeliveryType deliveryType;
  final Address? deliveryAddress;

  const Order({
    required this.id,
    required this.customer,
    required this.products,
    required this.deliveryType,
    this.deliveryAddress,
  });

  double totalAmount() {
    double total = 0;
    for (var product in products) {
      total += product.price;
    }

    if (deliveryType == DeliveryType.DELIVERY) {
      total += 2.0;
    }
    return total;
  }

  @override
  String toString() {
    final deliveryInfo = deliveryType == DeliveryType.PICKUP
        ? 'Pickup at Shop'
        : 'Delivered to: ${deliveryAddress.toString()}';
    return '''
      Order ID: $id
      Customer: ${customer.name}
      Delivery Type: ${deliveryType.name}
      $deliveryInfo
      Products:
        ${products.map((p) => "- ${p.name} (\$${p.price})").join("\n        ")}
      -----------------------------------
      Total: \$${totalAmount().toStringAsFixed(2)}
''';
  }
}

void main() {
  var p1 = Product(id: 1, name: "Laptop", price: 899.99);
  var p2 = Product(id: 2, name: "Mouse", price: 25.50);
  var p3 = Product(id: 3, name: "Headphones", price: 59.99);

  var c1 = Customer(name: "Alice", email: "alice@example.com");

  var address1 = Address(
    street: "123 Main Street",
    city: "Phnom Penh",
    zipCode: "12000",
  );

  var order1 = Order(
    id: 101,
    customer: c1,
    products: [p1, p2],
    deliveryType: DeliveryType.PICKUP,
  );

  var order2 = Order(
    id: 102,
    customer: c1,
    products: [p3],
    deliveryType: DeliveryType.DELIVERY,
    deliveryAddress: address1,
  );

  print(order1);
  print(order2);
}
