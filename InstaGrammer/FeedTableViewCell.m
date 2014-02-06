//
//  FeedTableViewCell.m
//  InstaGrammer
//
//  Created by Kagan Riedel on 2/5/14.
//  Copyright (c) 2014 Kagan Riedel. All rights reserved.
//

#import "FeedTableViewCell.h"

@implementation FeedTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    _userImageView = [[PFImageView alloc] initWithFrame:CGRectMake(20, 4, 35, 35)];
    _photoImageView = [[PFImageView alloc] initWithFrame:CGRectMake(0, 42, 320, 320)];
    _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(63, 11, 129, 21)];
    _userNameLabel.font = [UIFont systemFontOfSize:11.0];
    _timeStampLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 11, 100, 21)];
    _timeStampLabel.font = [UIFont systemFontOfSize:11.0];
    _likesLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 408, 280, 21)];
    _likesLabel.font = [UIFont systemFontOfSize:13.0];
    _commentsLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 437, 280, 36)];
    _commentsLabel.font = [UIFont systemFontOfSize:13.0];
    _commentsLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _commentsLabel.numberOfLines = 2;
    _likeButton = [LikeButton buttonWithType:UIButtonTypeRoundedRect];
    _likeButton.frame = CGRectMake(20, 370, 44, 30);
    [_likeButton setTitle:@"Like" forState:UIControlStateNormal];
    _commentButton = [LikeButton buttonWithType:UIButtonTypeRoundedRect];
    _commentButton.frame = CGRectMake(232, 370, 68, 30);
    [_commentButton setTitle:@"Comment" forState:UIControlStateNormal];
    
    [self.contentView addSubview:_userImageView];
    [self.contentView addSubview:_photoImageView];
    [self.contentView addSubview:_userNameLabel];
    [self.contentView addSubview:_timeStampLabel];
    [self.contentView addSubview:_likesLabel];
    [self.contentView addSubview:_commentsLabel];
    [self.contentView addSubview:_likeButton];
    [self.contentView addSubview:_commentButton];
    
    return  self;
}


@end
