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
@property(nonatomic)float shading; //it's alpha beetwen 0 and 1
@property(nonatomic)int number;

+(NSString *)validColors;
+(NSString *)validSymbols;


@end
