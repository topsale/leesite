# LeeSite
一款基于代码生成器的快速开发平台，用于解决 Java Web 项目中的重复工作。开发工具采用 Intellij IDEA，使用 Maven 方式构建。前端 UI 采用 Bootstrap MetroNic V4.7 实现。

## Installation and Getting Started
参考文档及详细说明发表在[WiKi](https://github.com/topsale/leesite/wiki/LeeSite)

### Step 1
下载源码

git clone https://github.com/topsale/leesite.git

### Step 2
安装本地依赖

这里使用了 maven-install-plugin 插件，通过拦截 mvn clean 命令将依赖安装至本地仓库

mvn clean

### Step 3
初始化数据库
* 修改 leesite-database/db-init.properties 文件，替换为自己的数据源
* 进入 leesite-database/db 目录，双击运行 db-init.bat

### Setp 4
修改数据源

修改 leesite-module/src/main/resources/leesite.properties 文件，替换为自己的数据源

### Step 5
启动

将项目导入 IDEA，创建 Tomcat Server，启动即可

登录账号：admin

登录密码：admin

## Getting help
**Email** : topsale@vip.qq.com

## Modules overview

### leesite-build
Root 项目，负责整体构建和模块组装

### leesite-dependencies
定义项目所需要的全部依赖

### leesite-parent
依赖 leesite-dependencies 模块，用于配置 CheckStyle，我没有实现 CheckStyle 的具体配置，有需要的同学请自行配置并将 pom.xml 中的 <disable.checks>true</disable.checks> 改为 <disable.checks>false</disable.checks> 即可

### leesite-module
依赖 leesite-parent 模块，项目源码

### leesite-database
依赖 leesite-parent 模块，数据库初始化

## Maven overlays

将 LeeSite 作为框架依赖到您的项目中：

```xml
<dependencies>
	<dependency>
		<groupId>com.funtl.leesite</groupId>
		<artifactId>leesite-dependencies</artifactId>
		<version>${leesite.version}</version>
		<type>pom</type>
		<scope>import</scope>
	</dependency>
	<dependency>
		<groupId>com.funtl.leesite</groupId>
		<artifactId>leesite-module</artifactId>
		<version>${leesite.version}</version>
		<type>war</type>
	</dependency>
	<dependency>
		<groupId>com.funtl.leesite</groupId>
		<artifactId>leesite-module</artifactId>
		<version>${leesite.version}</version>
		<type>jar</type>
		<classifier>classes</classifier>
	</dependency>
</dependencies>
```

## License
LeeSite is Open Source software released under the [Apache 2.0 license.](http://www.apache.org/licenses/LICENSE-2.0.html)