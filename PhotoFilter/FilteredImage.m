//
//  FilteredImage.m
//  PhotoFilter
//
//  Created by Nikita Levintsov on 10/28/14.
//  Copyright (c) 2014 Nikita Levintsov. All rights reserved.
//

#import "FilteredImage.h"

@interface FilteredImage()
@property (nonatomic, strong) UIImage * defaultImage;
@property (nonatomic, copy) UIImage * displayImage;
@property (nonatomic, copy) NSString * filterName;
@end

@implementation FilteredImage

+ (instancetype)filteredImageWithImage:(UIImage *)image {
    FilteredImage * fi = [FilteredImage new];
    fi.defaultImage = image;
    return fi;
}

- (void)applyFilterWithName:(NSString *)filterName {
    self.filterName = filterName;
    CIImage * ciimage = [CIImage imageWithCGImage:[self.defaultImage CGImage]];
    CIFilter * filter = [CIFilter filterWithName:filterName keysAndValues:kCIInputImageKey, ciimage, nil];
    self.displayImage = [UIImage imageWithCIImage:[filter outputImage]];
}


@end
