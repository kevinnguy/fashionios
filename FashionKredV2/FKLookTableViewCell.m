//
//  FKLookTableViewCell.m
//  FashionKredV2
//
//  Created by Kevin Nguy on 4/19/14.
//  Copyright (c) 2014 Kevin Nguy. All rights reserved.
//

#import "FKLookTableViewCell.h"

@implementation FKLookTableViewCell

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
    for (UIButton *button in self.buttons) {
        button.layer.borderColor = button.tintColor.CGColor;
        button.layer.borderWidth = 1;
        button.layer.cornerRadius = 4;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
