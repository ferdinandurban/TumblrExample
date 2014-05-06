//
//  TumblrFetcher.h
//  tumblr_example
//
//  Created by Dr.Evil on 06/05/14.
//  Copyright (c) 2014 FerdinandUrban. All rights reserved.
//

#import "NMPaginator.h"

@interface TumblrFetcher : NSObject

+ (NSDictionary *)getPhotosPage:(NSInteger)page pageSize:(NSInteger)pageSize;

@end
