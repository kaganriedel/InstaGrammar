//
//  FeedTableViewCell.h
//  InstaGrammer
//
//  Created by Kagan Riedel on 2/5/14.
//  Copyright (c) 2014 Kagan Riedel. All rights reserved.
//

#import <Parse/Parse.h>
#import "LikeButton.h"

@interface FeedTableViewCell : PFTableViewCell

@property PFImageView *userImageView;
@property PFImageView *photoImageView;
@property UILabel *userNameLabel;
@property UILabel *timeStampLabel;
@property UILabel *commentsLabel;
@property UILabel *likesLabel;
@property LikeButton *likeButton;
@property LikeButton *commentButton;

@end
