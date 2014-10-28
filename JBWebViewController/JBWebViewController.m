//
//  JBWebViewController.m
//  JBWebViewController
//
//  Created by Jonas Boserup on 28/10/14.
//  Copyright (c) 2014 Jonas Boserup. All rights reserved.
//

#import "JBWebViewController.h"

@interface JBWebViewController ()

    @property NSURL *url;
    @property UIWebView *webView;

@end

@implementation JBWebViewController

- (id)initWithUrl:(NSURL *)url {
    _url = url;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor redColor];
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)show {
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:self];
    
    [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:navigationController animated:YES completion:^{
        // Code
    }];
}

- (void)setup {
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.edgesForExtendedLayout = UIRectEdgeTop;
    
    _webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:_webView];
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://google.com"]]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
