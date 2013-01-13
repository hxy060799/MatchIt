//
//  CCLayerTouch.h
//  MatchIt
//
//  Created by Bill on 13-1-5.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "CCLayer.h"

//让CCLayer将触控事件通过委托传递出去

@protocol CCLayerTouchDelegate;

@interface CCLayerTouch : CCLayer{
    id<CCLayerTouchDelegate>delegate;
}

@property(retain,nonatomic)id<CCLayerTouchDelegate>delegete;

@end
