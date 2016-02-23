# signature
# 生成签名
```
node signature.js aa.zip
```
# app验证
读取1package.json，替换掉key的值为""后获取md5值与1package.json原来的key判断
