// to run this from command line
// cd "project_path\modules\java\scrapper";
// javac -cp ".\jsoup.jar;.\mysql-connector-j.jar" Main.java;
// java -cp ".;jsoup.jar;mysql-connector-j.jar" Main ;

import java.util.*;

import java.io.IOException;

import java.sql.*;
import org.jsoup.Jsoup;  
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class Main{
    public static void main(String[] args) throws Exception {
        String  city_name = "chennai"; // This is the default city_name
        boolean run_db_update = true;
        System.out.println("--------------------------------------------------");
            if(args.length>0){
                city_name = args[0].trim();
            }
            else{
                System.out.println("city_name not found in args...");
            }
            System.out.println("Using city_name: " + city_name);
        System.out.println("--------------------------------------------------");
        HashMap<String,HashMap<String,String>> data1 = new HashMap<String,HashMap<String,String>>();
        HashMap<String,HashMap<String,String>> data2 = new HashMap<String,HashMap<String,String>>();
        try{
            Document doc1 = get_jsoup_documnet("cur", city_name);
            data1 = prepare_hashmap(doc1, "cur");
        }
        catch(Exception e){
            System.out.println("Error in getting 'data1'!!!");
            run_db_update = false;
        }

        try{
            Document doc2 = get_jsoup_documnet("forecast", city_name);
            data2 = prepare_hashmap(doc2, "forecast");
        }
        catch(Exception e){
            System.out.println("Error in getting 'data2'!!!");
            run_db_update = false;
        }
        int code = 1;
        if (run_db_update){
            code = update_database(data1, data2, city_name);
        }
        else{
            System.out.println("Update Database did not run");
        }


        // This if-else block should be the final code as the pyhton program would check for the below lines in end of output
        if(code == 0){
            System.out.println("Database updating : Successful");
        }
        else{
            System.out.println("Database updating : Failed");
        }
    }

    static Document get_jsoup_documnet(String s, String city_name) throws IOException{
        // s = {cur, forcast}
        String api_key = "3ee7b1de4ea02df8f299bc30ee86bb8a";
        String url = "";
        if (s == "cur"){
            url = "https://api.openweathermap.org/data/2.5/weather?q="+ city_name +"&appid="+api_key+"&mode=xml";
        }
        else if(s == "forecast"){
            url = "https://api.openweathermap.org/data/2.5/forecast?q=" + city_name + "&appid=" + api_key+"&mode=xml";
        }
        Document doc = Jsoup.connect(url).get();
        return doc;
    }

    static HashMap<String,HashMap<String,String>> prepare_hashmap(Document doc, String s){
        // s = {cur, forcast}
        HashMap<String,HashMap<String,String>> hash_map = new HashMap<String,HashMap<String,String>>();
        HashMap<String, String> temp_h1 = new HashMap<String, String> ();
        Elements cur_sec;

        if(s == "cur"){
            hash_map = new HashMap<String,HashMap<String,String>>();
            List<HashMap<String, String>> temp_list_h = new ArrayList<HashMap<String, String>>(11);
            
            temp_list_h.add(new HashMap<String, String>());
            cur_sec = doc.select("city");
            temp_list_h.get(0).put("id",cur_sec.attr("id"));
            temp_list_h.get(0).put("name",cur_sec.attr("name"));
            cur_sec = doc.select("coord");
            temp_list_h.get(0).put("coord_lon",cur_sec.attr("lon"));
            temp_list_h.get(0).put("coord_lat",cur_sec.attr("lat"));
            cur_sec = doc.select("country");
            temp_list_h.get(0).put("country",cur_sec.text());
            cur_sec = doc.select("timezone");
            temp_list_h.get(0).put("timezone",cur_sec.text());
            cur_sec = doc.select("sun");
            temp_list_h.get(0).put("sun_rise",cur_sec.attr("rise"));
            temp_list_h.get(0).put("sun_set",cur_sec.attr("set"));
            hash_map.put("city", temp_list_h.get(0));

            temp_list_h.add(new HashMap<String, String>());
            cur_sec = doc.select("temperature");
            temp_list_h.get(1).put("value",cur_sec.attr("value"));
            temp_list_h.get(1).put("min",cur_sec.attr("min"));
            temp_list_h.get(1).put("max",cur_sec.attr("max"));
            temp_list_h.get(1).put("unit",cur_sec.attr("unit"));
            hash_map.put("temperature", temp_list_h.get(1));

            temp_list_h.add(new HashMap<String, String>());
            cur_sec = doc.select("feels_like");
            temp_list_h.get(2).put("value",cur_sec.attr("value"));
            temp_list_h.get(2).put("unit",cur_sec.attr("unit"));
            hash_map.put("feels_like", temp_list_h.get(2));

            temp_list_h.add(new HashMap<String, String>());
            cur_sec = doc.select("humidity");
            temp_list_h.get(3).put("value",cur_sec.attr("value"));
            temp_list_h.get(3).put("unit",cur_sec.attr("unit"));
            hash_map.put("humidity", temp_list_h.get(3));

            temp_list_h.add(new HashMap<String, String>());
            cur_sec = doc.select("pressure");
            temp_list_h.get(4).put("value",cur_sec.attr("value"));
            temp_list_h.get(4).put("unit",cur_sec.attr("unit"));
            hash_map.put("pressure", temp_list_h.get(4));

            temp_list_h.add(new HashMap<String, String>());
            cur_sec = doc.select("speed");
            temp_list_h.get(5).put("speed_value",cur_sec.attr("value"));
            temp_list_h.get(5).put("speed_unit",cur_sec.attr("unit"));
            temp_list_h.get(5).put("speed_name",cur_sec.attr("name"));
            cur_sec = doc.select("direction");
            temp_list_h.get(5).put("direction_value",cur_sec.attr("value"));
            temp_list_h.get(5).put("direction_code",cur_sec.attr("code"));
            temp_list_h.get(5).put("direction_name",cur_sec.attr("name"));
            hash_map.put("wind", temp_list_h.get(5));

            temp_list_h.add(new HashMap<String, String>());
            cur_sec = doc.select("clouds");
            temp_list_h.get(6).put("value",cur_sec.attr("value"));
            temp_list_h.get(6).put("name",cur_sec.attr("name"));
            hash_map.put("clouds", temp_list_h.get(6));

            temp_list_h.add(new HashMap<String, String>());
            cur_sec = doc.select("visibility");
            temp_list_h.get(7).put("value",cur_sec.attr("value"));
            hash_map.put("visibility", temp_list_h.get(7));

            temp_list_h.add(new HashMap<String, String>());
            cur_sec = doc.select("precipitation");
            temp_list_h.get(8).put("mode",cur_sec.attr("mode"));
            hash_map.put("precipitation", temp_list_h.get(8));

            temp_list_h.add(new HashMap<String, String>());
            cur_sec = doc.select("weather");
            temp_list_h.get(9).put("number",cur_sec.attr("number"));
            temp_list_h.get(9).put("value",cur_sec.attr("value"));
            temp_list_h.get(9).put("icon",cur_sec.attr("icon"));
            hash_map.put("weather", temp_list_h.get(9));

            temp_list_h.add(new HashMap<String, String>());
            cur_sec = doc.select("lastupdate");
            temp_list_h.get(10).put("value",cur_sec.attr("value"));
            hash_map.put("lastupdate", temp_list_h.get(10));
        }
        else if (s == "forecast"){
            hash_map = new HashMap<String,HashMap<String,String>>();
            temp_h1 = new HashMap<String, String> ();
            List<HashMap<String, String>> temp_list_h = new ArrayList<HashMap<String, String>>(40);

            cur_sec = doc.select("location"); // fetching <location> section
            temp_h1.put("location_name", cur_sec.select("name").text());
            temp_h1.put("location_country", cur_sec.select("country").text());
            temp_h1.put("location_timezone", cur_sec.select("timezone").text());
            for(Element el: cur_sec){
                if(el.attr("latitude").equals("")){continue;}
                temp_h1.put("altitude", el.attr("altitude"));
                temp_h1.put("latitude", el.attr("latitude"));
                temp_h1.put("longitude", el.attr("longitude"));
                temp_h1.put("geobase", el.attr("geobase"));
                temp_h1.put("geobaseid", el.attr("geobaseid"));
            }
            cur_sec = doc.select("meta"); // fetching <meta> section
            temp_h1.put("meta", cur_sec.text());
            cur_sec = doc.select("sun"); // fetching <sun> section
            for (Element el: cur_sec){
                temp_h1.put("sun_rise", el.attr("rise"));
                temp_h1.put("sun_set", el.attr("set"));
            }
            hash_map.put("extra_info", temp_h1);
            hash_map.put("datetime_order", new HashMap<String, String>());

            // Putting data of each three hours of 5 days in the map
            cur_sec = doc.select("time");
            int i = -1;
            for(Element el: cur_sec){
                i++;
                temp_list_h.add(new HashMap<String, String>());
                temp_list_h.get(i).put("from_", el.attr("from"));
                temp_list_h.get(i).put("to_", el.attr("to"));
                Elements sub_tags = el.children();
                for (Element el1: sub_tags){
                    if(el1.tagName().equals("symbol")){
                        temp_list_h.get(i).put("symbol_number", el1.attr("number"));
                        temp_list_h.get(i).put("symbol_name", el1.attr("name"));
                        temp_list_h.get(i).put("symbol_var", el1.attr("var"));
                    }
                    else if(el1.tagName().equals("precipitation")){
                        temp_list_h.get(i).put("precipitation_probability", el1.attr("probability"));
                        temp_list_h.get(i).put("precipitation_unit", el1.attr("unit"));
                        temp_list_h.get(i).put("precipitation_value", el1.attr("value"));
                        temp_list_h.get(i).put("precipitation_type", el1.attr("type"));
                    }
                    else if(el1.tagName().equals("windDirection")){
                        temp_list_h.get(i).put("windDirection_deg", el1.attr("deg"));
                        temp_list_h.get(i).put("windDirection_code", el1.attr("code"));
                        temp_list_h.get(i).put("windDirection_name", el1.attr("name"));
                    }
                    else if(el1.tagName().equals("windSpeed")){
                        temp_list_h.get(i).put("windSpeed_mps", el1.attr("mps"));
                        temp_list_h.get(i).put("windSpeed_unit", el1.attr("unit"));
                        temp_list_h.get(i).put("windSpeed_name", el1.attr("name"));
                    }
                    else if(el1.tagName().equals("windGust")){
                        temp_list_h.get(i).put("windGust_gust", el1.attr("gust"));
                        temp_list_h.get(i).put("windGust_unit", el1.attr("unit"));
                    }
                    else if(el1.tagName().equals("temperature")){
                        temp_list_h.get(i).put("temperature_unit", el1.attr("unit"));
                        temp_list_h.get(i).put("temperature_value", el1.attr("value"));
                        temp_list_h.get(i).put("temperature_min", el1.attr("min"));
                        temp_list_h.get(i).put("temperature_max", el1.attr("max"));
                    }
                    else if(el1.tagName().equals("feels_like")){
                        temp_list_h.get(i).put("feels_like_value", el1.attr("value"));
                        temp_list_h.get(i).put("feels_like_unit", el1.attr("unit"));
                    }
                    else if(el1.tagName().equals("pressure")){
                        temp_list_h.get(i).put("pressure_unit", el1.attr("unit"));
                        temp_list_h.get(i).put("pressure_value", el1.attr("value"));
                    }
                    else if(el1.tagName().equals("humidity")){
                        temp_list_h.get(i).put("humidity_value", el1.attr("value"));
                        temp_list_h.get(i).put("humidity_unit", el1.attr("unit"));
                    }
                    else if(el1.tagName().equals("clouds")){
                        temp_list_h.get(i).put("clouds_value", el1.attr("value"));
                        temp_list_h.get(i).put("clouds_all", el1.attr("all"));
                        temp_list_h.get(i).put("clouds_unit", el1.attr("unit"));
                    }
                    else if(el1.tagName().equals("visibility")){
                        temp_list_h.get(i).put("visibility_value", el1.attr("value"));
                    }
                }
                hash_map.put(el.attr("from"), temp_list_h.get(i));
                hash_map.get("datetime_order").put(Integer.toString(i), el.attr("from"));
            }
        }
        return hash_map;
    }

    static int update_database(HashMap<String,HashMap<String,String>> data1, HashMap<String,HashMap<String,String>> data2, String city_name){
        String database = "app_project_db";
        String user = "root";
        String password = "20081978";
        int code = 0; // error code for update_database 0 = ok , 1 = fail
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(("jdbc:mysql://localhost:3306/"+
                database+"?verifyServerCertificate=false&useUnicode=yes&characterEncoding=UTF-8&useSSL=false&allowPublicKeyRetrieval=true"), user, password);
            Statement statement = connection.createStatement();

            String query_st = "show tables;";
            ResultSet resultSet = statement.executeQuery(query_st);
            List<String> tables_names = new ArrayList<String>();  
            while(resultSet.next()){
                String ss = resultSet.getString(1);
                tables_names.add(ss);
            }
            List<String> query_list = new ArrayList<String>();

            String weather_data_prototype = "(date_time datetime,city_id int,city_name varchar(100),city_coord_lon double,city_coord_lat double,city_country varchar(100),city_timezone int,city_sun_rise datetime,city_sun_set datetime,temperature_value double,temperature_min double,temperature_max double,temperature_unit varchar(100),feels_like_value double,feels_like_unit varchar(100),humidity_value int,humidity_unit varchar(100),pressure_value int,pressure_unit varchar(100),wind_speed_value double,wind_speed_unit varchar(100),wind_speed_name varchar(100), wind_direction_value int,wind_direction_code varchar(100),wind_direction_name varchar(100),clouds_value int,clouds_name varchar(100),visibility_value int,precipitation_mode varchar(100),weather_number int,weather_value varchar(100),weather_icon varchar(100),PRIMARY KEY (date_time))";
            String weather_data_prototype_without_datatype = "(date_time,city_id,city_name,city_coord_lon,city_coord_lat,city_country,city_timezone,city_sun_rise,city_sun_set ,temperature_value ,temperature_min ,temperature_max ,temperature_unit ,feels_like_value ,feels_like_unit ,humidity_value ,humidity_unit ,pressure_value ,pressure_unit ,wind_speed_value ,wind_speed_unit ,wind_speed_name , wind_direction_value ,wind_direction_code ,wind_direction_name ,clouds_value ,clouds_name ,visibility_value ,precipitation_mode ,weather_number ,weather_value ,weather_icon)";
            
            String forecast_data_prototype = "(from_ datetime,to_ datetime,symbol_number int,symbol_name varchar(100),symbol_var varchar(100),precipitation_probability double,precipitation_unit varchar(100),precipitation_value double,precipitation_type varchar(100),windDirection_deg int,windDirection_code varchar(100),windDirection_name varchar(100),windSpeed_mps double,windSpeed_unit varchar(100),windSpeed_name varchar(100),windGust_gust double,windGust_unit varchar(100),temperature_unit varchar(100),temperature_value double,temperature_min double,temperature_max double,feels_like_value double,feels_like_unit varchar(100),pressure_unit varchar(100),pressure_value int,humidity_value int,humidity_unit varchar(100),clouds_value varchar(100),clouds_all int,clouds_unit varchar(100),visibility_value int,PRIMARY KEY (from_))";
            String forecast_data_prototype_without_datatype = "(from_ ,to_ ,symbol_number ,symbol_name ,symbol_var ,precipitation_probability ,precipitation_unit ,precipitation_value ,precipitation_type ,windDirection_deg ,windDirection_code ,windDirection_name ,windSpeed_mps ,windSpeed_unit ,windSpeed_name ,windGust_gust ,windGust_unit ,temperature_unit ,temperature_value ,temperature_min ,temperature_max ,feels_like_value ,feels_like_unit ,pressure_unit ,pressure_value ,humidity_value ,humidity_unit ,clouds_value ,clouds_all ,clouds_unit ,visibility_value )";
            
            String forecast_ext_data_prototype = "(location_name varchar(100),location_country varchar(100),location_timezone int,altitude double,latitude double,longitude double,geobase varchar(100),geobaseid int,meta varchar(100),sun_rise datetime,sun_set datetime)";
            String forecast_ext_data_prototype_without_datatype = "(location_name ,location_country ,location_timezone ,altitude ,latitude ,longitude ,geobase ,geobaseid ,meta ,sun_rise ,sun_set )";

            boolean weather_table_exist = false;
            for(int i=0;i<tables_names.size();i++){
                if(tables_names.get(i).equals(city_name+"_forecast_data")){
                    query_list.add("drop table "+city_name+"_forecast_data"+";");
                }
                if(tables_names.get(i).equals(city_name+"_forecast_data_extra_info")){
                    query_list.add("drop table "+city_name+"_forecast_data_extra_info"+";");
                }
                if(tables_names.get(i).equals(city_name+"_weather_data")){
                    weather_table_exist = true;
                }
            }
            query_list.add("create table "+city_name+"_forecast_data"+ forecast_data_prototype +";");
            query_list.add("create table "+city_name+"_forecast_data_extra_info"+ forecast_ext_data_prototype +";");
            if (!weather_table_exist){query_list.add("create table "+city_name+"_weather_data"+ weather_data_prototype +";");}
            for(int i =0; i<query_list.size();i++){
                statement.executeUpdate(query_list.get(i));
            }

            /*Block start: Putting data in _weather_data */
                query_st = "(";
                query_st += "'" + data1.get("lastupdate").get("value").replace('T', ' ') + "'" ;
                query_st += "," + data1.get("city").get("id");
                query_st += "," + "'" + data1.get("city").get("name") + "'";
                query_st += "," + data1.get("city").get("coord_lon");
                query_st += "," + data1.get("city").get("coord_lat");
                query_st += "," + "'" + data1.get("city").get("country") + "'";
                query_st += "," + data1.get("city").get("timezone");
                query_st += "," + "'" + data1.get("city").get("sun_rise").replace('T', ' ') + "'";
                query_st += "," + "'" + data1.get("city").get("sun_set").replace('T', ' ') + "'";
                query_st += "," + data1.get("temperature").get("value");
                query_st += "," + data1.get("temperature").get("min");
                query_st += "," + data1.get("temperature").get("max");
                query_st += "," + "'" + data1.get("temperature").get("unit") + "'";
                query_st += "," + data1.get("feels_like").get("value");
                query_st += "," + "'" + data1.get("feels_like").get("unit") + "'";
                query_st += "," + data1.get("humidity").get("value");
                query_st += "," + "'" + data1.get("humidity").get("unit") + "'";
                query_st += "," + data1.get("pressure").get("value");
                query_st += "," + "'" + data1.get("pressure").get("unit") + "'";
                query_st += "," + data1.get("wind").get("speed_value");
                query_st += "," + "'" + data1.get("wind").get("speed_unit") + "'";
                query_st += "," + "'" + data1.get("wind").get("speed_name") + "'";
                query_st += "," + data1.get("wind").get("direction_value");
                query_st += "," + "'" + data1.get("wind").get("direction_code") + "'";
                query_st += "," + "'" + data1.get("wind").get("direction_name") + "'";
                query_st += "," + data1.get("clouds").get("value");
                query_st += "," + "'" + data1.get("clouds").get("name") + "'";
                query_st += "," + data1.get("visibility").get("value");
                query_st += "," + "'" + data1.get("precipitation").get("mode") + "'";
                query_st += "," + data1.get("weather").get("number");
                query_st += "," + "'" + data1.get("weather").get("value") + "'";
                query_st += "," + "'" + data1.get("weather").get("icon") + "'";
                query_st += ");";
                query_st = query_st.replace(",,", ",NULL,");
                query_st = query_st.replace("''", "NULL");
                try{
                    // statement.executeUpdate("insert into "+city_name+"_weather_data "+weather_table_prototype_without_datatype+"values('2023-04-04 20:03:55',505,'chennai',23.4,66.8,'abc',1001,'2023-04-04 20:03:55','2023-04-04 20:03:55',23.4,23.4,23.4,'abc',66.8,'abc',1299,'abc',23,'abc',2.3,'abc','abc',132,'abc','abc',23,'abc',12,'abc',122,'abc','abc');");
                    statement.executeUpdate("insert into "+city_name+"_weather_data "+weather_data_prototype_without_datatype+ "values"+query_st);
                }
                catch(SQLIntegrityConstraintViolationException e1){
                    statement.executeUpdate("DELETE FROM "+city_name+"_weather_data "+"WHERE date_time = " + "'" + data1.get("lastupdate").get("value").replace('T', ' ') + "'" +";");
                    statement.executeUpdate("insert into "+city_name+"_weather_data "+weather_data_prototype_without_datatype+ "values"+query_st);
                    System.out.println("No new 'Current Weather' Data found on site!!!(Updated Data)");
                }
                catch(Exception ee){
                    System.out.println("Error Occured while inserting into "+city_name+"_weather_data:");
                    System.out.println(ee);
                    code = 1;
                }
            /*Block end: Putting data in _weather_data */

            query_st = "";

            for (int i=0;i<40;i++){
            /*Block start: Putting data in -forecast_data */
                String from_ = data2.get("datetime_order").get(Integer.toString(i));
                query_st = "(";
                query_st += "'" + data2.get(from_).get("from_").replace('T', ' ') + "'" ;
                query_st += "," + "'" + data2.get(from_).get("to_").replace('T', ' ') + "'" ;
                query_st += "," + data2.get(from_).get("symbol_number") ;
                query_st += "," + "'" + data2.get(from_).get("symbol_name") + "'";
                query_st += "," + "'" + data2.get(from_).get("symbol_var") + "'";
                query_st += "," + data2.get(from_).get("precipitation_probability") ;
                query_st += "," + "'" +
                 ((data2.get(from_).get("precipitation_unit").equals(""))?
                 (data2.get(data2.get("datetime_order").get(Integer.toString(0))).get("precipitation_unit")):data2.get(from_).get("precipitation_unit")) 
                 + "'";
                query_st += "," +
                 ((data2.get(from_).get("precipitation_value").equals(""))?
                 ("NULL"):data2.get(from_).get("precipitation_value")) ;
                query_st += "," + "'" +
                 ((data2.get(from_).get("precipitation_type").equals(""))?
                 (data2.get(data2.get("datetime_order").get(Integer.toString(0))).get("precipitation_type")):data2.get(from_).get("precipitation_type")) 
                 + "'";
                query_st += "," + data2.get(from_).get("windDirection_deg") ;
                query_st += "," + "'" + data2.get(from_).get("windDirection_code") + "'";
                query_st += "," + "'" + data2.get(from_).get("windDirection_name") + "'";
                query_st += "," + data2.get(from_).get("windSpeed_mps") ;
                query_st += "," + "'" + data2.get(from_).get("windSpeed_unit") + "'";
                query_st += "," + "'" + data2.get(from_).get("windSpeed_name") + "'";
                query_st += "," + data2.get(from_).get("windGust_gust") ;
                query_st += "," + "'" + data2.get(from_).get("windGust_unit") + "'";
                query_st += "," + "'" + data2.get(from_).get("temperature_unit") + "'";
                query_st += "," + data2.get(from_).get("temperature_value") ;
                query_st += "," + data2.get(from_).get("temperature_min") ;
                query_st += "," + data2.get(from_).get("temperature_max") ;
                query_st += "," + data2.get(from_).get("feels_like_value") ;
                query_st += "," + "'" + data2.get(from_).get("feels_like_unit") + "'";
                query_st += "," + "'" + data2.get(from_).get("pressure_unit") + "'";
                query_st += "," + data2.get(from_).get("pressure_value") ;
                query_st += "," + data2.get(from_).get("humidity_value") ;
                query_st += "," + "'" + data2.get(from_).get("humidity_unit") + "'";
                query_st += "," + "'" + data2.get(from_).get("clouds_value") + "'";
                query_st += "," + data2.get(from_).get("clouds_all") ;
                query_st += "," + "'" + data2.get(from_).get("clouds_unit") + "'";
                query_st += "," + data2.get(from_).get("visibility_value") ;
                query_st += ");";
                query_st = query_st.replace(",,", ",NULL,");
                query_st = query_st.replace("''", "NULL");
                try{
                    statement.executeUpdate("insert into "+city_name+"_forecast_data "+forecast_data_prototype_without_datatype+ "values"+query_st);
                }
                catch(Exception ee){
                    System.out.println("Error Occured while inserting into "+city_name+"_forecast_data:");
                    System.out.println(ee);
                    code = 1;
                }
            /*Block end: Putting data in -forecast_data */
            }
            query_st = "";

            /*Block start: Putting data in _forecast_data_extra_info */
                query_st = "(";
                query_st += "'" + data2.get("extra_info").get("location_name") + "'";
                query_st += "," + "'" + data2.get("extra_info").get("location_country") + "'";
                query_st += "," + data2.get("extra_info").get("location_timezone");
                query_st += "," + data2.get("extra_info").get("altitude");
                query_st += "," + data2.get("extra_info").get("latitude");
                query_st += "," + data2.get("extra_info").get("longitude");
                query_st += "," + "'" + data2.get("extra_info").get("geobase") + "'";
                query_st += "," + data2.get("extra_info").get("geobaseid");
                query_st += "," + "'" + data2.get("extra_info").get("meta") + "'";
                query_st += "," + "'" + data2.get("extra_info").get("sun_rise").replace('T', ' ') + "'" ;
                query_st += "," + "'" + data2.get("extra_info").get("sun_set").replace('T', ' ') + "'" ;
                query_st += ");";
                query_st = query_st.replace(",,", ",NULL,");
                query_st = query_st.replace("''", "NULL");
                try{
                    statement.executeUpdate("insert into "+city_name+"_forecast_data_extra_info "+forecast_ext_data_prototype_without_datatype+ "values"+query_st);
                }
                catch(Exception ee){
                    System.out.println("Error Occured while inserting into "+city_name+"_forecast_data_extra_info:");
                    System.out.println(ee);
                    code = 1;
                }
            /*Block end: Putting data in _forecast_data_extra_info */
            
            connection.close(); 
        }
        catch(Exception e){
            System.out.println("Error in update_database():--->");
            System.out.println(e);
            code = 1;
        }
        
        return code;
    }
}

