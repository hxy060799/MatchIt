//
//  GameLayer.h
//  MatchIt
//
//  Created by Bill on 12-12-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "MIBlockManagerDelegate.h"

@interface GameLayer : CCLayer<MIBlockManagerDelegate>{
    
}


+(CCScene*)scene;

@end
