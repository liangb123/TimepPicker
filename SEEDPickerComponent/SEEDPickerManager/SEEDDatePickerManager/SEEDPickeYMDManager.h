//
//  SEEDPickeYMDManager.h
//  driver
//
//  Created by liangbing on 2019/6/13.
//  Copyright © 2019 1hai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SEEDDatePickerBaseManager.h"

NS_ASSUME_NONNULL_BEGIN

/** yyyy-m-d  */
@interface SEEDPickeYMDManager : SEEDDatePickerBaseManager<SEEDPickerManagerBasicDelegate>

/** 便利构造器*/
- (NSMutableArray <SEEDPickerSectionItem *>*)creatDateArrayWithIszh:(BOOL)isZh
                                                 withminuteInterval:(NSInteger)minuteInterval
                                                        withMinDate:(NSDate*)mindate;

@end

NS_ASSUME_NONNULL_END
