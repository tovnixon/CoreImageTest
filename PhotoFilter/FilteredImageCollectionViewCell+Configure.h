//
//  FilteredImageCollectionViewCell+Configure.h
//  PhotoFilter
//
//  Created by Nikita Levintsov on 10/28/14.
//  Copyright (c) 2014 Nikita Levintsov. All rights reserved.
//

#import "FilteredImageCollectionViewCell.h"
@class FilteredImage;
@interface FilteredImageCollectionViewCell (Configure)

- (void)configureWithObject:(FilteredImage *)filteredImage;
@end
