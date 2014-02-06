//
//  ViewController.m
//  InstaGrammer
//
//  Created by Kagan Riedel on 2/4/14.
//  Copyright (c) 2014 Kagan Riedel. All rights reserved.
//

#import "FeedViewController.h"
#import "CommentViewController.h"
#import "FeedTableViewCell.h"
#import "likeButton.h"

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
    [self loadObjects];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    titleLabel.transform = CGAffineTransformMakeTranslation(0, self.tableView.contentOffset.y);
}

-(FeedTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    FeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FeedCell"];
    if (!cell)
    {
        cell = [[FeedTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"FeedCell"];
    }
    
    PFUser *user = [object objectForKey:@"user"];
    [user fetchIfNeeded];
    
    cell.contentView.frame = CGRectMake(0, 0, 320, 494);
    cell.frame = CGRectMake(0, 0, 320, 495);
    cell.userImageView.image = [UIImage imageNamed:@"murray320x320.jpg"];
    cell.userImageView.file = [user objectForKey:@"profilepic"];
    [cell.userImageView loadInBackground];
    cell.photoImageView.image = nil;
    cell.photoImageView.file = [object objectForKey:@"imageFile"];
    [cell.photoImageView loadInBackground];
    cell.userNameLabel.text = [user objectForKey:@"username"];

    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateStyle = NSDateFormatterShortStyle;
    dateFormatter.timeStyle = NSDateFormatterShortStyle;

    cell.timeStampLabel.text = [dateFormatter stringFromDate:object.createdAt];
    cell.likesLabel.text = @"\u2661 ";
    
    PFObject *sourceObject = object;
    PFRelation *relation = [sourceObject relationforKey:@"likedby"];
    
    [[relation query] findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
        for (int i = 0; i < results.count; i++) {
            PFObject * tempObject = results[i];
            cell.likesLabel.text = [NSString stringWithFormat:@"%@ %@", cell.likesLabel.text, tempObject[@"username"]];
        }
    }];
    
    cell.commentsLabel.text = @"Holy crap. It's a lion.\nNo way it totally is!";
    cell.likeButton.object = object;
    [cell.likeButton addTarget:self action:@selector(onLikeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    //scrollview delays the touch. highlighting
    
    [cell.commentButton addTarget:self action:@selector(onCommentButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
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

-(void)onLikeButtonPressed:(LikeButton *)sender
{

    PFObject *object = sender.object;
    
    PFUser *user = [PFUser currentUser];
    PFRelation *relation = [object relationforKey:@"likedby"];
    [relation addObject:user];
    [object saveInBackground];
}

-(void)onCommentButtonPressed:(LikeButton *)sender
{
    PFObject *object = sender.object;
    [self performSegueWithIdentifier:@"CommentSegue" sender:object];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(PFObject *)sender
{
    CommentViewController *cvc = segue.destinationViewController;
    cvc.object = sender;
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
