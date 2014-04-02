shelltool
==========

排查线上问题的shell 脚本

执行curl -o rt.sh "https://raw.github.com/olylakers/shelltoolx/master/rt.sh" 把脚本下载到本地（curl -sLK "https://raw.github.com/olylakers/shelltoolx/master/rt.sh" 然后加管道就不能read参数，所以就只能先下载）
按如下格式执行命令：
./rt.sh //home/admin/cai/logs/cronolog/2014/03/2014-03-19-taobao-access_log "19/Mar/2014:20:01:" "19/Mar/2014:21:59:" 100000

第一个参数为日志地址，参数2和参数3为起始时间，最后一个参数为min rt 即查找大于min rt的api请求



messageStat.sh

sh messageStat.sh  //home/admin/tpn/logs/access.log 1396407540000 1396407899000   (日志路径，开始时间，结束时间)
