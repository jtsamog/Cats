//
//  Photo.m
//  Cats
//
//  Created by Endeavour2 on 7/17/17.
//  Copyright © 2017 SamOg. All rights reserved.
//

#import "Photo.h"

@implementation Photo

- (instancetype)initWithInfo:(NSDictionary *)info {
  self = [super init];
  if (self) {
    _urlFarm = info[@"farm"];
    _urlServer = info[@"server"];
    _urlID = info[@"id"];
    _urlSecret = info[@"secret"];
    _urlTitle = info[@"title"];

  }
  return self;
}


- (NSURL *)url {
  return [NSURL URLWithString:[NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@.jpg", self.urlFarm, self.urlServer, self.urlID, self.urlSecret]];
  
}

@end
