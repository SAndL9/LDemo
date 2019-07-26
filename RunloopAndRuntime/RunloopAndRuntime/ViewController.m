

// 链接地址:
// runloop详解:http://www.tuicool.com/articles/e6RBvmB
// runtime详解:http://www.jianshu.com/p/927c8384855a

/*****************  runloop概念理解  *********************/

/*
 *  基本概念:事件循环  不需要创建,在线程中只需要调用[NSRunLoop currentRunLoop]就可以得到
 *  每个线程都有一个RunLoop对象，但是只有主线程的RunLoop是开启的。
 *  子线程中的RunLoop默认是不被创建的
 *  在子线程中当调用 NSRunLoop *runloop = [NSRunLoop currentRunLoop];
 *  一个线程可以开启多个RunLoop，只不过都是嵌套在最大的RunLoop中。
 */

// RunLoop基本的循环模式:
//开始循环→ 程序处于睡眠状态,等待接受事件→事件传入,程序被唤醒,获取事件→处理事件→进入下次循环

/*****************  runloop作用  *********************/

/*
 *  四大作用:
 *  1.使程序一直运行并接受用户输入。
 *  2.决定程序在何时处理哪些事件。
 *  3.调用解耦(主调方产生很多事件，不用等到被调方处理完事件之后，才执行其他操作)
 *  4.节省CPU事件(当程序启动之后，什么都没有执行的话，就不用让CPU来消耗资源,直接进入睡眠状态
 */

/*****************  runloop构成元素  *********************/

/*
 *  每一个RunLoop都包含若干个CFRunLoopMode。
 *  在同一时间，只能在一种Mode下面执行。
 *  当需要切换Mode的时候，就必须退出当前的RunLoop。重新启动一个。
 *
 *  系统默认的有5种模式:
 *  1.CFRunLoopDefaultMode:这个是默认Mode,也是空闲状态。主线程通常在这个Mode下运行的。
 *  2.UITrackingRunLoopMode:ScrollView滚动时候的模式。
 *  3.UIInitializationRunLoopMode:刚启动程序时进入的第一个Mode,启动完成后就不再使用。
 *  4.GSEventReceiveRunLoopMode:接受系统事件的内部的Mode,通常用不到。
 *  5.CFRunLoopCommonModes: 这是一个数组，包括了第1和第2种模式。
 */

/*****************  runtime概念理解  *********************/

/*
 *  1.runtime简称运行时,是一套比较底层的纯C语言API, 属于1个C语言库, 包含了很多底层的C语言API.
 *  2.在我们平时编写的OC代码中, 程序运行过程时, 其实最终都是转成了runtime的C语言代码
 *  3.OC系统在运行的时候的最主要的是消息机制。对于C语言，函数的调用在编译的时候会决定调用哪个函数
 *  4.OC的函数调用属于动态调用过程。在编译的时候并不能决定真正调用哪个函数
 *  5.任何函数，即使这个函数并未实现，只要申明过就不会报错。而C语言在编译阶段就会报错。只有在真正运
 *  行的时候才会根据函数的名称找到对应的函数来调用。
 *
 */

/*
 * 当我们写下一行代码[obj doSomething];
 * 在编译时,编译器会将我们的代码转化为: objc_msgSend(obj,@selector(doSomething));
 * objc_msgSend()方法实现了函数查找和匹配，下面是它的原理：
 * 根据对象obj找到对象类中存储的函数列表methodLists。
 * 再根据SEL@selector(doSomething)在methodLists中查找对应的函数指针method_imp。
 * 根据函数指针method_imp调用响应的函数。
 *
 */

#import "ViewController.h"
#import "SDCycleScrollView.h"
#import <objc/runtime.h>
#import "Person.h"
@interface ViewController ()

@property (nonatomic,assign)BOOL isHas;
@property (nonatomic,copy)NSString *str;
@property (nonatomic,strong)NSArray *arr;

@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

/******************** 一:runloop模块简单应用实例介绍 ****************************/
    
    // 获取主线程的RunLoop: [NSRunLoop mainRunLoop];
    
    // 获取当前进程的RunLoop
    // NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    // NSLog(@"%@",runloop);

    
    /*
    NSArray *imageArr = @[@"0.jpg",@"1.jpg",@"2.jpg",@"3.jpg"];
    SDCycleScrollView *scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 200) imageNamesGroup:imageArr];
    
    [self.view addSubview:scrollView];
    */
    
/******** 二:runtime可以在其它类中修改某个类私有属性,比KVC修改属性强大 *********/
    
    Person *onePerson = [[Person alloc] init];
    NSLog(@"first time:%@",[onePerson description]);
    
    unsigned  int count = 0;
    Ivar *members = class_copyIvarList([Person class], &count);
    
    for (int i = 0; i < count; i++)
    {
        Ivar var = members[i];
        const char *memberAddress = ivar_getName(var);
        const char *memberType = ivar_getTypeEncoding(var);
        NSLog(@"address = %s ; type = %s",memberAddress,memberType);
    }
    
    //对私有变量的更改
    Ivar m_address = members[1];
    object_setIvar(onePerson, m_address, @"河南郑州");
    NSLog(@"second time : %@",[onePerson description]);
    
    // 调用修改其私有属性方法
    [self private];
    
    
    //获取属性列表
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    
    for (unsigned int i=0; i<count; i++) {
        const char *propertyName = property_getName(propertyList[i]);
        NSLog(@"property-->%@", [NSString stringWithUTF8String:propertyName]);
    }
    
    //获取方法列表
    Method *methodList = class_copyMethodList([self class], &count);
    for (unsigned int i; i<count; i++) {
        Method method = methodList[i];
        NSLog(@"method-->%@", NSStringFromSelector(method_getName(method)));
    }
}

- (void)private{
    
    unsigned int count = 0;
    
    Method *memberFuncs = class_copyMethodList([Person class], &count);
    for (int i = 0; i < count; i++)
    {
        SEL address = method_getName(memberFuncs[i]);
        NSString *methodName = [NSString stringWithCString:sel_getName(address) encoding:NSUTF8StringEncoding];
        NSLog(@"member method : %@",methodName);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
