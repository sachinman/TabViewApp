TabViewApp
==========
个性化对联生成IOS客户端

结合实验室已有的个性化对联生成算法，开发iOS端软件
使用ASP.NET创建Webservice服务，为客户端提供个性化对联生成的接口；在客户端用户
输入名字、职业信息并提交给服务端，接收到返回的xml格式对联数据并解析保存到本地数
据库，同时可选择对联生成对联画。加入百度社会化分享组件可将对联画分享到社交平台。


表1  WebService接口说明
接口名	参数	用途
GetNameCouplet	名字	嵌名对联
GetNameChunCouplet	名字	嵌名春联
GetNameCYuCouplet	名字	成员嵌名春联
GetNameJobCouplet	名字、职业	职业春联
