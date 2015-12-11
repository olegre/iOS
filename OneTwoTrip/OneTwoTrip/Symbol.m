//
//  Symbol.m
//  OneTwoTrip
//
//  Created by Oleg Chepkin on 11/12/15.
//  Copyright © 2015 Oleg Chepkin. All rights reserved.
//

#import "Symbol.h"

@implementation Symbol

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isUsed = NO;
    }
    return self;
}

- (instancetype)initWithName:(NSString*)name
                 andPosition:(struct Position)position
{
    self = [self init];
    if (self) {
        self.name = name;
        self.position = position;
    }
    return self;
}


- (NSString *)description
{

    return [NSString stringWithFormat:@"%@:(%d,%d) - %hhd\n", _name, _position.i, _position.j, _isUsed];
}
@end
