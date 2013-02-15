//
//  MIConfig.h
//  MatchIt
//
//  Created by Bill on 12-12-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#ifndef MatchIt_MIConfig_h
#define MatchIt_MIConfig_h

#pragma mark - Block Generate

//方块大小
#define BLOCKS_SIZE 20.0f
//方块数量
#define BLOCKS_XCOUNT  (int)(480/BLOCKS_SIZE)
#define BLOCKS_YCOUNT  (int)(320/BLOCKS_SIZE)
//方块总数
#define BLOCKS_COUNT (BLOCKS_XCOUNT*BLOCKS_YCOUNT)
//为了使方块堆在屏幕中间,左边和下边所需空出的距离
#define BLOCKS_LEFT_X (240-(BLOCKS_SIZE*BLOCKS_XCOUNT)/2) //((480-BLOCKS_SIZE*BLOCKS_XCOUNT)/2)
#define BLOCKS_BOTTOM_Y (160-(BLOCKS_SIZE*BLOCKS_YCOUNT)/2) //((320-BLOCKS_SIZE*BLOCKS_YCOUNT)/2)
//图像大小(用于方块图像缩放)
#define BLOCKS_IMAGE_SIZE 40.0f

#endif
