//
//  FKViewController.m
//  FashionKredV2
//
//  Created by Kevin Nguy on 4/16/14.
//  Copyright (c) 2014 Kevin Nguy. All rights reserved.
//

#import "FKViewController.h"

#import "FKMainTableViewCell.h"
#import "FKSideMenuTableViewCell.h"
#import "FKLookTableViewCell.h"
#import "FKItemTableViewCell.h"

@interface FKViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
@property (nonatomic, strong) FKMainTableViewCell *currentMainCell;
@end

@implementation FKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self setupSideTableView];
    [self setupMainTableView];
}

- (void)setupSideTableView
{
    self.sideMenuTableView.dataSource = self;
    self.sideMenuTableView.delegate = self;
    
    [self.sideMenuTableView registerNib:[UINib nibWithNibName:@"FKSideMenuTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SideMenuCellIdentifier"];
    FKSideMenuTableViewCell *cell = [self.sideMenuTableView dequeueReusableCellWithIdentifier:@"SideMenuCellIdentifier"];
    self.sideMenuTableView.rowHeight = CGRectGetHeight(cell.frame);
    
    [self.sideMenuTableView reloadData];
}

- (void)setupMainTableView
{
    self.mainTableView.dataSource = self;
    self.mainTableView.delegate = self;
    
    [self.mainTableView registerNib:[UINib nibWithNibName:@"FKMainTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MainCellIdentifier"];
    FKMainTableViewCell *cell = [self.mainTableView dequeueReusableCellWithIdentifier:@"MainCellIdentifier"];
    self.mainTableView.rowHeight = CGRectGetHeight(cell.frame);
    
    [self.mainTableView reloadData];
    
    NSIndexPath *firstVisibleIndexPath = [[self.mainTableView indexPathsForVisibleRows] objectAtIndex:0];
    self.currentMainCell = (FKMainTableViewCell *)[self.mainTableView cellForRowAtIndexPath:firstVisibleIndexPath];
    
    [self.topSegmentedControl setSelectedSegmentIndex:0];
}

- (IBAction)topSegmentControlValueChanged:(id)sender
{
    int width = CGRectGetWidth(self.currentMainCell.mainScrollView.frame);
    int value = ((UISegmentedControl *)sender).selectedSegmentIndex;
    [self.currentMainCell.mainScrollView scrollRectToVisible:CGRectOffset(self.currentMainCell.mainScrollView.frame, width * value, 0) animated:YES];
}

- (IBAction)themesButtonPressed:(id)sender {

}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = 100;
    
    if (tableView == self.mainTableView) {
        count = 100;
    } else if (tableView == self.sideMenuTableView) {
        count = 100;
    }
    
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.mainTableView) {
        FKMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainCellIdentifier"];
        
        if (indexPath.row % 2 == 0) {
            cell.frontPageImageView.image = [UIImage imageNamed:@"glee"];
        } else {
            cell.frontPageImageView.image = [UIImage imageNamed:@"oscars"];
        }
        
        cell.lookTableView.delegate = self;
        cell.lookTableView.dataSource = self;
        
        cell.itemsTableView.delegate = self;
        cell.itemsTableView.dataSource = self;
        
        cell.mainScrollView.delegate = self;
        
        return cell;
    }
    else if (tableView == self.sideMenuTableView) {
        FKSideMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SideMenuCellIdentifier"];
        
        if (indexPath.row % 2 == 0) {
            cell.menuLabel.text = @"Glee";
        } else {
            cell.menuLabel.text = @"The Oscars";
        }
        
        return cell;
    }
    else if ([tableView isKindOfClass:[FKLookTableView class]]) {
        FKLookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LookCellIdentifier"];
        return cell;
    }
    else if ([tableView isKindOfClass:[FKItemsTableView class]]) {
        FKItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ItemsCellIdentifier"];
        return cell;
    }
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.sideMenuTableView) {
        // change main table view indexpath
        [self.mainTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        [self.mainTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        self.currentMainCell = (FKMainTableViewCell *)[self.mainTableView cellForRowAtIndexPath:indexPath];
        
        int width = CGRectGetWidth(self.currentMainCell.mainScrollView.frame);
        int xPosition = self.currentMainCell.mainScrollView.contentOffset.x;
        
        if (xPosition < width) {
            [self.topSegmentedControl setSelectedSegmentIndex:0];
        }
        else if (xPosition >= width && xPosition < width * 2) {
            [self.topSegmentedControl setSelectedSegmentIndex:1];
        }
        else if (xPosition >= width * 2) {
            [self.topSegmentedControl setSelectedSegmentIndex:2];
        }
        
//        if (indexPath.row == 3) {
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Bbyz code" message:@"if(watermelon==yummy&&kevin==like watermelon) then kevin=yummy" delegate:nil cancelButtonTitle:@"Okie" otherButtonTitles:nil];
//            [alertView show];
//        }
    }
    else if ([tableView isKindOfClass:[FKLookTableView class]]) {
        [self performSegueWithIdentifier:@"LookDetailsSegue" sender:self];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    CGPoint targetPoint = *targetContentOffset;
    CGPoint currentPoint = scrollView.contentOffset;
    
    if (scrollView == self.mainTableView) {
        NSIndexPath *firstVisibleIndexPath;
        if (targetPoint.y > currentPoint.y) {
            NSLog(@"down");
            firstVisibleIndexPath = self.mainTableView.indexPathsForVisibleRows.lastObject;
        }
        else {
            NSLog(@"up");
            firstVisibleIndexPath = self.mainTableView.indexPathsForVisibleRows.firstObject;
        }
        
        self.currentMainCell = (FKMainTableViewCell *)[self.mainTableView cellForRowAtIndexPath:firstVisibleIndexPath];
        NSLog(@"first visible cell's section: %i, row: %i", firstVisibleIndexPath.section, firstVisibleIndexPath.row);
        
        [self.sideMenuTableView selectRowAtIndexPath:firstVisibleIndexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    }
    else if (scrollView == self.currentMainCell.mainScrollView) {
        int width = CGRectGetWidth(self.currentMainCell.mainScrollView.frame);
        int xPosition = targetPoint.x;
        
        if (xPosition < width) {
            [self.topSegmentedControl setSelectedSegmentIndex:0];
        }
        else if (xPosition >= width && xPosition < width * 2) {
            [self.topSegmentedControl setSelectedSegmentIndex:1];
        }
        else if (xPosition >= width * 2) {
            [self.topSegmentedControl setSelectedSegmentIndex:2];
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
}


@end
