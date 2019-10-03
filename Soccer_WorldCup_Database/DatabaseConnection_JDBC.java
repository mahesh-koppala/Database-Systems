package db_assignment1;

import java.io.*;
import java.sql.*;
import java.sql.Statement;

import oracle.jdbc.driver.*;;
public class DatabaseConnection{
			        static final String URL = "jdbc:oracle:thin:@localhost:1521:orcl";
			        public static void main(String args[]) throws SQLException, FileNotFoundException, IOException {
			        	System.out.println(args[0]);
			            String fname = args[0];
			          String string;
			          int i = 0;
			          String world_cup[] = null;
			          BufferedReader br = null;
			          Connection connector = null;
			          try{
			             File file = new File("C:/Users/Mahesh Koppala/Desktop/courses/DB1/project 1/Input_Data/"+fname);
			            br = new BufferedReader(new FileReader(file)); 
			            if(fname.contains(".csv")) {
			        		fname = fname.split("\\.")[0];
			        	}
			            String insertQuery = "INSERT INTO " + fname.toUpperCase() + " Values(";
			            Driver myDriver = new OracleDriver();
			            DriverManager.registerDriver(myDriver);
			            connector = DriverManager.getConnection(URL, "mah", "qwertyu");
			            Statement statement = connector.createStatement();
			            if(fname.equals("Player_Assists_Goals")) {
			              while ((string = br.readLine())!=null && !string.contains("Player_")){
			                world_cup = string.split(",");
			                i += statement.executeUpdate(insertQuery+world_cup[0]+","+world_cup[1]+","+world_cup[2]+","+world_cup[3]+","+world_cup[4]+")");
			              }
			            }else if(fname.equals("Player_Cards")) {
			              while ((string = br.readLine())!=null && !string.contains("Player_")){
			                world_cup = string.split(",");
			                i += statement.executeUpdate(insertQuery+world_cup[0]+","+world_cup[1]+","+world_cup[2]+")");
			              }
			            }else if(fname.equals("Players")) {
			              while ((string = br.readLine())!=null && !string.contains("Player_")){
			                world_cup = string.split(",");
			                System.out.println(insertQuery+world_cup[0]+","+world_cup[1]+","+world_cup[2]+","+world_cup[3]+",to_date("+world_cup[4]+",'yyyy-mm-dd'),"+world_cup[5]+","+world_cup[6]+","+world_cup[7]+","+world_cup[8]+","+world_cup[9]+","+"'"+world_cup[10]+"'"+")");
			                i += statement.executeUpdate(insertQuery+world_cup[0]+","+world_cup[1]+","+world_cup[2]+","+world_cup[3]+",to_date("+world_cup[4]+",'yyyy-mm-dd'),"+world_cup[5]+","+world_cup[6]+","+world_cup[7]+","+world_cup[8]+","+world_cup[9]+","+"'"+world_cup[10]+"'"+")");
			              }
			            }else if(fname.equals("Match_results")) {
			              while ((string = br.readLine())!=null && !string.contains("Player_")){
			                world_cup = string.split(",");
			                System.out.println(string);
			                System.out.println(insertQuery+world_cup[0]+",to_date("+world_cup[1]+",'yyyy-mm-dd'),to_timestamp("+world_cup[2]+",'HH24:MI:SS'),"+world_cup[3]+","+world_cup[4]+","+world_cup[5]+","+world_cup[6]+","+world_cup[7]+","+world_cup[8]+")");
			                i += statement.executeUpdate(insertQuery+world_cup[0]+",to_date("+world_cup[1]+",'yyyy-mm-dd'),to_timestamp("+world_cup[2]+",'HH24:MI:SS'),"+world_cup[3]+","+world_cup[4]+","+world_cup[5]+","+world_cup[6]+","+world_cup[7]+","+world_cup[8]+")");
			              }
			            }else if(fname.equals("Country")) {
			              while ((string = br.readLine())!=null && !string.contains("Player_")){
			                world_cup = string.split(",");
			                i += statement.executeUpdate(insertQuery+world_cup[0]+","+world_cup[1]+","+world_cup[2]+","+world_cup[3]+")");
			              }
			            }else {
			              System.out.println("Enter valid file name");
			            }
			            if(i>0) {
			              System.out.println("Inserted Rows : "+i);
			            }
			          }finally {
			            if(connector!=null && br!= null) {
			              connector.close();
			              br.close();
			            }
			          }
			
			        }

}
