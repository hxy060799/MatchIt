//
//  HelloWorldLayer.h
//  MatchIt
//
//  Created by Bill on 13-1-29.
//  Copyright __MyCompanyName__ 2013年. All rights reserved.
//

#import "cocos2d.h"
#import "MIBlockManagerDelegate.h"

@interface GameLayer : CCLayer<MIBlockManagerDelegate>{
    
}


+(CCScene*)scene;

@end
