//
//  SearchViewController.m
//  InstaGrammer
//
//  Created by Kagan Riedel on 2/4/14.
//  Copyright (c) 2014 Kagan Riedel. All rights reserved.
//

#import "SearchViewController.h"
#import "PhotoCollectionViewController.h"

@interface SearchViewController () <UISearchBarDelegate>
{
    UILabel *titleLabel;
    UISearchBar *mySearchBar;
}
@end

@implementation SearchViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];

    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    titleLabel.backgroundColor = [UIColor blackColor];
    titleLabel.text = @"InstaGrammar";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"Savoye LET" size:35.0];
    titleLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:titleLabel];
    
    mySearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 65, 320, 44)];

    mySearchBar.delegate = self;
    [self.view addSubview:mySearchBar];
    
    [self.tableView setContentInset:UIEdgeInsetsMake(44, 0, 0, 0)];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self loadObjects];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    titleLabel.transform = CGAffineTransformMakeTranslation(0, self.tableView.contentOffset.y);
    mySearchBar.transform = CGAffineTransformMakeTranslation(0, self.tableView.contentOffset.y);
}

-(PFTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFUser *)object
{
    PFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchCell"];
    if (!cell)
    {
        cell = [[PFTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"SearchCell"];
        cell.frame = CGRectMake(0, 0, 320, 42);
    }
    
    PFUser *user = object;
    [user fetchIfNeeded];
    cell.textLabel.text = user[@"username"];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 42.0;
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self loadObjects];
    
    if([searchText length] == 0) {
        [searchBar performSelector: @selector(resignFirstResponder)
                        withObject: nil
                        afterDelay: 0.1];
    }
}

-(PFQuery *)queryForTable
{
    PFQuery *query = [PFUser query];
    [query whereKey:@"username" containsString:mySearchBar.text]; //fing brilliant

    return query;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"PhotoCollectionSegue" sender:indexPath];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    PFQuery *query = [PFUser query];
    [query whereKey:@"username" containsString:cell.textLabel.text];
    PFUser *user = [query findObjects].firstObject;
    
    PhotoCollectionViewController *photoCollectionViewController = segue.destinationViewController;
    photoCollectionViewController.user = user;
    photoCollectionViewController.navigationItem.title = [user objectForKey:@"username"];
}

@end
