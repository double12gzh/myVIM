
# 说明
此镜像中默认安装了python36和golang 1.15.2

* (可选)已安装 `highlight`，可以让我们执行`ccat`等命令时带有颜色方案
* (可选)已安装 `direnv`，自动生成隔离的环境

> * 以上两点的设置可以参考[这里](https://double12gzh.github.io/wiki/#linux%20cat%E9%AB%98%E4%BA%AE)
> 
> * direnv的使用方法：
> 
> 	* 进入到项目目录
>	* `rm -rf .envrc && echo "layout go" > .envrc`（这是对于GoLang项目，如果是Python项目，请使用`echo "layout python"`）
> 	* 根据提示输入：`direnv allow .`
>	* 执行`go get -u -v ./...`下载代码中的所有依赖到`{项目根目录}/.direnv`

# 使用
## 容器化方式(推荐)

```bash
1. 生成镜像
docker build --no-cache -t myvim --build-arg GOVERSION=1.15.2 .

# 或者可以执行以下命令生成镜像
# make build-image

2. 启动容器
docker run -itd -v xxx:/home/xxx --name vim myvim:latest

3. 进入到容器中
docker exec -it vim zsh
```

> GOVERSION如果没有提供，默认会安装go1.15.2
> 
> PYTHONVERSION如果没有提供，默认安装python36

## 非容器化

建议使用root用户执行以下命令：

```bash
sh setup_for_centos8.sh
```

或者可以执行以下命令:

```bash
make local-setup
```

# 快捷键
|键|功能|
|---|----------------			 |
|F1|帮助                                  |
|F2|打开NerdTree         			|
|F3|打开TagList(shift+i:显示隐藏的文件/文件夹)					   |
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
> 按下 `Esc` 或 `<Ctrl-c>` 可退出ctrlp，返回到Vim窗口中
>
> 按下` F5` 用于刷新当前操作路径下的文件缓存，可以使用命令 `let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp' `设置缓存文件存放路径
>
> 使用 `<Ctrl-k>` 和` <Ctrl-j> `在模糊搜索结果列表中上下移动 (当然也可以使用键盘上的上下方向键)
>
> 使用 `<Ctrl-f>` 和 `<Ctrl-b> `在查找文件模式、查找缓冲区模式、查找MRU文件几种模式间进行切换 (cycle between modes)
>
> 使用 `<Ctrl-d>` 在 路径匹配 和 文件名匹配 之间切换 (switch to filename search instead of full path) ，可以通过设置 let g:ctrlp_by_filename = 1 来设置默认使用 文件名匹配 模式进行模糊搜索
>
> 使用 `<Ctrl-r> `在 ''字符串模式'' 和 ''正则表达式模式'' 之间切换 (switch to regexp mode)
>
> 使用 `<Ctrl-t> `在新的Vim标签页中打开文件 (open the selected entry in a new tab)
> 
> 使用 `<Ctrl-p> `或` 选择前或后一条历史记录
>
> ` <Ctrl-y>` 用于当搜索的目标文件不存在时创建文件及父目录 (create a new file and its parent directories)
>
> 使用` <Ctrl-z>` 标记或取消标记多个文件， 标记多个文件后可以使用` <Ctrl-o>` 同时打开多个文件 (mark/unmark multiple files and to open them)

## 5. ]]不同的类间跳转
## 6. F7
		- pep8 check
## 7. ALE
		- F8 打开ALE，进行动态代码检查
## 8. tag相关(未完)
    - ctrl + W + } 预览定义
    - Ctrl + W + ] 在新窗口中打开
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

## 12. 文件比较之插件法
:DirDiff file1 file2

## 13. 文件夹比较之diff
diff -r -u ark-installer_v0.1 ark-installer_v0.2| vim -R -
diff -rq folder1 folder2

## 14.文件比较之diff
diff file1 file2 | vim -

## 15. 代码补全
ctrl+x+o
> 如果希望可以自动出现代码提示，可以把`au filetype go inoremap <buffer> . .<C-x><C-o>`加入到~/.vimrc的最后一行

## 16. 自动导入
:w!

## 17. 查看godoc
shift + k

## 18. 在NerdTree中，创建/删除文件/文件夹
ma

## 其它：
[vim docker 镜像](https://hub.docker.com/r/double12gzh/centos_with_vim)

https://www.jianshu.com/p/110b27f8361b


