//
//  LBSFHCartTableViewCell.m
//  Hotel Services
//
//  Created by Mr John Platsis on 05/08/2014.
//  Copyright (c) 2014 Mr John Platsis. All rights reserved.
//

#import "LBSFHCartTableViewCell.h"

@implementation LBSFHCartTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
