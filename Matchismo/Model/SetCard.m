//
//  SetCard.m
//  Matchismo
//
//  Created by Laurent GAIDON on 09/02/13.
//  Copyright (c) 2013 Laurent GAIDON. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard


+(NSArray *)validColors
{
    return @[@"green",@"red",@"blue"];
    
}

+(NSArray *)validSymbols
{
    return @[@"■",@"●",@"▲"];
}

+(NSArray *)numbersStrings
{
 
    return @[@"1",@"2",@"3"];
}

+(int)maxNumber
{
    return [SetCard numbersStrings].count;
    
}



@end
