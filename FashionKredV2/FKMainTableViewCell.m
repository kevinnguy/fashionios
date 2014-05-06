//
//  FKMainTableViewCell.m
//  FashionKredV2
//
//  Created by Kevin Nguy on 4/18/14.
//  Copyright (c) 2014 Kevin Nguy. All rights reserved.
//

#import "FKMainTableViewCell.h"

#import "FKLookTableViewCell.h"
#import "FKItemTableViewCell.h"

@implementation FKMainTableViewCell

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
    int width = CGRectGetWidth(self.mainScrollView.frame);
    int height = CGRectGetHeight(self.mainScrollView.frame);
    
    self.mainScrollView.contentSize = CGSizeMake(3 * width, height);
    
    self.frontPageImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    
    self.lookTableView = [[FKLookTableView alloc] initWithFrame:CGRectMake(width, 0, width, height) style:UITableViewStylePlain];
    [self.lookTableView registerNib:[UINib nibWithNibName:@"FKLookTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LookCellIdentifier"];
    FKLookTableViewCell *cell = [self.lookTableView dequeueReusableCellWithIdentifier:@"LookCellIdentifier"];
    self.lookTableView.rowHeight = CGRectGetHeight(cell.frame);
    
    self.itemsTableView = [[FKItemsTableView alloc] initWithFrame:CGRectMake(width * 2, 0, width, height) style:UITableViewStylePlain];
    [self.itemsTableView registerNib:[UINib nibWithNibName:@"FKItemTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ItemsCellIdentifier"];
    FKItemTableViewCell *itemCell = [self.itemsTableView dequeueReusableCellWithIdentifier:@"ItemsCellIdentifier"];
    self.itemsTableView.rowHeight = CGRectGetHeight(itemCell.frame);
    
    [self.mainScrollView addSubview:self.frontPageImageView];
    [self.mainScrollView addSubview:self.lookTableView];
    [self.mainScrollView addSubview:self.itemsTableView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
