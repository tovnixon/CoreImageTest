//
//  FilteredImagesDataSource.h
//  PhotoFilter
//
//  Created by Nikita Levintsov on 10/28/14.
//  Copyright (c) 2014 Nikita Levintsov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UICollectionView.h>
typedef void (^ConfigureCellBlock)(id cell, id object);
typedef void (^CompleteDataProcessingBlock)();
@interface FilteredImagesDataSource : NSObject <UICollectionViewDataSource>

- (id)initWithCellIdentifier:(NSString *)aCellIdentifier configureBlock:(ConfigureCellBlock)aConfigureBlock;
- (void)setupImage:(UIImage *)image inCollectionView:(UICollectionView *)collectionView completion:(CompleteDataProcessingBlock)completionBlock;
@end
