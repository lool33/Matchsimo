//
//  deck.h
//  Matchismo
//
//  Created by Laurent GAIDON on 28/01/13.
//  Copyright (c) 2013 Laurent GAIDON. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "card.h"

@interface deck : NSObject

-(void)addCard:(card *)card onTop:(BOOL)ontop;

-(card *)drawRandomCard;


@end
