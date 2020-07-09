//
//  ImageHelper.h
//  DeadStock
//
//  Created by Pranathi Peri on 7/9/20.
//  Copyright © 2020 Pranathi Peri. All rights reserved.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageHelper : PFObject
+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image;
+ (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size;
@end

NS_ASSUME_NONNULL_END
