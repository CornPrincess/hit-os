#include <linux/kernel.h>
#include <asm/segment.h>
#include <errno.h>

#define NAMELEN 23
char username[NAMELEN + 1];

/*
 * 完成的功能是将字符串参数 name 的内容拷贝到内核中保存下来，即将用户态的数据保存到内核中
 * 
 * 要求 name 的长度不能超过 23 个字符。返回值是拷贝的字符数。
 * 如果 name 的字符个数超过了 23，则返回 “-1”，并置 errno 为 EINVAL。
 */
int sys_iam(const char * name) {
	int namelen = 0;
	while (get_fs_byte(name + namelen) != '\0') {
		namelen++;
	}
	if (namelen <= NAMELEN) {
		//printk("iam start to copy, name: %s, namelen: %d\n", name, namelen);
		int i;
		for (i = 0; i < namelen; i++) {
			username[i] = get_fs_byte(name + i);
		}
		username[i] = '\0';
		//printk("iam success, username: %s, res: %d\n", username, namelen);
		return namelen;
	} else {
		//printk("iam error, the username's length is %d longer than 23!\n", namelen);
		return -(EINVAL);
	}
}

/*
 * 它将内核中由 iam() 保存的名字拷贝到 name 指向的用户地址空间中，
 * 同时确保不会对 name 越界访存（name 的大小由 size 说明）。
 * 即将内核中的数据拷贝到用户态中
 * 
 * 返回值是拷贝的字符数。如果 size 小于需要的空间，则返回“-1”，并置 errno 为 EINVAL
 */
int sys_whoami(char* name, unsigned int size) {
	unsigned int namelen = 0;
	int i;
	int res = 0;
	while (username[namelen] != '\0') {
		namelen++;
	}
	if (namelen > size) {
		//printk("whoami error, the namelen %d is longer than size %d\n", namelen, size);
		res = -(EINVAL);
	} else {
		for (i = 0; i < namelen; i++) {
			put_fs_byte(username[i], name + i);
		}
		put_fs_byte('\0', name + i);
		res = namelen;
		//printk("whoami success, str: %s, namelen: %d\n", username, namelen);
	}
	return res;
}
