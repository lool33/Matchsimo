//
//  SetCard.m
//  Matchismo
//
//  Created by Laurent GAIDON on 09/02/13.
//  Copyright (c) 2013 Laurent GAIDON. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

//override match method form the super
-(int)match:(NSArray *)otherCards
{
 
    int matchScore = 1; //default score if there is a match (all matches reward the same score)
    
    if([otherCards count] !=2) return 0; //if we don't have 2 other cards to match with me return 0
    
    //We create soem mutable set for each property of the SetCard
    NSMutableSet *colorSet = [[NSMutableSet alloc]init];
    NSMutableSet *shadingSet = [[NSMutableSet alloc]init];
    NSMutableSet *symbolSet = [[NSMutableSet alloc]init];
    NSMutableSet *numberSet = [[NSMutableSet alloc]init];

    //We store the property of the 3 cards into the corresponding mutable set
    NSArray *theCards = @[self,otherCards[0],otherCards[1]];
    
    for (SetCard *card in theCards) {
        
        [colorSet addObject:card.color];
        [shadingSet addObject:card.shading];
        [symbolSet addObject:card.symbol];
        [numberSet addObject:@(card.number)];
    }
    

    //We check if we have mutliple entry in each set, if yes it means there is no 3 match
    //A mutable set cannot have two identical objects
    
    if([colorSet count] == 2) matchScore = 0;
    if([shadingSet count] == 2) matchScore = 0;
    if([symbolSet count] == 2) matchScore = 0;
    if([numberSet count] == 2) matchScore = 0;
    //but here it means that we should have every properties equal to have a score
    
    return matchScore;
}



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
//should probably be optimized inculding the use of NSAttributedString
//in order to return the contents as the symbol in the same way it's displayed
-(NSString *)contents
{
    NSArray *numberStrings = [SetCard numbersStrings];
    return [NSString stringWithFormat:@"%@-%@-%@-%@",self.color,self.symbol,self.shading,numberStrings[self.number]];
    
}


-(NSAttributedString *)contentsAttributed
{
    if(!_contentsAttributed)
    {
        
        NSDictionary *attributes = @{   NSStrokeColorAttributeName : [self myColor],
                                        NSStrokeWidthAttributeName : @-5,
                                        NSForegroundColorAttributeName : [self shadeColors]};
        
        _contentsAttributed = [[NSAttributedString alloc]initWithString:[self mySymbols] attributes:attributes];
        
        }
    
    return _contentsAttributed;
}
    
    
-(UIColor *)myColor
{
    NSDictionary *colors = @{@"green" : [UIColor greenColor],@"red" : [UIColor redColor],@"blue" : [UIColor blueColor]};
 
    
    if([[SetCard validColors] containsObject:self.color]) return colors[self.color];
    
    return [UIColor blackColor];
    
}
    
    
-(UIColor *)shadeColors
{
    
    NSDictionary *colorsForShade = @{   @"green":[UIColor colorWithRed:0 green:1 blue:0 alpha:0.4],
                                        @"red":[UIColor colorWithRed:1 green:0 blue:0 alpha:0.4],
                                        @"blue":[UIColor colorWithRed:0 green:0 blue:1 alpha:0.4] };
    


    if([self.shading isEqualToString:@"solid"]){
        return [self myColor];
        
    }else if ([self.shading isEqualToString:@"striped"]){
        return colorsForShade[self.color];
        
    }else if ([self.shading isEqualToString:@"open"]){
        return [UIColor whiteColor];
    }

    return nil;
}
    

-(NSString *)mySymbols
{
    NSString *me = @"";
    for (int i = 0; i < self.number; i++) {
        me = [me stringByAppendingString:self.symbol];
    }
    return me;
    
}

@end
