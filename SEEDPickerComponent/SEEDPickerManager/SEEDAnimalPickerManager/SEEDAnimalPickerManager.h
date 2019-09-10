//
//  SEEDAnimalPickerManager.h
//  TimeP
//
//  Created by liangbing on 2019/9/10.
//  Copyright © 2019 liangbing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SEEDPickerBasicProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface SEEDAnimalPickerManager : NSObject <SEEDPickerManagerBasicDelegate>

- (NSMutableArray <SEEDPickerSectionItem *>*)creatAnimalDataArray;

@end

NS_ASSUME_NONNULL_END
