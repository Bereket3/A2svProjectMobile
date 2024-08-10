import "dart:io";


class CommandLine {
  Product pro = Product();

  void start(){
    /**
     * Starting point 
     * 
     * will handle basic user input's
     */
    print("wellcome");
    while (true) {
      print("To see all the item, type 1");
      print("To add item, type 2");
      print("To delete item, type 3");
      print("To edit an item, type 4");
      print("To view an item by name, type 5");
      print("To exit type exit.");
      print("");
      String? command = stdin.readLineSync();
      if(command == "2"){
        /**
         * add item
         */
        var items = this.itemAddition();
        var check = pro.addProduct(items[0], items[1], items[2]);
        if(check){
          print("The item was successfully added!");
        }
      } else if (command == "1") {
        /**
         * list items
         */
        pro.listItem();
      } else if (command == "3" ) {
        /**
         * delete item by its name
         */
        print("Enter an item you would like to delete.");
        String? itemName = stdin.readLineSync();
        pro.deleteItem(itemName);

      } else if (command == "4") {
        /**
         * edit item using it's name
         */
        this.update();

      } else if (command == "5") {
        /**
         * view produect by its name
         */
        this.viewProduct();

      } else if (command == "exit") {
        print("Exsiting... ");
        break;
      } 
      else {
        /**
         * invalid input exception
         */
        print("Invalid command, Try again!");
        print("");
      }
    }
  }

  List itemAddition() {
    /**
     * create a list of items for addition
     */
    print("Producet Name: ");
    String? product = stdin.readLineSync();
    print("Producet Price: ");
    String? price = stdin.readLineSync();
    print("Any additional mesage: ");
    String? additional_message = stdin.readLineSync();
    return [product, price, additional_message];
  }

  void update() {
    /**
     * Uses Product.editItem to update the product instatnces
     */
    print("Enter an item name you would like to edit.");
    var itemName = stdin.readLineSync();
    if (pro.find_item(itemName)) {
      print("Producet Name: ");
      String? product = stdin.readLineSync();
      print("Producet Price: ");
      String? price = stdin.readLineSync();
      print("Any additional mesage: ");
      String? additional_message = stdin.readLineSync();
      pro.editItem(itemName, product, price, additional_message);
    } else {
      print("The item you are looking for doesn't exist.");
    }
  }

  void viewProduct(){
    /**
     * 
     * find product eith its name and desplay it
     */
    print("Enter an item name you would like to see.");
    String? itemName =  stdin.readLineSync();
    if(pro.find_item(itemName)){
      print("Produect Name | Price | information");
      var item = pro.contaner[itemName];
       print("${item["name"]} | ${item["price"]} | ${item["info"]}");
    } else {
      print("The item you looking for doesn't exist in the database");
    }
  }
  
}

class Product {
    /**
     * 
     * main product Item contaner
     * 
     * uses map or hash map and map product item with its other properties
     *
     */
    Map contaner = {};
    int size = 0;

    bool find_item(String? itemName){
      if(itemName != null) {
        return this.contaner[itemName] != null;
      }
      return false;
    }

    bool isNumeric(String str) {
      /**
       * function to check if a the price can be converted to string
       * return true if the string is number false elsewise
       */
      try{
        var _ = double.parse(str);
        return true;
      } on FormatException {
        return false;
      }
    }

    Map validate(String? product, price, additional_msg) {
      /**
       * basic validation for the input  files
       */
      if(product == "") {
        print("Product name if required!");
        throw new Error();
      }
      if(price == "") {
        print("Product price if required!");
        throw new Error();
      }
      var check_price = this.isNumeric(price);
      if(!check_price){
        print("The producet price should be a number");
        throw new Error();
      }

      Map dict = {
        "name": product,
        "price": price,
        "info":additional_msg,
      };
      return dict;
    }

    bool addProduct (String? product, price, additional_msg) {
      /**
       * 
       * try to add a new product to the contaner if the fields are invalid it will allow to try
       * again
       */
      try {
        var obj = this.validate(product, price, additional_msg);
        this.contaner[product] = obj;
        this.size++;
        return true;
      } 
      catch (e) {
        print("Try Again!");
        return false;
      }
    }
    
    void listItem() {
      /**
       * view of all the items
       */
      print("Product Name | price  |  message");
      print("");
      for(var item in this.contaner.keys) {
        var curr = this.contaner[item];
        print("${curr["name"]} | ${curr["price"]} | ${curr["info"]}");
      }
    }
    
    void deleteItem(String? itemName) {
      /**
       * delete an item from the contaner
       */
      if(itemName != null) {
        try {
          this.contaner.remove(itemName);
          this.size--;
        } catch (e) {
          throw new Error();
        }
      }
    }

    void editItem(String? itemName, product, price, additional_msg) {
      /**
       * edit an item form the contaner
       */
      if (itemName != null) {
        this.contaner.update(itemName, (value) => {
          "name":product,
          "price":price,
          "info":additional_msg,
        });
      }
    }
}


void main () {
    var command_tool = CommandLine();
    command_tool.start();
}


