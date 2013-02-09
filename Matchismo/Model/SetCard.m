//
//  SetCard.m
//  Matchismo
//
//  Created by Laurent GAIDON on 09/02/13.
//  Copyright (c) 2013 Laurent GAIDON. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

//public API implementation
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

//setter and getter implementation

@synthesize color = _color;
@synthesize symbol = _symbol;

-(void)setColor:(NSString *)color
{
    if(_color !=color){
        
        if([[SetCard validColors] containsObject:color]){
            _color = color;
        }
    }
}

-(NSString *)color
{
    return _color ? _color : @"?";
    
}

-(void)setSymbol:(NSString *)symbol
{
    if(_symbol !=symbol){
        if([[SetCard validSymbols] containsObject:symbol]){
            _symbol = symbol;
        }
    }
}

-(NSString *)symbol
{
    return _symbol ? _symbol : @"?";
}

-(void)setShading:(float)shading
{
    if(shading != _shading){
        if(shading <= 1.0 && shading >= 0) _shading = shading;
        if(shading < 0) _shading = 0;
        if(shading > 1.0) _shading = 1;
    }
}

-(void)setNumber:(int)number
{
    if(number <= [SetCard maxNumber]) _number = number;
}


@end
