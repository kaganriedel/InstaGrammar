//
//  SearchViewController.m
//  InstaGrammer
//
//  Created by Kagan Riedel on 2/4/14.
//  Copyright (c) 2014 Kagan Riedel. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController () <UISearchBarDelegate>
{
    UILabel *titleLabel;
    UISearchBar *searchBar;
}
@end

@implementation SearchViewController

- (void)viewDidLoad
{
    self.parseClassName = @"User";
    
    [super viewDidLoad];

    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    titleLabel.backgroundColor = [UIColor blackColor];
    titleLabel.text = @"InstaGrammar";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"Savoye LET" size:35.0];
    titleLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:titleLabel];
    
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 40, 320, 44)];
    searchBar.text = @"test text";
    searchBar.delegate = self;
    [self.view addSubview:searchBar];
    
    [self.tableView setContentInset:UIEdgeInsetsMake(87, 0, 0, 0)];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self loadObjects];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    titleLabel.transform = CGAffineTransformMakeTranslation(0, self.tableView.contentOffset.y);
    searchBar.transform = CGAffineTransformMakeTranslation(0, self.tableView.contentOffset.y);
}

-(PFTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    PFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchCell"];
    if (!cell)
    {
        cell = [[PFTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"SearchCell"];
        cell.frame = CGRectMake(0, 0, 320, 42);
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 42.0;
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
}

@end
