安装
拷贝libetotpverify.so  到系统目录下   


添加Key

curl  -d "no=12312312&authkey=32313123123" http://xxx/register

验证密码
curl  -d "no=13123&pass=12313" http://xxx/validate

删除key

curl  -d "no=13123" http://xxxxxx/delete
