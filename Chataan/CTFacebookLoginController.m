//
//  CTFacebookLoginController.m
//  Chataan
//
//  Created by Fahd Rafi on 21/10/2013.
//  Copyright (c) 2013 Fahd Rafi. All rights reserved.
//

#import "CTFacebookLoginController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface CTFacebookLoginController ()

@end

@implementation CTFacebookLoginController

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
    
//    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
//        // Yes, so just open the session (this won't display any UX).
//        [self openSession];
//    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneOrCancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)loginFacebook:(id)sender {
    [self.spinner startAnimating];
    self.loginButton.titleLabel.text = @"Logging in ...";
    self.loginButton.userInteractionEnabled = false;

    [self openSession];

}

- (void)loginFailed {
    [self.spinner stopAnimating];
    self.loginButton.titleLabel.text = @"Login to Facebook";
    self.loginButton.userInteractionEnabled = true;
}

- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error
{
    switch (state) {
        case FBSessionStateOpen: {
            [self.spinner stopAnimating];
            self.loginButton.titleLabel.text = @"Logged in to Facebook!";
        }
            break;
        case FBSessionStateClosed:
        case FBSessionStateClosedLoginFailed:
            [self.spinner stopAnimating];
            self.loginButton.titleLabel.text = @"Login Failed, try again?";
            self.loginButton.userInteractionEnabled = true;
            break;
        default:
            break;
    }
    
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:error.localizedDescription
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}

- (void)openSession
{
    [FBSession openActiveSessionWithReadPermissions:nil
                                       allowLoginUI:YES
                                  completionHandler:
     ^(FBSession *session, FBSessionState state, NSError *error) {
         [self sessionStateChanged:session state:state error:error];
     }];
}

@end
