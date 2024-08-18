import 'dart:io';

class Player {
  String name;
  List<String> inventory = [];

  Player(this.name) {}

  void addItem(String item) {
    inventory.add(item);
    print('You picked up a $item');
  }

  void useItem(String item) {
    if (inventory.contains(item)) {
      // Implement item usage logic here
      print('You used the $item');
      inventory.remove(item);
    } else {
      print('You don\'t have that item');
    }
  }
}

class Location {
  String name;
  String description;
  Map<String, int> exits;
  List<String> items;

  Location(this.name, this.description, this.exits, this.items);
}

void main() {
  Player player = Player('Hero');
  List<Location> locations = [
    Location('Forest', 'A dense forest with tall trees.',
        {'north': 1, 'south': 3}, ['sword']),
    Location('Cave', 'A dark and mysterious cave.', {'south': 0}, ['gold']),
    Location('Mountain', 'A towering mountain.', {'west': 0, 'east': 3}, []),
    Location('River', 'A calm river.', {'east': 2}, ['fish'])
  ];

  int currentLocation = 0; // Start at the first location

  while (true) {
    Location current = locations[currentLocation];
    print(current.description);
    print('Exits: ${current.exits.keys.join(', ')}');
    print('Items in this location: ${current.items}');
    print('Your inventory: ${player.inventory}');

    print('What do you want to do? (move, take, use, quit)');
    String action = stdin.readLineSync()!.toLowerCase();

    if (action == 'move') {
      print('Enter direction:');
      String direction = stdin.readLineSync()!.toLowerCase();
      if (current.exits.containsKey(direction)) {
        currentLocation = current.exits[direction]!;
        print('You moved ${direction}');
      } else {
        print('Invalid direction');
      }
    } else if (action == 'take') {
      print('Enter item name:');
      String item = stdin.readLineSync()!.toLowerCase();
      if (current.items.contains(item)) {
        player.addItem(item);
        current.items.remove(item);
        print('You picked up the $item');
      } else {
        print('Item not found');
      }
    } else if (action == 'use') {
      print('Enter item name:');
      String item = stdin.readLineSync()!.toLowerCase();
      player.useItem(item);
    } else if (action == 'quit') {
      break;
    } else {
      print('Invalid action');
      
    }
  }
}
