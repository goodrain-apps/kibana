 
>Kibana 是一个基于浏览器页面的 ElasticSearch 前端展示工具，内置了各种查询和聚合操作，并拥有图形化展示功能。
>
> 更多信息参见： [wikipedia.org/wiki/Kibana](https://en.wikipedia.org/wiki/Kibana)

<a href="http://app.goodrain.com/app/18/" target="_blank" ><img src="http://www.goodrain.com/images/deploy/button_16012601.png" width="147" height="32"></img></a>


# 目录
- [部署到好雨云](#部署到好雨云)
	- [ELK结构](#ELK结构)
	- [一键部署](#一键部署)
- [部署到本地](#部署到本地)
	- [拉取或构建镜像](#拉取或构建镜像)
		- [拉取镜像](#拉取镜像)
		- [构建镜像](#构建镜像)
	- [运行](#运行)
- [支持的Docker版本](#支持的Docker版本)
- [用户反馈](#用户反馈)
	- [相关文档](#相关文档)
	- [问题讨论](#问题讨论)
	- [参与项目](#参与项目)
- [版权说明](#版权说明)

# 部署到好雨云
## ELK结构
![elk](https://github.com/goodrain-apps/logstash/blob/master/2.1/img/elk_dockerfile.png)

## 一键部署
通过点击本文最上方的 “安装到好雨云” 按钮会跳转到 好雨应用市场的应用首页中，可以通过一键部署按钮安装

**注意：**

- Kibana 应用依赖 Elasticsearch 和 Logstash 应用，因此在安装 Kibana 时会自动安装其它两个依赖的应用
- 需要日志处理的应用请在 依赖服务 中关联 logstash 应用，应用与logstash可以是一对一的关系，也可以是多对一的关系，还可以是多对多的关系。
- Elasticsearch 目前是单个实例，集群模式后续更新


# 部署到本地
## 拉取货构建镜像
### 拉取镜像
```bash
docker pull goodrain.io/kibana:4.3_latest
# rename tag
docker tag -f goodrain.io/kibana:4.3_latest kibana
```
### 构建镜像
```bash
git clone https://github.com/goodrain-apps/kibana.git
cd kibana/4.3
docker build -t kibana  .
```
## 运行
可以运行默认的 `kibana` 命令:
```bash
$ docker run --link some-elasticsearch:elasticsearch -d kibana
```


也可以为 `kibana` 指定一个参数:

```bash
$ docker run --link some-elasticsearch:elasticsearch \
              -d kibana \
              --plugins /somewhere/else
```

这个镜像包含 `EXPOSE 5601` [会暴露这个默认端口](https://www.elastic.co/guide/en/kibana/current/_setting_kibana_server_properties.html)。如果想通过宿主机IP访问到这个端口，必须在启动时指定端口映射：

```bash
$ docker run --name some-kibana \
             --link some-elasticsearch:elasticsearch \
             -p 5601:5601 -d kibana
```

也可以通过 `ELASTICSEARCH_URL` 环境变量来指定 elasticsearch 的地址：

```bash
$ docker run --name some-kibana \
             -e ELASTICSEARCH_URL=http://some-elasticsearch:9200 \
             -p 5601:5601 -d kibana
```

最后，可以在浏览器中访问 `http://localhost:5601` 或者 `http://host-ip:5601` 

# 支持的Docker版本
该镜像支持  Docker 1.9.1 版本，最低支持到 1.6

请参考 [ Docker 安装文档](https://docs.docker.com/installation/) 来升级你的Docker

# 用户反馈
## 相关文档

- [kibana 4.3 镜像说明文档]()
- [kibana 中文文档](http://kibana.logstash.es/content/kibana/index.html)


## 问题讨论
- [GitHub issue]()
- [kibana 好雨云社区讨论]()

## 参与项目
如果你觉得这个镜像很有用或者愿意共同改进项目，可以通过如下形式参与：

- 如果有新特性或者bug修复，请发送 一个 Pull 请求，我们会及时反馈。

# 版权说明

- 官方 [ 版权信息 ](https://github.com/elastic/kibana/blob/4557a6fc0ba08c5e7ac813a180179e5e2631c90a/LICENSE.md) 同样适用于本镜像
