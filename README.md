https://www.jianshu.com/p/110b27f8361b

# 安装
```
pip install pygments
sudo apt-get install vim
sudo apt-get install ctags
```


# 快捷键
|键|功能|
|---|----------------			 |
|F1|帮助                                  |
|F2|打开NerdTree         			|
|F3|打开TagList					   |
|F4|打开ctrlp搜索文件				|
|F5|PreviewTag						|
|F6|打开Grepper搜索关键字   |
|F7|Flake8 check					|
|F8|打开ALE							  |
|F9|signify								   |
## 1. Grepper
:Grepper 打开搜索
 :vnew filename 打开搜索到的文件
![image.png](https://img-blog.csdnimg.cn/20181228113940322.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2d6aG91Yw==,size_16,color_FFFFFF,t_70)

## 2. NerdTree
		- F2 打开nerdtree
		- i: 水平打开文件
		- s: 竖直打开文件
## 3. Grepper
		- F6 打开Grepper，进行关键字搜索
		- p在新窗口中预览 

## 4. ctrlp
		- F4 打开ctrlp，进行文件搜索
		- ctrl + d按文件名搜索
			- p 在新窗口中预览
		- ctrl + x 水平打开窗口
		- ctrl + v竖直打开窗口
		- ctrl + p/n历史记录
		- ctrl + z标记文件，ctrl +o对标记的文件打开
		- ctrl + t 打开新的tab页
			- tab页切换： 向左: ,,  向右：,.
## 5. ]]不同的类间跳转
## 6. F7
		- pep8 check
## 7. ALE
		- F8 打开ALE，进行动态代码检查
## 8. tag相关(未完)
    - ctrl + W + } 预览定义
    - ctrl + ]跳转查看定义
    - PreviewTag tagname 预览tag
    - PreviewFile filename预览文件
    - F3 打开taglist
	- g + ]列出所有的定义
	- ctrl + t回到上次跳转的位置
	- ctrl + o后退
	- ctrl + i前进
	- [ + I 全文查找
	- ] + I 光标处向下查找
	- % 大括号间跳转
## 9.vim-preview(未完)
		- F5 当光标在所在的tag处时，按F5执行do preview
		> 说明：这两个命令在Grepper中尝试过成功了，但是在g+]中没有成功
		- p打开预览窗口
		- P关闭预览窗口

## 10. vim-signify(未完)
	与git相关，通过与vim-fugitive联合使用。
		- F9 gitdiff
## 11. subline
![image.png](https://cdn-pri.nlark.com/lark/0/2018/png/124229/1538205492046-801aeedd-0da7-4eb1-b4b7-3488f4185ce2.png)
标签切换： :b1

## 其它：
vim docker 镜像：https://cloud.docker.com/u/double12gzh/repository/docker/double12gzh/centos_with_vim


