# SGSPopover

[![CI Status](http://img.shields.io/travis/CharlsPrince/SGSPopover.svg?style=flat)](https://travis-ci.org/CharlsPrince/SGSPopover)
[![Version](https://img.shields.io/cocoapods/v/SGSPopover.svg?style=flat)](http://cocoapods.org/pods/SGSPopover)
[![License](https://img.shields.io/cocoapods/l/SGSPopover.svg?style=flat)](http://cocoapods.org/pods/SGSPopover)
[![Platform](https://img.shields.io/cocoapods/p/SGSPopover.svg?style=flat)](http://cocoapods.org/pods/SGSPopover)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

SGSPopover is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "SGSPopover"
```

## 使用方法
------
```
    UILabel *label = [[UILabel alloc] init];
    label.text = @"asdfasdfas";
    [label sizeToFit];
    self.popover = [[SGSPopover alloc] initWithContentView:label];
    self.popover.lineWidth = 5.0f;
    self.popover.lineColor = [UIColor redColor];
    self.popover.fillColor = [UIColor greenColor];
    self.popover.triangleRaduis = 5.0f;
    self.popover.widthEdge = 10.0;
    self.popover.heightEdge = 10.0f;
    self.popover.cornerRadius = 5.0f;
    self.popover.popoverStyle = SGSPopoverStyleLeft;
    [self.view addSubview:self.popover];
```


## Author

CharlsPrince, 961629701@qq.com

## License

SGSPopover is available under the MIT license. See the LICENSE file for more info.
