//
//  ViewController.m
//  JBWebViewController
//
//  Created by Jonas Boserup on 28/10/14.
//  Copyright (c) 2014 Jonas Boserup. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showModal:(id)sender {
    // Creating JBWebViewController and loading URL from text field.
    JBWebViewController *controller = [[JBWebViewController alloc] initWithUrl:[NSURL URLWithString:_urlField.text]];
    
    // Simple method for showing controller
    // [controller show];
    
    // Localization (not required, default is 'Loading..')
    // [controller setLoadingString:@"Chargement.."];
    
    // Method for showing controller with completion block
    [controller showControllerWithCompletion:^(JBWebViewController *controller) {
        // Completion typedef block
        NSLog(@"Controller has arrived.");
    }];
    
    
}

-(IBAction)showFrom:(id)sender {
    JBWebViewController *controller = [[JBWebViewController alloc] initWithUrl:[NSURL URLWithString:_urlField.text]];
    [controller showFromController:self WithCompletion:^(JBWebViewController *controller) {
        NSLog(@"Controller has arrived");
    }];
}
@end
