//
//  FKLookEditViewController.m
//  FashionKredV2
//
//  Created by Kevin Nguy on 4/19/14.
//  Copyright (c) 2014 Kevin Nguy. All rights reserved.
//

#import "FKLookEditViewController.h"

@interface FKLookEditViewController () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@end

@implementation FKLookEditViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.itemCollectionView.delegate = self;
    self.itemCollectionView.dataSource = self;
}

- (IBAction)backButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"ItemCell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shirt"]];
    [cell addSubview:imageView];
    
    return cell;
}


// if(watermelon==yummy&&kevin==like watermelon) then kevin=yummy // transitive property

@end
