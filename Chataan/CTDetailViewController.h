//
//  CTDetailViewController.h
//  Chataan
//
//  Created by Fahd Rafi on 10/10/2013.
//  Copyright (c) 2013 Fahd Rafi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) NSDictionary* entityLinks;
@property (weak, nonatomic) IBOutlet UIView *storiesView;
@property (weak, nonatomic) IBOutlet UIView *entitiesView;

@end
