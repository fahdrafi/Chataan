//
//  CTWebViewController.m
//  Chataan
//
//  Created by Fahd Rafi on 19/10/2013.
//  Copyright (c) 2013 Fahd Rafi. All rights reserved.
//

#import "CTWebViewController.h"

@interface CTWebViewController ()

@end

@implementation CTWebViewController

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
}

- (void)setArticle:(CTArticle*)article {
    UIWebView* webView = (UIWebView*)self.view;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:article.url]]];
    self.navigationItem.title = article.title;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
