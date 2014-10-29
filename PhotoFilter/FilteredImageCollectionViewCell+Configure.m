//
//  FilteredImageCollectionViewCell+Configure.m
//  PhotoFilter
//
//  Created by Nikita Levintsov on 10/28/14.
//  Copyright (c) 2014 Nikita Levintsov. All rights reserved.
//

#import "FilteredImageCollectionViewCell+Configure.h"
#import "FilteredImage.h"

@implementation FilteredImageCollectionViewCell (Configure)

- (void)configureWithObject:(FilteredImage *)filteredImage {
    self.imageView.image = [filteredImage displayImage];
    self.lblTitle.text = filteredImage.filterName;
}
@end
