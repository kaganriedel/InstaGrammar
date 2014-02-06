//
//  ProfileViewController.m
//  InstaGrammer
//
//  Created by Kagan Riedel on 2/5/14.
//  Copyright (c) 2014 Kagan Riedel. All rights reserved.
//

#import "ProfileViewController.h"
#import "Parse/Parse.h"
#import "PhotoCollectionViewController.h"

@interface ProfileViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    __weak IBOutlet UIButton *userPhotoButton;
    PFImageView *imageView;
}

@end

@implementation ProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    imageView = [[PFImageView alloc] initWithFrame:CGRectMake(20, 76, 110, 110)];
    imageView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:imageView];
    self.navigationItem.title = [PFUser currentUser].username;


}

-(void)viewDidAppear:(BOOL)animated
{
    imageView.file = [[PFUser currentUser] objectForKey:@"profilepic"];
    [imageView loadInBackground];
}

- (IBAction)onAddPhotoButtonPressed:(id)sender {
    UIImagePickerController *imagePicker = [UIImagePickerController new];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    NSData *data = UIImagePNGRepresentation(info[UIImagePickerControllerOriginalImage]);
    PFFile *file = [PFFile fileWithData:data];

    [[PFUser currentUser] setObject:file forKey:@"profilepic"];
    [[PFUser currentUser] saveInBackground];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(NSIndexPath *)indexPath
{
    PFUser *user = [PFUser currentUser];
    
    PhotoCollectionViewController *photoCollectionViewController = segue.destinationViewController;
    photoCollectionViewController.user = [PFUser currentUser];
    photoCollectionViewController.navigationItem.title = [user objectForKey:@"username"];
}

@end
