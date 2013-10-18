//
//  CTEntityViewCell.m
//  Chataan
//
//  Created by Fahd Rafi on 18/10/2013.
//  Copyright (c) 2013 Fahd Rafi. All rights reserved.
//

#import "CTEntityViewCell.h"

@implementation CTEntityViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
