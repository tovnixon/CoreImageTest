//
//  CollectionViewController.m
//  PhotoFilter
//
//  Created by Nikita Levintsov on 10/28/14.
//  Copyright (c) 2014 Nikita Levintsov. All rights reserved.
//

#import "CollectionViewController.h"
#import "FilteredImagesDataSource.h"
#import "FilteredImage.h"
#import "FilteredImageCollectionViewCell+Configure.h"

@interface CollectionViewController ()
@property (nonatomic, strong) IBOutlet UIBarButtonItem * btnSelect;
@property (nonatomic, strong) FilteredImagesDataSource * dataSource;
- (IBAction)selectPhoto:(id)sender;

@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Ups.."
                                                         message:@"Device u r running has noa camera"
                                                        delegate:nil
                                               cancelButtonTitle:@"Okay("
                                               otherButtonTitles: nil];
        [alert show];
    }
    
    ConfigureCellBlock configureCellBlock = ^(FilteredImageCollectionViewCell * cell, id item) {
        [cell configureWithObject:item];
    };
    self.dataSource = [[FilteredImagesDataSource alloc] initWithCellIdentifier:reuseIdentifier
                                                                configureBlock:configureCellBlock];
    self.collectionView.dataSource = self.dataSource;
    [self selectPhoto:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)selectPhoto:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:^{
        
    }];
    
}

#pragma mark - Image picker delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = info[UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:^{
        self.btnSelect.enabled = NO;
        UIActivityIndicatorView * activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [self.collectionView addSubview:activityIndicator];
        [activityIndicator startAnimating];
        [self.dataSource setupImage:image inCollectionView:self.collectionView completion:^{
            [activityIndicator stopAnimating];
            [activityIndicator removeFromSuperview];
            self.btnSelect.enabled = YES;
            [self.collectionView reloadData];
        }];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
