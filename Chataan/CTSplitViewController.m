//
//  CTSplitViewController.m
//  Chataan
//
//  Created by Fahd Rafi on 21/10/2013.
//  Copyright (c) 2013 Fahd Rafi. All rights reserved.
//

#import "CTSplitViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface CTSplitViewController ()

@end

@implementation CTSplitViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

//    if (FBSession.activeSession.state != FBSessionStateCreatedTokenLoaded) {
//        [self performSelector:@selector(showFacebookLogin) withObject:self afterDelay:0.0];
//    }
}

- (void)showFacebookLogin {
    [self performSegueWithIdentifier:@"FacebookLoginModal" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
