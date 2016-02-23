var md5File = require('md5-file');
var fs=require('fs');
var arguments = process.argv.splice(2);
var zip_file = arguments[0];
var zip_code =  md5File(zip_file);
console.log(zip_code);
fs.readFile("1package.json",'utf-8', function(err, data){
  var content = data.replace(/"key":(.*)/g,"\"key\":\""+""+"\",");
  content = content.replace(/"package_md5":(.*)/g,"\"package_md5\":\""+zip_code+"\",");
  fs.writeFile('/tmp/test.json', content, function(err) {
    var ss = md5File("/tmp/test.json");
    fs.readFile("/tmp/test.json",'utf-8', function(err, data){

          var nc = data.replace(/"key":(.*)/g,"\"key\":\""+ss+"\",");
          console.log(nc);
          fs.writeFile('1package.json', nc, function(err) {

          });
    })
  });
});
