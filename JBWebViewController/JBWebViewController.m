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
    @property (nonatomic, strong) UIPopoverController *actionPopoverController;

@end

@implementation JBWebViewController

- (id)initWithUrl:(NSURL *)url {
    _url = url;
    [self setup];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor redColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)show {
    // Creates navigation controller, and presents it
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:self];
    
    [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:navigationController animated:YES completion:^{
        // Code
    }];
}

- (void)setup {
    // Allows navigationbar to overlap webview
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.edgesForExtendedLayout = UIRectEdgeTop;
    
    // Inset right buttons
    UIBarButtonItem *btnShare = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share)];
    UIBarButtonItem *btnRefresh = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(dismiss)];
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:btnRefresh, btnShare, nil]];
    
    // Add a webview
    _webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    [_webView setDelegate:self];
    [self.view addSubview:_webView];
    
    // Load url
    [_webView loadRequest:[NSURLRequest requestWithURL:_url]];
}

- (void)share {
    ARSafariActivity *safariActivity = [[ARSafariActivity alloc] init];
    ARChromeActivity *chromeActivity = [[ARChromeActivity alloc] init];
    
    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:@[self.webView.request.URL] applicationActivities:@[safariActivity, chromeActivity]];
    
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:^{
        // Code
    }];
}

#pragma mark - UIWebViewDelegate

#warning TODO: Progressbar for UIWebView

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return true;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}

@end
