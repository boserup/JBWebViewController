JBWebViewController
===================

A drop-in Facebook inspired modal web browser.

## How to use
JBWebViewController is ment to be shown modally, which is recommended to be down with it's built in show functionality. Whilst not being recommended, it is however possible to present JBWebViewController outside a modal view controller. JBWebViewController show always be connected to a UINavigationController.

### Presenting JBWebViewController
```objectivec
JBWebViewController *controller = [[JBWebViewController alloc] initWithUrl:[NSURL URLWithString:@"http://www.apple.com/iphone/"]];

[controller show];
```

### Presenting JBWebViewController with block
```objectivec
JBWebViewController *controller = [[JBWebViewController alloc] initWithUrl:[NSURL URLWithString:@"http://www.apple.com/iphone/"]];

[controller showControllerWithCompletion:^(JBWebViewController *controller) {
    NSLog(@"Controller has arrived.");
}];
```

### Navigate to URL
```objectivec
[controller navigateToURL:[NSURL URLWithString:@"http://www.apple.com/ios/"]];
```

### Load custom NSURLRequest
```objectivec
NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://developer.apple.com/"]];
[controller loadRequest:request];
```


### Reload current page
```objectivec
[controller reload];
```

### Manually setting controller title
```objectivec
[controller setWebTitle:@"The quick brown fox"];
```

### Getting controller title
```objectivec
NSString *controllerTitle = [controller getWebTitle];
```

### Manually setting controller subtitle
```objectivec
[controller setWebSubtitle:@"foo bar"];
```

### Getting controller subtitle
```objectivec
NSString *controllerSubtitle = [controller getWebSubtitle];
```
