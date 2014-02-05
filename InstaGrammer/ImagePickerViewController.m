//
//  ImagePickerViewController.m
//  InstaGrammer
//
//  Created by Kagan Riedel on 2/4/14.
//  Copyright (c) 2014 Kagan Riedel. All rights reserved.
//

#import "ImagePickerViewController.h"
#import "Parse/Parse.h"

@interface ImagePickerViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>

@end

@implementation ImagePickerViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"ChooseImagePickerControllerSourceType Please" delegate:self cancelButtonTitle:@"No Gracias" destructiveButtonTitle:nil otherButtonTitles:@"Camera", @"Photo Biblioteca", nil];
    [actionSheet showFromTabBar:self.tabBarController.tabBar];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) //Camera
    {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            UIImagePickerController *imagePicker = [UIImagePickerController new];
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.delegate = self;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Buy a Camera Phone" message:@"gazelle.com trade in your old stuff" delegate:nil cancelButtonTitle:@"You're right" otherButtonTitles: nil];
            [alert show];
            [self.tabBarController setSelectedIndex:0];

        }
    }
    else if (buttonIndex == 1) //Biblioteca
    {
        UIImagePickerController *imagePicker = [UIImagePickerController new];
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.delegate = self;
        [self presentViewController:imagePicker animated:YES completion:nil];
        

    }
    else if (buttonIndex == 2) //Cancel
    {
        [self.tabBarController setSelectedIndex:0];

       
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.tabBarController setSelectedIndex:0];

    
    NSData *data = UIImagePNGRepresentation(info[UIImagePickerControllerOriginalImage]);
    PFFile *file = [PFFile fileWithData:data];
    [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
     {
         if (!error)
         {
             PFObject *photo = [PFObject objectWithClassName:@"Photo"];
             [photo setObject:file forKey:@"imageFile"];
             [photo setObject:[NSDate date] forKey:@"timeStamp"];
             PFUser *user = [PFUser currentUser];
             [photo setObject:user.username forKey:@"username"];
             [photo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
              {
                  if (!error)
                  {
                      //figure out the reload table
                  }
                  else
                  {
                      NSLog(@"Error: %@ %@", error, [error userInfo]);
                  }
              }];
         }
         else
         {
             NSLog(@"Error: %@ %@", error, [error userInfo]);
         }
     }];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.tabBarController setSelectedIndex:0];
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}


@end
