//
//  FKMainTableViewCell.h
//  FashionKredV2
//
//  Created by Kevin Nguy on 4/18/14.
//  Copyright (c) 2014 Kevin Nguy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FKLookTableView.h"
#import "FKItemsTableView.h"

@interface FKMainTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (nonatomic, strong) UIImageView *frontPageImageView;
@property (nonatomic, strong) FKLookTableView *lookTableView;
@property (nonatomic, strong) FKItemsTableView *itemsTableView;
@end
