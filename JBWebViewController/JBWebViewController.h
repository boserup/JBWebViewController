//
//  JBWebViewController.h
//  JBWebViewController
//
//  Created by Jonas Boserup on 28/10/14.
//  Copyright (c) 2014 Jonas Boserup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

#import <ARChromeActivity/ARChromeActivity.h>
#import <ARSafariActivity/ARSafariActivity.h>

@interface JBWebViewController : UIViewController <UIWebViewDelegate>

- (id)initWithUrl:(NSURL *)url;
- (void)show;
- (void)dismiss;

@end
