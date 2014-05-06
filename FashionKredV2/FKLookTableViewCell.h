//
//  FKLookTableViewCell.h
//  FashionKredV2
//
//  Created by Kevin Nguy on 4/19/14.
//  Copyright (c) 2014 Kevin Nguy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FKLookTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;

@end
