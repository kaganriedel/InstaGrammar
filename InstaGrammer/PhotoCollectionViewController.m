//
//  PhotoCollectionViewController.m
//  InstaGrammer
//
//  Created by Kagan Riedel on 2/5/14.
//  Copyright (c) 2014 Kagan Riedel. All rights reserved.
//

#import "PhotoCollectionViewController.h"
#import "PhotoCollectionViewCell.h"

@interface PhotoCollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
{
    __weak IBOutlet UICollectionView *myCollectionView;
    NSArray *userPhotos;
}

@end

@implementation PhotoCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Photo"];
    [query whereKey:@"user" equalTo:_user];
    userPhotos = [query findObjects];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return userPhotos.count;
}

-(PhotoCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCell" forIndexPath:indexPath];
    PFObject *photo = [userPhotos objectAtIndex:indexPath.row];
    PFFile *file = [photo objectForKey:@"imageFile"];
    cell.myImageView.file = file;
    [cell.myImageView loadInBackground];
    
    return cell;
}



@end
