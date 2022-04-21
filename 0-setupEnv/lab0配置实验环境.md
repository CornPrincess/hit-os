# Linux-0.11实验环境准备

我们可以在实验楼平台进行实验的练习，但是实验环境不会帮你保存，调试起来也没有自己电脑方便，因此这里记录下在自己电脑上配置实验环境的过程。

## 写在前面

本过程参考了[DeathKing/hit-oslab项目](https://github.com/DeathKing/hit-oslab) 和 [ HIT-Linux-0.11](https://github.com/Wangzhike/HIT-Linux-0.11)，本脚本及原材料均来自于前面两个项目，特此声明原创出处，深表感谢！    


本教材适合 `Ubuntu 16.04 64位` 和 `Ubuntu18.04 64位` 版本。如果是 `Ubuntu 32位系统(i386)` 或者是 `Ubuntu version <= 14.04` 的64位系统，可以直接移步这个[快速配置教程](https://github.com/DeathKing/hit-oslab)。
	

## 实验材料
1. [hit-oslab-linux-20110823.tar.gz](https://github.com/hoverwinter/HIT-OSLab/tree/master/Resources)		
	包含linux-0.11源码，bochs虚拟机等
2. [gcc-3.4-ubuntu.tar.gz](https://github.com/hoverwinter/HIT-OSLab/tree/master/Resources)		
	编译linux-0.11需要用到的低版本的gcc

## 配置环境
1. 克隆该仓库
```shell
$ git clone https://github.com/CornPrincess/hit-os
```
2. 进入到环境配置文件夹
```shell
$ cd hit-os/0-setupEnv
```

3. 执行脚本。     
本安装脚本会将实验环境安装在`hit-os/oslab`目录下。如果有特殊需要，请自行移动文件夹位置。注意，请不要使用超级用户执行此命令，当有需要时该脚本会请求超级用户权限。
	
```shell
# 如果没有执行权限，可以使用如下命令
$ chmod u+x setup.sh

# 执行脚本
$ ./setup.sh
```

## 快速开始
当我们执行完 setup.sh 脚本之后就会在项目目录下生成一个 oslab 文件夹，实验需要用到的素材都在该目录
### 编译内核
进入到linux-0.11 目录下，使用 make 进行编译
```shell
$ cd oslab/linux-0.11
$ make all
# 如果电脑多核，可以使用如下命令
# make -j 2
# 也可以使用入下命令
# make clean && make all
```
编译成功后可以看到在 linux-0.11 目录下有 Image 文件，这个就是 linux 的二进制文件。
使用 oslab 下的 run 脚本可以启动 bochs虚拟机 和 加载 Linux Image
```shell
$ ./run
````
如果看到 bochs 虚拟机的界面并且 linux 加载成功，说明我们此时已经成功安装好环境，可以开始探索 linux 的世界了！人生有多少个十年！

### 汇编调试
```shell
# 确认在 oslab 目录下
$ cd ~/oslab/

# 运行脚本前确定已经关闭刚刚运行的 Bochs
$ ./dbg-asm
````
可以用命令 help 来查看调试系统用的基本命令。更详细的信息请查阅 Bochs 使用手册。

### C调试
C 语言级调试稍微复杂一些。首先执行如下命令：
```shell
$ cd ~/oslab
$ ./dbg-c
```
然后再打开一个终端窗口，执行：
```shell
$ cd ~/oslab
$ ./rungdb
````
注意：启动的顺序不能交换，否则 gdb 无法连接。

### 文件交换
开始设置文件交换之前，务必关闭所有的 Bochs 进程, oslab 下的 hdc-0.11-new.img 是 0.11 内核启动后的根文件系统镜像文件，相当于在 bochs 虚拟机里装载的硬盘。在 Ubuntu 上访问其内容的方法是：
```shell
$ cd ~/oslab/

# 启动挂载脚本
$ sudo ./mount-hdc
```
之后，hdc 目录下就是和 0.11 内核一模一样的文件系统了，可以读写任何文件（可能有些文件要用 sudo 才能访问）。
```shell
# 进入挂载到 Ubuntu 上的目录
$ cd ~/oslab/hdc

# 查看内容
$ ls -al
```
读写完毕，不要忘了卸载这个文件系统：
```shell
$ cd ~/oslab/

# 卸载
$ sudo umount hdc
```

### 恢复linux-0.11
考虑到操作系统实验每次需要重置linux-0.11目录，添加了重置linux-0.11目录下所有文件的功能。本命令由`./run`命令提供。
```bash
$ ./run init
```


## 参考

1. [操作系统实验报告-熟悉实验环境](http://www.cnblogs.com/tradoff/p/5693710.html)    