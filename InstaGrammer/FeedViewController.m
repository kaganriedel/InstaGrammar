//
//  ViewController.m
//  InstaGrammer
//
//  Created by Kagan Riedel on 2/4/14.
//  Copyright (c) 2014 Kagan Riedel. All rights reserved.
//

#import "FeedViewController.h"

@interface FeedViewController () <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>
{
    UILabel *titleLabel;
}
@end

@implementation FeedViewController

- (void)viewDidLoad
{
    self.parseClassName = @"Photo";
    
    [super viewDidLoad];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    titleLabel.backgroundColor = [UIColor blackColor];
    titleLabel.text = @"InstaGrammar";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"Savoye LET" size:35.0];
    titleLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:titleLabel];
    
    [self.tableView setContentInset:UIEdgeInsetsMake(40, 0, 0, 0)];
    
}



-(void)viewDidAppear:(BOOL)animated
{
    if (![PFUser currentUser]) {
        PFLogInViewController *login = [PFLogInViewController new];
        login.delegate = self;
        login.signUpController.delegate = self;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.text = @"InstaGrammer";
        [label sizeToFit];
        login.logInView.logo = label;
        [self presentViewController:login animated:animated completion:nil];
    }
    [self loadObjects]; //careful. this clears the table. so you will lose where you were looking last...`
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    titleLabel.transform = CGAffineTransformMakeTranslation(0, self.tableView.contentOffset.y);
}


-(PFTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    PFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FeedCell"];
    if (!cell)
    {
        cell = [[PFTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"FeedCell"];
        cell.frame = CGRectMake(0, 0, 320, 495);
        cell.contentView.frame = CGRectMake(0, 0, 320, 494);
        
        UIImageView *userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 4, 35, 35)];
        userImageView.image = [UIImage imageNamed:@"murray320x320.jpg"];
        
        UIImageView *photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 42, 320, 320)];
        PFFile *file =[object objectForKey:@"imageFile"];
        [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (!error) {
                photoImageView.image = [UIImage imageWithData: data];
            }
        }];
        
        UILabel *userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(63, 11, 129, 21)];
        userNameLabel.font = [UIFont systemFontOfSize:11.0];
        userNameLabel.text = [object objectForKey:@"username"];
        
        UILabel *timeStampLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 11, 100, 21)];
        timeStampLabel.font = [UIFont systemFontOfSize:11.0];
        NSDate *date = [object objectForKey:@"timeStamp"];
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        dateFormatter.dateStyle = NSDateFormatterShortStyle;
        dateFormatter.timeStyle = NSDateFormatterShortStyle;
        timeStampLabel.text = [dateFormatter stringFromDate:date];

        UILabel *likesLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 408, 280, 21)];
        likesLabel.font = [UIFont systemFontOfSize:13.0];
        likesLabel.text = @"\u2661 Yash and Nick really love this lion photo";

        UILabel *commentsLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 437, 280, 36)];
        commentsLabel.font = [UIFont systemFontOfSize:13.0];
        commentsLabel.text = @"Holy crap. It's a lion.\nNo way it totally is!";
        commentsLabel.lineBreakMode = NSLineBreakByWordWrapping;
        commentsLabel.numberOfLines = 2;

        
        UIButton *likeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [likeButton addTarget:self action:@selector(onLikeButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        likeButton.frame = CGRectMake(20, 370, 44, 30);
        [likeButton setTitle:@"Like" forState:UIControlStateNormal];
        likeButton.reversesTitleShadowWhenHighlighted = YES;
        
        UIButton *commentButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [commentButton addTarget:self action:@selector(onCommentButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        commentButton.frame = CGRectMake(232, 370, 68, 30);
        [commentButton setTitle:@"Comment" forState:UIControlStateNormal];

        [cell.contentView addSubview:userImageView];
        [cell.contentView addSubview:photoImageView];
        [cell.contentView addSubview:userNameLabel];
        [cell.contentView addSubview:timeStampLabel];
        [cell.contentView addSubview:likesLabel];
        [cell.contentView addSubview:commentsLabel];
        [cell.contentView addSubview:likeButton];
        [cell.contentView addSubview:commentButton];
    }
    
       return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 495.0;
}

-(void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user
{
    [signUpController dismissViewControllerAnimated:YES completion:nil];
}

-(void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user
{
    [logInController dismissViewControllerAnimated:YES completion:nil];
}

-(void)onLikeButtonPressed
{
    NSLog(@"Like button pressed");
}

-(void)onCommentButtonPressed
{
        NSLog(@"Comment button pressed");
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
