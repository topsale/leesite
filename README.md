# LeeSite
一款基于代码生成器的快速开发平台，用于解决 Java Web 项目中的重复工作。开发工具采用 Intellij IDEA，使用 Maven 方式构建。前端 UI 采用 Bootstrap MetroNic V4.7 实现。

## 安装和开始
参考文档及详细说明发表在[WiKi](https://github.com/topsale/leesite/wiki/LeeSite)

### 快速搭建

#### 步骤一：下载源码
git clone https://github.com/topsale/leesite.git

#### 步骤二：安装本地依赖
这里使用了 maven-install-plugin 插件，通过拦截 mvn clean 命令将依赖安装至本地仓库

mvn clean

#### 步骤三：初始化数据库
* 修改 leesite-database/db-init.properties 文件，替换为自己的数据源
* 进入 leesite-database/db 目录，双击运行 db-init.bat

#### 步骤四：修改数据源
修改 leesite-module/src/main/resources/leesite.properties 文件，替换为自己的数据源

#### 步骤五：启动
将项目导入 IEDA，创建 Tomcat Server，启动即可