//
//  PhotoCollectionViewCell.h
//  InstaGrammer
//
//  Created by Kagan Riedel on 2/5/14.
//  Copyright (c) 2014 Kagan Riedel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"

@interface PhotoCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet PFImageView *myImageView;


@end
