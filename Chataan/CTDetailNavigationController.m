//
//  CTDetailNavigationController.m
//  Chataan
//
//  Created by Fahd Rafi on 19/10/2013.
//  Copyright (c) 2013 Fahd Rafi. All rights reserved.
//

#import "CTDetailNavigationController.h"

@interface CTDetailNavigationController ()

@end

@implementation CTDetailNavigationController

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
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveArticleNotification:) name:@"ArticleClicked" object:nil];
    
}

//- (void)receiveArticleNotification:(NSNotification*)notif {
//    [self performSegueWithIdentifier:@"DetailPushWebView" sender:self];
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
