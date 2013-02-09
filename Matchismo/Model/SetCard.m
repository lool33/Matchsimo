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

+(NSArray *)validShadings
{
    return @[@"solid",@"striped",@"open"];
}

+(NSArray *)numbersStrings
{
 
    return @[@"?",@"1",@"2",@"3"];
}

+(int)maxNumber
{
    return [SetCard numbersStrings].count -1;
    
}

//setter and getter implementation

@synthesize color = _color;
@synthesize symbol = _symbol;
@synthesize shading = _shading;

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

-(NSString *)shading
{
    return _shading ? _shading : @"?";
}

-(void)setShading:(NSString *)shading
{
    if(shading != _shading)
    {
        
        if([[SetCard validShadings] containsObject:shading]){
            _shading = shading;
        }
    }
}


-(void)setNumber:(int)number
{
    if(number <= [SetCard maxNumber]) _number = number;
}

//override of content method from superClass
-(NSString *)contents
{
    NSArray *numberStrings = [SetCard numbersStrings];
    return [NSString stringWithFormat:@"%@-%@-%@-%@",self.color,self.symbol,self.shading,numberStrings[self.number]];
    
}


@end
