# Simple radio group
It's simple, support form validator and controller.

## Usage
```dart
    SimpleRadioGroup<String>(
      direction: Axis.horizontal,
      validator: (String? option) {
        if (option == null) {
          return "Required";
        }
        return null;
      },
      options: const [
        "Option 1",
        "Option 2",
        "Options 3",
      ],
    )
```

![Example](https://github.com/juarezfranco/flutter_simple_radio_group/blob/main/img/example.png)


# Author

juarezfrancojr@gmail.com
