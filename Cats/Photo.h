//
//  Photo.h
//  Cats
//
//  Created by Endeavour2 on 7/17/17.
//  Copyright © 2017 SamOg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Photo : NSObject
@property (nonatomic, strong) NSString *urlServer;
@property (nonatomic, strong) NSString *urlFarm;
@property (nonatomic, strong) NSString *urlID;
@property (nonatomic, strong) NSString *urlSecret;
@property (nonatomic, strong) NSString *urlTitle;


- (instancetype)initWithInfo:(NSDictionary *)info;
- (NSURL *)url;

@end
