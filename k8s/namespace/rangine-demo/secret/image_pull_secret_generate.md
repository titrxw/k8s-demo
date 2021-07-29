## 说明
Secret有三种类型：

Opaque：base64 编码格式的 Secret，用来存储密码、密钥等；但数据也可以通过base64 –decode解码得到原始数据，所有加密性很弱。

kubernetes.io/dockerconfigjson：用来存储私有docker registry的认证信息。

kubernetes.io/service-account-token：用于被serviceaccount引用，serviceaccout 创建时
Kubernetes会默认创建对应的secret。Pod如果使用了serviceaccount，对应的secret会自动挂载到Pod目录/run/secrets/kubernetes.io/serviceaccount中。


### 一
先用docker登录hub，登录的用户名密码为在hub上注册的用户名密码，并且登录用户需要有对应仓库的拉取权限，否则不能访问仓库。登录示例：docker login ，登录之后会生成~/.docker/config.json文件，config.json文件内容如下
```
 {

  "auths": {

  "hub.yxtc.com:8081": {

  "auth": "Y3I3Olh1MTIzNDU2MjU="

  }

  }

 } 
```

### 二

 再对上面的config.json进行base64加密，命令如下：

 cat ~/.docker/config.json |base64 -w 0

 ewoJImF1dGhzIjogewoJCSJodWIueXh0Yy5jb206ODA4MSI6IHsKCQkJImF1dGgiOiAiWTNJM09saDFNVEl6TkRVMk1qVT0iCgkJfQoJfQp9Cg==


### 三

创建secret.yaml文件，文件内容如下：

 apiVersion: v1

 kind: Secret

 metadata:

  name: mysecret

 data:

  .dockerconfigjson: ewoJImF1dGhzIjogewoJCSJodWIueXh0Yy5jb206ODA4MSI6IHsKCQkJImF1dGgiOiAiWTNJM09saDFNVEl6TkRVMk1qVT0iCgkJfQoJfQp9Cg==

 type: kubernetes.io/dockerconfigjson

 
 创建secret，命令如下：

         kubectl create -f secret.yaml，生成secret

 


### 四

新建pod，用imagePullSecrets指定secret，pod的yaml文件示例如下：

 apiVersion: v1

 kind: Pod

 metadata:

  name: foo

 spec:

  containers:

  - name: foo

  image: hub.yxtc.com:8081/iss/iss-we:201806260754_d9eb552

  imagePullPolicy: Always

  imagePullSecrets:

  - name: mysecret