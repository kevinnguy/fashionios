//
//  FKViewController.h
//  FashionKredV2
//
//  Created by Kevin Nguy on 4/16/14.
//  Copyright (c) 2014 Kevin Nguy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FKViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *sideMenuTableView;
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;


@property (weak, nonatomic) IBOutlet UIView *sideTopView;
@property (weak, nonatomic) IBOutlet UIButton *sideMenuButton;


@property (weak, nonatomic) IBOutlet UIView *mainTopView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *topSegmentedControl;

@end
