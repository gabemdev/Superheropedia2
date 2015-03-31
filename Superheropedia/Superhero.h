//
//  Superhero.h
//  Superheropedia
//
//  Created by Rockstar. on 3/30/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Superhero : NSObject

@property NSString *name;
@property NSString *itemDescription;
@property NSURL *imageURL;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

+ (void)retreiveSuperheroesWithCompletion:(void(^)(NSArray *heroes))complete;

- (void)getImageDataWithCompletion:(void(^)(NSData *imageData, NSError *error))complete;

@end
