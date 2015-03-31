//
//  Superhero.m
//  Superheropedia
//
//  Created by Rockstar. on 3/30/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import "Superhero.h"

@implementation Superhero

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.name = dictionary[@"name"];
        self.itemDescription = dictionary[@"description"];
        self.imageURL = [NSURL URLWithString:dictionary[@"avatar_url"]];
    }
    return self;
}

+ (void)retreiveSuperheroesWithCompletion:(void(^)(NSArray *heroes))complete {
    NSURL *url = [NSURL URLWithString:@"https://s3.amazonaws.com/mobile-makers-lib/superheroes.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSArray *results = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSMutableArray *superheroes = [NSMutableArray new];

        for (NSDictionary *dict in results) {
            Superhero *hero = [[Superhero alloc] initWithDictionary:dict];
            [superheroes addObject:hero];

        }
        complete(superheroes);
    }];
}

- (void)getImageDataWithCompletion:(void(^)(NSData *imageData, NSError *error))complete {
    NSURLRequest *request = [NSURLRequest requestWithURL:self.imageURL];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            complete(nil, connectionError);
        } else {
            complete(data, nil);
        }
    }];
}

@end
