//
//  FilteredImage.h
//  PhotoFilter
//
//  Created by Nikita Levintsov on 10/28/14.
//  Copyright (c) 2014 Nikita Levintsov. All rights reserved.
//
#import <CoreImage/CoreImage.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIImage.h>

@interface FilteredImage : NSObject
@property (nonatomic, copy, readonly) UIImage * displayImage;
@property (nonatomic, copy, readonly) NSString * filterName;
+ (instancetype)filteredImageWithImage:(UIImage *)image;
- (void)applyFilterWithName:(NSString *)filterName;

@end
