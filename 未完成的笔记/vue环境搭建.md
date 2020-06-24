# vue 环境搭建

## 安装node.js

https://nodejs.org/en/download/

添加到环境变量

输入命令查看版本

```bash
node -v
npm -v
```

## 安装vue

```bash
# 安装淘宝npm
npm install -g cnpm --registry=https://registry.npm.taobao.org
# vue-cli 安装依赖包
cnpm install --g vue-cli
# 查看版本
vue -v
# 打开vue ui
vue ui
# 重新安装vue-cli最新版
cnpm i -g @vue/cli
```

使用`vue ui`打开vue的可视化项目管理页面，进行项目创建

项目结构:

```txt
├── README.md            项目介绍
├── index.html           入口页面
├── build              构建脚本目录
│  ├── build-server.js         运行本地构建服务器，可以访问构建后的页面
│  ├── build.js            生产环境构建脚本
│  ├── dev-client.js          开发服务器热重载脚本，主要用来实现开发阶段的页面自动刷新
│  ├── dev-server.js          运行本地开发服务器
│  ├── utils.js            构建相关工具方法
│  ├── webpack.base.conf.js      wabpack基础配置
│  ├── webpack.dev.conf.js       wabpack开发环境配置
│  └── webpack.prod.conf.js      wabpack生产环境配置
├── config             项目配置
│  ├── dev.env.js           开发环境变量
│  ├── index.js            项目配置文件
│  ├── prod.env.js           生产环境变量
│  └── test.env.js           测试环境变量
├── mock              mock数据目录
│  └── hello.js
├── package.json          npm包配置文件，里面定义了项目的npm脚本，依赖包等信息
├── src               源码目录 
│  ├── main.js             入口js文件
│  ├── app.vue             根组件
│  ├── components           公共组件目录
│  │  └── title.vue
│  ├── assets             资源目录，这里的资源会被wabpack构建
│  │  └── images
│  │    └── logo.png
│  ├── routes             前端路由
│  │  └── index.js
│  ├── store              应用级数据（state）状态管理
│  │  └── index.js
│  └── views              页面目录
│    ├── hello.vue
│    └── notfound.vue
├── static             纯静态资源，不会被wabpack构建。
└── test              测试文件目录（unit&e2e）
  └── unit              单元测试
    ├── index.js            入口脚本
    ├── karma.conf.js          karma配置文件
    └── specs              单测case目录
      └── Hello.spec.js
```

## 安装element-ui

element-ui组件（element.eleme.cn）

切换到项目根路径

```bash
cnpm install element-ui --save
```

然后我们打开项目src目录下的main.js，引入element-ui依赖。

```vue
import Element from 'element-ui'
import "element-ui/lib/theme-chalk/index.css"
Vue.use(Element)
```

## 安装axios

www.axios-js.com/

axios是一个基于 promise 的 HTTP 库

```bash
cnpm install axios --save
```

然后同样我们在main.js中全局引入axios。

```vue
import axios from 'axios'
Vue.prototype.$axios = axios
```

组件中，我们就可以通过this.$axios.get()来发起请求

## 运行

```bash
npm run serve
```

idea中：
    运行配置为 npm
    Command  为 run
    Scripts  为 serve
