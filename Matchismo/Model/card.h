//
//  card.h
//  Matchismo
//
//  Created by Laurent GAIDON on 28/01/13.
//  Copyright (c) 2013 Laurent GAIDON. All rights reserved.
//  Class representing a card with a content (suits and rank) and
//  an imageName used for the display of myself

#import <Foundation/Foundation.h>

@interface card : NSObject

@property(nonatomic,strong)NSString *contents;
@property(nonatomic,readonly)NSString *imageName;


-(int)match:(NSArray *)otherCards;


@end
