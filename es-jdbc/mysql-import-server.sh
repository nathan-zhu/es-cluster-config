#!/bin/sh
#DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
#bin=${DIR}/../bin
#lib=${DIR}/../lib
bin="/var/www/GZ/elasticsearch-2.2.0/elasticsearch-jdbc-2.2.0.0/bin"
lib="/var/www/GZ/elasticsearch-2.2.0/elasticsearch-jdbc-2.2.0.0/lib"
echo '{
    "type" : "jdbc",
    "jdbc": {
        "url":"jdbc:mysql://10.1.3.18:3933/ganji_vehicle",
        "statefile" : "statefile.json",
        "user":"gz_zhulidong",
        "password":"d76879",
        "sql": [ {
          "statement" :"select id as _id,clue_id,puid,car_source_status,create_time,temp_address,temp_time,title,price,base_price,suggest_price,minor_category_name,minor_category_url,tag_name,tag_url,car_id,license_date,license_month,road_haul,person,seller_name,seller_id,seller_job,seller_description,transfer_num,phone,nake_price,car_number,vin,agreement_code,image_url,evaluate_url,prepay_price,transfer_time,prepay_time,deal_price,contract_number,buyer_name,buyer_phone,buyer_id,engine,update_time,status_update_time,create_operator,car_year,city_id,district_id,trader,dealer,stop_sale_reason,promote_price,bill_url,clue_source_type,evaluator,verify_pdf_url,order_id,order_status,contract_seller_name,contract_seller_phone,contract_image,order_number,chang_status_remark,source_level,auto_type,carriages,fuel_type,gearbox,air_displacement,emission_standard,car_color,guobie,seats,user_defined_category,business_insurance_year,business_insurance_month,strong_insurance_year,strong_insurance_month,audit_year,audit_month,minor_category_id,tag_id,gender,order_index,top_index,special_audit,is_unique_car_source,record_modify_time from vehicle_c2c_car_source where record_modify_time > ?",
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
          "host" : "127.0.0.1",
          "port" : 9300
        }
    }
}' | java \
       -cp "${lib}/*" \
       -Dlog4j.configurationFile=${bin}/log4j2.xml \
       org.xbib.tools.Runner \
       org.xbib.tools.JDBCImporter
