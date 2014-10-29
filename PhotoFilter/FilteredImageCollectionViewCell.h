//
//  FilteredImageCollectionViewCell.h
//  PhotoFilter
//
//  Created by Nikita Levintsov on 10/28/14.
//  Copyright (c) 2014 Nikita Levintsov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilteredImageCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) IBOutlet UIImageView * imageView;
@property (nonatomic, strong) IBOutlet UILabel * lblTitle;
@end
