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
    @property UILabel *titleLabel;
    @property UILabel *subtitleLabel;
    @property UIView *titleView;
    @property (nonatomic, strong) UIPopoverController *popoverShareController;
    @property NJKWebViewProgressView *progressView;
    @property NJKWebViewProgress *progressProxy;

    @property BOOL hasExtraButtons;

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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height - 2, self.navigationController.navigationBar.frame.size.width, 2)];
    [self.navigationController.navigationBar addSubview:_progressView];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Remove progress view
    // because UINavigationBar is shared with other ViewControllers
    [_progressView removeFromSuperview];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [self adjustNavigationbar];
}

- (void)show {
    // Creates navigation controller, and presents it
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:self];
    
    [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:navigationController animated:YES completion:^{
        // Code
    }];
}

- (void)setup {
    // Default value
    _hasExtraButtons = NO;
    
    // Allows navigationbar to overlap webview
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.edgesForExtendedLayout = UIRectEdgeTop;
    
    // Create title & subtitle labels
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_titleLabel setBackgroundColor:[UIColor clearColor]];
    [_titleLabel setTextColor:[UIColor blackColor]];
    [_titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [_titleLabel setTextAlignment:NSTextAlignmentNatural];
    [_titleLabel setText:@"Loading.."];
    [_titleLabel sizeToFit];
    
    _subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 14, 0, 0)];
    [_subtitleLabel setBackgroundColor:[UIColor clearColor]];
    [_subtitleLabel setTextColor:[UIColor blackColor]];
    [_subtitleLabel setFont:[UIFont systemFontOfSize:12]];
    [_subtitleLabel setTextAlignment:NSTextAlignmentLeft];
    [_subtitleLabel setText:[self getDomainFromString:[NSString stringWithFormat:@"%@", _url]]];
    [_subtitleLabel sizeToFit];
    
    // Correct frame sizes after sizeToFit
    [self adjustNavigationbar];
    
    // Add new titleview with labels
    _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    [_titleView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    
    [_titleView addSubview:_titleLabel];
    [_titleView addSubview:_subtitleLabel];

    self.navigationItem.titleView = _titleView;
    
    // Inset right buttons
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share)];
    UIBarButtonItem *dismissButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(dismiss)];
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:dismissButton, shareButton, nil]];
    
    // Add a webview
    _webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    [_webView setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    
    _progressProxy = [[NJKWebViewProgress alloc] init];
    _webView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    CGFloat progressBarHeight = 2.f;
    CGRect navigaitonBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigaitonBarBounds.size.height - progressBarHeight, navigaitonBarBounds.size.width, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
    [self.view addSubview:_webView];
    
    // Load url
    [_webView loadRequest:[NSURLRequest requestWithURL:_url]];
}

- (void)share {
    ARSafariActivity *safariActivity = [[ARSafariActivity alloc] init];
    ARChromeActivity *chromeActivity = [[ARChromeActivity alloc] init];
    
    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:@[self.webView.request.URL] applicationActivities:@[safariActivity, chromeActivity]];
    
     if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
         if(_popoverShareController) {
             [_popoverShareController dismissPopoverAnimated:YES];
         }
         _popoverShareController = [[UIPopoverController alloc] initWithContentViewController:controller];
         [_popoverShareController presentPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItems[1] permittedArrowDirections: UIPopoverArrowDirectionAny animated:YES];
     } else {
         [self presentViewController:controller animated:YES completion:nil];
     }
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:^{
        // Code
    }];
}

- (void)adjustNavigationbar {
    float buttonsWidth;
    
    if(_hasExtraButtons) {
        buttonsWidth = 220;
    } else {
        buttonsWidth = 110;
    }
    
    [_titleLabel setFrame:CGRectMake(_titleLabel.frame.origin.x, _titleLabel.frame.origin.y, MIN(_titleLabel.frame.size.width, self.view.frame.size.width - buttonsWidth), _titleLabel.frame.size.height)];
    [_subtitleLabel setFrame:CGRectMake(_subtitleLabel.frame.origin.x, _subtitleLabel.frame.origin.y, MIN(_subtitleLabel.frame.size.width, self.view.frame.size.width - buttonsWidth), _subtitleLabel.frame.size.height)];
}

- (void)addNavigationButtonsButtons {
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(navigateBack)];
    UIBarButtonItem *forwardButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(navigateForward)];
    [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:backButton, forwardButton, nil]];
    
    _hasExtraButtons = YES;
    
    [self adjustNavigationbar];
}

- (void)updateNavigationButtons {
    if(!self.navigationItem.leftBarButtonItems.count && [_webView canGoBack]) {
        [self addNavigationButtonsButtons];
    }
    
    if([_webView canGoBack]) {
        ((UIBarButtonItem *)self.navigationItem.leftBarButtonItems[0]).enabled = YES;
    } else {
        ((UIBarButtonItem *)self.navigationItem.leftBarButtonItems[0]).enabled = NO;
    }
    
    if([_webView canGoForward]) {
        ((UIBarButtonItem *)self.navigationItem.leftBarButtonItems[1]).enabled = YES;
    } else {
        ((UIBarButtonItem *)self.navigationItem.leftBarButtonItems[1]).enabled = NO;
    }
}

- (void)navigateBack {
    [_webView goBack];
}

- (void)navigateForward {
    [_webView goForward];
}

- (void)setWebTitle:(NSString *)title {
    [_titleLabel setText:title];
    [_titleLabel sizeToFit];
    [self adjustNavigationbar];
}

- (void)setWebSubtitle:(NSString *)subtitle {
    [_subtitleLabel setText:subtitle];
    [_subtitleLabel sizeToFit];
    [self adjustNavigationbar];
}

- (NSString *)getDomainFromString:(NSString*)string
{
    NSArray *components = [string componentsSeparatedByString:@"/"];
    for (NSString *match in components) {
        if ([match rangeOfString:@"."].location != NSNotFound){
            return match;
        }
    }
    return nil;
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return true;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *title = [webView stringByEvaluatingJavaScriptFromString: @"document.title"];
    NSString *subtitle = [webView stringByEvaluatingJavaScriptFromString:@"document.domain"];
    
    [self setWebTitle:title];
    [self setWebSubtitle:subtitle];
    
    [self updateNavigationButtons];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"%@", [error localizedDescription]);
}

#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
    
    NSString *title = [_webView stringByEvaluatingJavaScriptFromString: @"document.title"];
    
    if(title.length == 0) {
        [self setWebTitle:@"Loading.."];
    } else {
        [self setWebTitle:title];
    }
}

@end
