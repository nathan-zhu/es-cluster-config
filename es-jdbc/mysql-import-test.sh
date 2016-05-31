#!/bin/sh
#DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
#bin=${DIR}/../bin
#lib=${DIR}/../lib
bin="/var/www/GZ/elasticsearch-2.2.0/elasticsearch-jdbc-2.2.0.0/bin"
lib="/var/www/GZ/elasticsearch-2.2.0/elasticsearch-jdbc-2.2.0.0/lib"
echo $bin;
echo $lib;
echo '{
    "type" : "jdbc",
    "jdbc": {
        "url":"jdbc:mysql://localhost:3306/gz",
        "statefile" : "statefile.json",
        "user":"root",
        "password":"mariadb",
        "schedule":"0 0/5 * * * ?",
        "sql": [ {
          "statement" :"select *,id as _id from vehicle_c2c_car_source_copy where es_update_time > ?",
          "parameter" : [ "$metrics.lastexecutionstart" ]
        }],
        "index" : "car_source_test",
        "type" : "car_source_test",
        "metrics" : {
          "enabled" : "true",
          "interval" : "1m",
          "logger" : {
            "plain" : "false",
            "json" : "true"
          }
        },
        "elasticsearch" : {
          "cluster" : "Test-cluster",
          "host" : "192.168.12.98",
          "port" : 9300
        }
    }
}' | java \
       -cp "${lib}/*" \
       -Dlog4j.configurationFile=${bin}/log4j2.xml \
       org.xbib.tools.Runner \
       org.xbib.tools.JDBCImporter
