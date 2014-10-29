//
//  FilteredImagesDataSource.m
//  PhotoFilter
//
//  Created by Nikita Levintsov on 10/28/14.
//  Copyright (c) 2014 Nikita Levintsov. All rights reserved.
//

#import "FilteredImagesDataSource.h"
#import <CoreImage/CoreImage.h>
#import <UIKit/UIImage.h>
#import <UIKit/UIActivityIndicatorView.h>
#import "FilteredImage.h"

@interface FilteredImagesDataSource()
@property (nonatomic, strong) NSMutableArray * items;
@property (nonatomic, copy)   NSString * cellIdentifier;
@property (nonatomic, copy)   ConfigureCellBlock configureBlock;
@end

@implementation FilteredImagesDataSource 

- (id)initWithCellIdentifier:(NSString *)aCellIdentifier configureBlock:(ConfigureCellBlock)aConfigureBlock {
    self = [super init];
    if (self) {
        self.items = [NSMutableArray new];
        self.cellIdentifier = aCellIdentifier;
        self.configureBlock = aConfigureBlock;
    }
    return self;
}

- (void)setupImage:(UIImage *)image inCollectionView:(UICollectionView *)collectionView completion:(CompleteDataProcessingBlock)completionBlock {
    [self.items removeAllObjects];
    dispatch_group_t group = dispatch_group_create();
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSArray * filters = [CIFilter filterNamesInCategory:kCICategoryColorEffect];
        dispatch_group_enter(group);
        for (NSString * filterName in filters) {

            FilteredImage * fi = [FilteredImage filteredImageWithImage:image];
            [fi applyFilterWithName:filterName];
            [self.items addObject:fi];
            
        }
        dispatch_group_leave(group);
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        completionBlock();
    });
}

#pragma mark - Data source delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellIdentifier forIndexPath:indexPath];
    if (self.configureBlock) {
        id item = [self.items objectAtIndex:indexPath.item];
        self.configureBlock(cell, item);
    }
    return cell;
}

@end
