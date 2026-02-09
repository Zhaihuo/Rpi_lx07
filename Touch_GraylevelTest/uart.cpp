#include     <stdio.h>      /*标准输入输出定义*/
#include     <stdlib.h>     /*标准函数库定义*/
#include     <unistd.h>     /*Unix 标准函数定义*/
#include     <stdint.h>
#include     <sys/types.h> 
#include     <sys/stat.h>  
#include     <fcntl.h>      /*文件控制定义*/
#include     <termios.h>    /*POSIX 终端控制定义*/
#include     <errno.h>      /*错误号定义*/
#include	 <string.h>     /*字符串功能函数*/
#include	 <sys/time.h>  
#include	 <sys/types.h>  
#include     <pthread.h>

int       tty_fd = -1;
uint8_t   r_buf[8u];
// uint8_t   t_buf[8u] = {0xAA, 0x01, 0x55, 0x0, 0x0, 0x0, 0x0, 0x0};
uint8_t   t_buf[8u] = {0xAA, 0x00, 0x00, 0x55, 0x0, 0x0, 0x0, 0x0};
struct    termios options;
fd_set    rset;
uint8_t   isOpne = 0;
pthread_t tid;
uint32_t  u32Count = 0;
uint8_t   u8Index = 0;
uint8_t   u8RecvData = 0;
uint8_t   u8StartTestCmd = 0;
uint8_t   u8EndTestCmd = 0;
uint16_t   u16PageValue = 0;
 
void close_serial() 
{
    printf("close_seria ===============\n\n");
    isOpne = 1;
    close(tty_fd);
}
 
void open_serial_init() 
{
    int  rv = -1;

    // tty_fd = open("/dev/ttyAMA0", O_RDWR | O_NOCTTY); //打开串口设备    //rpi5b
    tty_fd = open("/dev/ttyS0", O_RDWR | O_NOCTTY);//rpi4b
    // tty_fd = open("/dev/ttyUSB0", O_RDWR | O_NOCTTY);
    if (tty_fd < 0)
    {
        printf("open tty failed:%s\n", strerror(errno));
        close_serial();
        return;
    }
 
    printf("open devices sucessful!\n");
    memset(&options, 0, sizeof(options));
    //rv = tcgetattr(tty_fd, &options); //获取原有的串口属性的配置
    //if (rv != 0)
    //{
    //    printf("tcgetattr() failed:%s\n", strerror(errno));
    //    close_serial();
    //    return;
    //}
 
    options.c_cflag |= (CLOCAL | CREAD); // CREAD 开启串行数据接收，CLOCAL并打开本地连接模式
    options.c_cflag &= ~CSIZE;// 先使用CSIZE做位屏蔽  
    options.c_cflag |= CS8; //设置8位数据位
    options.c_cflag &= ~PARENB; //无校验位

    options.c_cflag &= ~CRTSCTS;
 
    /* 设置波特率  */
    cfsetispeed(&options, B115200);
    cfsetospeed(&options, B115200);
    options.c_cflag &= ~CSTOPB;/* 设置一位停止位; */
    options.c_cc[VTIME] = 10;/* 非规范模式读取时的超时时间；*/
    options.c_cc[VMIN] = 8; /* 非规范模式读取时的最小字符数*/
    tcflush(tty_fd, TCIFLUSH);/* tcflush清空终端未完成的输入/输出请求及数据；TCIFLUSH表示清空正收到的数据，且不读取出来 */
 
 
    if ((tcsetattr(tty_fd, TCSANOW, &options)) != 0)
    {
        // printf("tcsetattr failed:%s\n", strerror(errno));
        close_serial();
        return;
    }
}

void write_serial(void* buff, int size) 
{
    int rv = -1;

    rv = write(tty_fd, buff, size);
    printf("write_serial rv=============== size=%d\n", rv);
    if (rv < 0)
    {
        printf("Write() error:%s\n", strerror(errno));
        close_serial();
        return;
    }
}

void recvdata(uint8_t u8RecvData)
{
    if(u32Count < 500u || (u32Count == 500u && !u8Index))
    {
        /* Header */
        if(!u8Index && u8RecvData == 0xAAu)
        {
            r_buf[u8Index] = u8RecvData;
            u8Index += 1u;
        }
	    /* Data1 */
        else if(u8Index == 1u)
        {
            r_buf[u8Index] = u8RecvData;
            u8Index += 1u;
        }
        /* Data1 */
        else if(u8Index == 2u)
        {
            r_buf[u8Index] = u8RecvData;
            u8Index += 1u;
        }
        /* Tail */
        else if(u8Index == 3u && u8RecvData == 0x55u)
        {
            r_buf[u8Index] = u8RecvData;
            u8Index = 0u;

            for(int i = 0u; i < 4u; i++)
            {
                printf("data=%d\n", r_buf[i]);
            }

            if((r_buf[0] == 0xAA) && (r_buf[3] == 0x55))
            {
                if(r_buf[1] >= 1 && r_buf[1] <= 4)//R G B flicker
                {
                    u16PageValue = r_buf[1];

                    write_serial(r_buf, 4);
                    memset(r_buf, 0, sizeof(r_buf));
                }
                else//W_0 ~ W_255
                {
                    u16PageValue = r_buf[2] + 5;

                    write_serial(r_buf, 4);
                    memset(r_buf, 0, sizeof(r_buf));
                }
            }
            else
            {
                printf("error cmd\n");
            }
        }
	    else if((u8Index == 3u && u8RecvData != 0x55u))
	    {
            u8Index = 0;
            printf("error branch\n");
	    }
    }
    else if(u32Count == 500u && u8Index)
    {
        printf("timeout,clear u8Index\n");
        u8Index = 0;
    }
    else
    {
        /* Do nothing */
    }
}

void* threaduart(void* arg) 
{
    int rv = -1;

    memset(r_buf, 0, sizeof(r_buf));
    open_serial_init();
    while (true) 
    {
        if (isOpne == 0) 
        {
            rv = read(tty_fd, &u8RecvData, 1u);
            if (rv < 0)
            {
                printf("Read() error:%s\n", strerror(errno));
                close_serial();
            }
            else 
            {
                // usleep(5000);
                // write_serial(r_buf, sizeof(r_buf));
            }
            printf("read data=%d\n", u8RecvData);
            recvdata(u8RecvData);
            u32Count = 0u;
            // write_serial(r_buf, 1);
        }
        else 
        {
            // printf("Read tty null=: %s\n", r_buf);
        }
    }
}
 
void test() 
{
    int num = 0;
    char buff[3];

    buff[num++] = 0x02;
    buff[num++] = 0x41;
    buff[num++] = 0x03;
    write_serial(buff, num);
}

void* threadtime(void* arg)
{
    while(true)
    {
        if(u32Count < 500)
            u32Count ++;
        else
        {
            /* Do nothing */
        }

        if(u8EndTestCmd && u32Count == 500)
        {
            // u8EndTestCmd = false;
            write_serial(t_buf, 4);
            printf("test end\n");
        }
        usleep(1000);
    }
}

// int main(int argc, char* argv[])
// {
//     int ret = -1;
//     ret = pthread_create(&tid, NULL, threadtime, NULL);
//     if(ret == 0)
//     {
//         printf("create thread successfully!\n");
//         ret = pthread_detach(tid);
//         if(ret == 0)
//         {
//             printf("thread detach successfully!\n");
//         }
//     }
//     open_serial_init();
//     // test();
//     // read_serial();
//     close_serial();
//     return 0;
// }
