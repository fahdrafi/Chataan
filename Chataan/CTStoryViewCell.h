//
//  CTStoryViewCell.h
//  Chataan
//
//  Created by Fahd Rafi on 14/10/2013.
//  Copyright (c) 2013 Fahd Rafi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTStoryViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *storyImage;
@property (weak, nonatomic) IBOutlet UILabel *storyTitle;
@property (weak, nonatomic) IBOutlet UILabel *storyDetail;

@end
