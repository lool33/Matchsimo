//
//  SetCard.h
//  Matchismo
//
//  Created by Laurent GAIDON on 09/02/13.
//  Copyright (c) 2013 Laurent GAIDON. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property(nonatomic,strong)NSString *color;
@property(nonatomic,strong)NSString *symbol;
@property(nonatomic,strong)NSString *shading;
@property(nonatomic)int number;

+(NSArray *)validColors;
+(NSArray *)validShadings;
+(NSArray *)validSymbols;
+(int)maxNumber;

@end
