//
//  CommentViewController.m
//  InstaGrammer
//
//  Created by Kagan Riedel on 2/5/14.
//  Copyright (c) 2014 Kagan Riedel. All rights reserved.
//

#import "CommentViewController.h"

@interface CommentViewController ()

@end

@implementation CommentViewController

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//	// Do any additional setup after loading the view.
//}
//
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//-(PFQuery *)queryForTable
//{
//    PFQuery *query = [PFQuery queryWithClassName:@"Comments"];
//    query where
//    
//    PFObject *sourceObject = self.object;
//    PFRelation *relation = [sourceObject relationforKey:@"comments"];
//    
//    [[relation query] findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
//        for (int i = 0; i < results.count; i++) {
//            PFObject * tempObject = results[i];
//            cell.text = [NSString stringWithFormat:@"%@", tempObject[@"username"]];
//        }
//    }];
//}

@end
