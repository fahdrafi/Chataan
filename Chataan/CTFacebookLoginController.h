//
//  CTFacebookLoginController.h
//  Chataan
//
//  Created by Fahd Rafi on 21/10/2013.
//  Copyright (c) 2013 Fahd Rafi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTFacebookLoginController : UIViewController
- (IBAction)doneOrCancelButton:(id)sender;
- (IBAction)loginFacebook:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@end
