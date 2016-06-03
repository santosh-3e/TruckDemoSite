package com.thirdeye.dao;

import com.thirdeye.vo.Coordinate;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.hbase.HBaseConfiguration;
import org.apache.hadoop.hbase.client.HTable;
import org.apache.hadoop.hbase.client.Result;
import org.apache.hadoop.hbase.client.ResultScanner;
import org.apache.hadoop.hbase.client.Scan;
import org.apache.hadoop.hbase.util.Bytes;

//@todo change to Spring Component (spring-hadoop)
//@Component("hbasedao")
public class PopulateUIFromHBase {
	// TABLES
	private static final String EVENTS_TABLE_NAME = "truck_events1";

	// CF
	private static final byte[] CF_TRUCK1 = Bytes.toBytes("truck1");
	static final byte[] CF_TRUCK2 = Bytes.toBytes("truck2");
	static final byte[] CF_TRUCK3 = Bytes.toBytes("truck3");
	static final byte[] CF_TRUCK4 = Bytes.toBytes("truck4");

	private static final byte[] COL_DRIVER_ID = Bytes.toBytes("d");
	private static final byte[] COL_TRUCK_ID = Bytes.toBytes("t");
	private static final byte[] COL_EVENT_TIME = Bytes.toBytes("tim");
	private static final byte[] COL_EVENT_TYPE = Bytes.toBytes("e");
	private static final byte[] COL_LATITUDE = Bytes.toBytes("la");
	private static final byte[] COL_LONGITUDE = Bytes.toBytes("lo");
	private static final byte[] COL_CO2 = Bytes.toBytes("co2");
	private static final byte[] COL_O = Bytes.toBytes("o");
	private static final byte[] COL_MOISTURE = Bytes.toBytes("moi");
	private static final byte[] COL_PRESSURE = Bytes.toBytes("pres");
	private static final byte[] COL_ETHYLENE = Bytes.toBytes("ethl");
	private static final byte[] COL_TEMP = Bytes.toBytes("temp");
	private static final byte[] COL_LOCATION = Bytes.toBytes("location");
	static final byte[] COL_SCORELABEL = Bytes.toBytes("scorelabel");

	//
	private static final Map<String, String> driverInfo = new HashMap<String, String>();
	private static final Map<String, String> currDriverRouteId = new HashMap<String, String>();
	private static final Map<String, String> routeIdInfo = new HashMap<String, String>();
	
	static List<com.thirdeye.vo.Coordinate> results = new ArrayList<Coordinate>();
	
	static List co2_truck = new ArrayList();
	static List oxygen_truck = new ArrayList();
	static List ethylene_truck = new ArrayList();
	static List moisture_truck = new ArrayList();
	static List pressure_truck = new ArrayList();
	static List temp_truck = new ArrayList();
	
	static List co2_truck1 = new ArrayList();
	static List oxygen_truck1 = new ArrayList();
	static List ethylene_truck1 = new ArrayList();
	static List moisture_truck1 = new ArrayList();
	static List pressure_truck1 = new ArrayList();
	static List temp_truck1 = new ArrayList();
	
	static List co2_truck2 = new ArrayList();
	static List oxygen_truck2 = new ArrayList();
	static List ethylene_truck2 = new ArrayList();
	static List moisture_truck2 = new ArrayList();
	static List pressure_truck2 = new ArrayList();
	static List temp_truck2 = new ArrayList();
	
	static List co2_truck3 = new ArrayList();
	static List oxygen_truck3 = new ArrayList();
	static List ethylene_truck3 = new ArrayList();
	static List moisture_truck3 = new ArrayList();
	static List pressure_truck3 = new ArrayList();
	static List temp_truck3 = new ArrayList();
	static {
		driverInfo.put("1", "Patty M");
		driverInfo.put("2", "Mark D");
		driverInfo.put("3", "Scott J");
		driverInfo.put("4", "Andrews P");

		currDriverRouteId.put("1", "001");
		currDriverRouteId.put("2", "002");
		currDriverRouteId.put("3", "003");
		currDriverRouteId.put("4", "004");

		routeIdInfo.put("001", "i-5");
		routeIdInfo.put("002", "i-78");
		routeIdInfo.put("003", "i-90");
		routeIdInfo.put("004", "i-99");

	}

	// returns the last n coordinates from HBase table.
	public List<Coordinate> getCoordinates(int batchSize) throws IOException {
		 List sendResults = new ArrayList(4);
		Coordinate truck_lists = new Coordinate();
		Coordinate truck_lists_1 = new Coordinate();
		Coordinate truck_lists_2 = new Coordinate();
		Coordinate truck_lists_3 = new Coordinate();
		HTable eventsTbl = null;
		ResultScanner scanner = null;
		
		

		// SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		// result.clear();
System.out.println("batchsize: "+batchSize);
		try {
			if (batchSize == 1) {
				Configuration conf = HBaseConfiguration.create();
				// conf.addResource(new URL("http://localhost:60010/conf"));

				eventsTbl = new HTable(conf, EVENTS_TABLE_NAME);
				
				//current date
				java.util.Date currentDate = new java.util.Date();
		        long currenttimeInMillis = currentDate.getTime();
		        System.out.println(currenttimeInMillis);

				//Scan scan = new Scan().setTimeRange(currenttimeInMillis-3600000, currenttimeInMillis+1);
		        Scan scan = new Scan();
				scanner = eventsTbl.getScanner(scan);
								

				for (Result r = scanner.next(); r != null; r = scanner.next()) {
					
					String driverId = Bytes.toString(
							r.getValue(CF_TRUCK1, COL_DRIVER_ID)).trim();
					String truckId = Bytes.toString(
							r.getValue(CF_TRUCK1, COL_TRUCK_ID)).trim();
					// String eventType = Bytes.toString(r.getValue(CF_TRUCK1,
					// COL_EVENT_TYPE)).trim();
					long eventTime = Bytes.toLong(r.getValue(CF_TRUCK1,
							COL_EVENT_TIME));
					String latitude = Bytes.toString(
							r.getValue(CF_TRUCK1, COL_LATITUDE)).trim();
					String longitude = Bytes.toString(
							r.getValue(CF_TRUCK1, COL_LONGITUDE)).trim();
					String co2 = Bytes.toString(r.getValue(CF_TRUCK1, COL_CO2))
							.trim();
					String oxy = Bytes.toString(r.getValue(CF_TRUCK1, COL_O))
							.trim();
					String moisture = Bytes.toString(
							r.getValue(CF_TRUCK1, COL_MOISTURE)).trim();
					String pressure = Bytes.toString(
							r.getValue(CF_TRUCK1, COL_PRESSURE)).trim();
					String ethylene = Bytes.toString(
							r.getValue(CF_TRUCK1, COL_ETHYLENE)).trim();
					String temp1 = Bytes.toString(
							r.getValue(CF_TRUCK1, COL_TEMP)).trim();
					String loc1 = Bytes.toString(
							r.getValue(CF_TRUCK1, COL_LOCATION)).trim();
					String score1 = Bytes.toString(
							r.getValue(CF_TRUCK1, COL_SCORELABEL)).trim();
					System.out.println("===location is==="+loc1);
					System.out.println("**********************"+driverId+"***********************");
					System.out.println("**********************"+truckId+"***********************");
					System.out.println("**********************"+co2+"***********************");
					System.out.println("**********************"+oxy+"***********************");
					System.out.println("**********************"+temp1+"***********************");
					System.out.println("**********************"+ethylene+"***********************");
					String driverId1 = Bytes.toString(
							r.getValue(CF_TRUCK2, COL_DRIVER_ID)).trim();
					String truckId1 = Bytes.toString(
							r.getValue(CF_TRUCK2, COL_TRUCK_ID)).trim();
					// String eventType1 = Bytes.toString(r.getValue(CF_TRUCK2,
					// COL_EVENT_TYPE)).trim();
					long eventTime1 = Bytes.toLong(r.getValue(CF_TRUCK2,
							COL_EVENT_TIME));
					String latitude1 = Bytes.toString(
							r.getValue(CF_TRUCK2, COL_LATITUDE)).trim();
					String longitude1 = Bytes.toString(
							r.getValue(CF_TRUCK2, COL_LONGITUDE)).trim();
					String co2_1 = Bytes.toString(
							r.getValue(CF_TRUCK2, COL_CO2)).trim();
					String oxy1 = Bytes.toString(r.getValue(CF_TRUCK2, COL_O))
							.trim();
					String moisture1 = Bytes.toString(
							r.getValue(CF_TRUCK2, COL_MOISTURE)).trim();
					String pressure1 = Bytes.toString(
							r.getValue(CF_TRUCK2, COL_PRESSURE)).trim();
					String ethylene1 = Bytes.toString(
							r.getValue(CF_TRUCK2, COL_ETHYLENE)).trim();
					String temp2 = Bytes.toString(
							r.getValue(CF_TRUCK2, COL_TEMP)).trim();
					String loc2 = Bytes.toString(
							r.getValue(CF_TRUCK2, COL_LOCATION)).trim();
					String score2 = Bytes.toString(
							r.getValue(CF_TRUCK2, COL_SCORELABEL)).trim();

					String driverId2 = Bytes.toString(
							r.getValue(CF_TRUCK3, COL_DRIVER_ID)).trim();
					String truckId2 = Bytes.toString(
							r.getValue(CF_TRUCK3, COL_TRUCK_ID)).trim();
					// String eventType2 = Bytes.toString(r.getValue(CF_TRUCK3,
					// COL_EVENT_TYPE)).trim();
					long eventTime2 = Bytes.toLong(r.getValue(CF_TRUCK3,
							COL_EVENT_TIME));
					String latitude2 = Bytes.toString(
							r.getValue(CF_TRUCK3, COL_LATITUDE)).trim();
					String longitude2 = Bytes.toString(
							r.getValue(CF_TRUCK3, COL_LONGITUDE)).trim();
					String co2_2 = Bytes.toString(
							r.getValue(CF_TRUCK3, COL_CO2)).trim();
					String oxy2 = Bytes.toString(r.getValue(CF_TRUCK3, COL_O))
							.trim();
					String moisture2 = Bytes.toString(
							r.getValue(CF_TRUCK3, COL_MOISTURE)).trim();
					String pressure2 = Bytes.toString(
							r.getValue(CF_TRUCK3, COL_PRESSURE)).trim();
					String ethylene2 = Bytes.toString(
							r.getValue(CF_TRUCK3, COL_ETHYLENE)).trim();
					String temp3 = Bytes.toString(
							r.getValue(CF_TRUCK3, COL_TEMP)).trim();
					String loc3 = Bytes.toString(
							r.getValue(CF_TRUCK3, COL_LOCATION)).trim();
					String score3 = Bytes.toString(
							r.getValue(CF_TRUCK3, COL_SCORELABEL)).trim();

					String driverId3 = Bytes.toString(
							r.getValue(CF_TRUCK4, COL_DRIVER_ID)).trim();
					String truckId3 = Bytes.toString(
							r.getValue(CF_TRUCK4, COL_TRUCK_ID)).trim();
					// String eventType3 = Bytes.toString(r.getValue(CF_TRUCK4,
					// COL_EVENT_TYPE)).trim();
					long eventTime3 = Bytes.toLong(r.getValue(CF_TRUCK4,
							COL_EVENT_TIME));
					String latitude3 = Bytes.toString(
							r.getValue(CF_TRUCK4, COL_LATITUDE)).trim();
					String longitude3 = Bytes.toString(
							r.getValue(CF_TRUCK4, COL_LONGITUDE)).trim();
					String co2_3 = Bytes.toString(
							r.getValue(CF_TRUCK4, COL_CO2)).trim();
					String oxy3 = Bytes.toString(r.getValue(CF_TRUCK4, COL_O))
							.trim();
					String moisture3 = Bytes.toString(
							r.getValue(CF_TRUCK4, COL_MOISTURE)).trim();
					String pressure3 = Bytes.toString(
							r.getValue(CF_TRUCK4, COL_PRESSURE)).trim();
					String ethylene3 = Bytes.toString(
							r.getValue(CF_TRUCK4, COL_ETHYLENE)).trim();
					String temp4 = Bytes.toString(
							r.getValue(CF_TRUCK4, COL_TEMP)).trim();
					String loc4 = Bytes.toString(
							r.getValue(CF_TRUCK4, COL_LOCATION)).trim();
					String score4 = Bytes.toString(
							r.getValue(CF_TRUCK4, COL_SCORELABEL)).trim();

					Coordinate c = new Coordinate();
					Coordinate c1 = new Coordinate();
					Coordinate c2 = new Coordinate();
					Coordinate c3 = new Coordinate();
					
					c.setDriver_id(driverId);
					c.setDriver_name(driverInfo.get(driverId));
					c.setLatitude(latitude);
					c.setLongitude(longitude);
					c.setRoute_id(currDriverRouteId.get(driverId));
					c.setRoute_name(routeIdInfo.get(c.getRoute_id()));
					c.setTimestamp((new java.util.Date(eventTime)).toString());
					c.setTruck_id(truckId);
					c.setCo2(co2);
					c.setOxygen(oxy);
					c.setMoisture(moisture);
					c.setPressure(pressure);
					c.setEthylene(ethylene);
					c.setTemp(temp1);
					c.setLocation(loc1);
					c.setScoreLabel(score1);
					
					
					co2_truck.add(c.getCo2());
					oxygen_truck.add(c.getOxygen());
					moisture_truck.add(c.getMoisture());
					pressure_truck.add(c.getPressure());
					ethylene_truck.add(c.getEthylene());
					temp_truck.add(c.getTemp());

					results.add(c);

					

					c1.setDriver_id(driverId1);
					c1.setDriver_name(driverInfo.get(driverId1));
					c1.setLatitude(latitude1);
					c1.setLongitude(longitude1);
					c1.setRoute_id(currDriverRouteId.get(driverId1));
					c1.setRoute_name(routeIdInfo.get(c1.getRoute_id()));
					c1.setTimestamp((new java.util.Date(eventTime1)).toString());
					c1.setTruck_id(truckId1);
					c1.setCo2(co2_1);
					c1.setOxygen(oxy1);
					c1.setMoisture(moisture1);
					c1.setPressure(pressure1);
					c1.setEthylene(ethylene1);
					c1.setTemp(temp2);
					c1.setLocation(loc2);
					c1.setScoreLabel(score2);
					
					co2_truck1.add(c1.getCo2());
					oxygen_truck1.add(c1.getOxygen());
					moisture_truck1.add(c1.getMoisture());
					pressure_truck1.add(c1.getPressure());
					ethylene_truck1.add(c1.getEthylene());
					temp_truck1.add(c1.getTemp());
					
					results.add(c1);

					//Coordinate c2 = new Coordinate();
					c2.setDriver_id(driverId2);
					c2.setDriver_name(driverInfo.get(driverId2));
					c2.setLatitude(latitude2);
					c2.setLongitude(longitude2);
					c2.setRoute_id(currDriverRouteId.get(driverId2));
					c2.setRoute_name(routeIdInfo.get(c2.getRoute_id()));
					c2.setTimestamp((new java.util.Date(eventTime2)).toString());
					c2.setTruck_id(truckId2);
					c2.setCo2(co2_2);
					c2.setOxygen(oxy2);
					c2.setMoisture(moisture2);
					c2.setPressure(pressure2);
					c2.setEthylene(ethylene2);
					c2.setTemp(temp3);
					c2.setLocation(loc3);
					c2.setScoreLabel(score3);
					
					co2_truck2.add(c2.getCo2());
					oxygen_truck2.add(c2.getOxygen());
					moisture_truck2.add(c2.getMoisture());
					pressure_truck2.add(c2.getPressure());
					ethylene_truck2.add(c2.getEthylene());
					temp_truck2.add(c2.getTemp());
					
					results.add(c2);

					//Coordinate c3 = new Coordinate();
					c3.setDriver_id(driverId3);
					c3.setDriver_name(driverInfo.get(driverId3));
					c3.setLatitude(latitude3);
					c3.setLongitude(longitude3);
					c3.setRoute_id(currDriverRouteId.get(driverId3));
					c3.setRoute_name(routeIdInfo.get(c3.getRoute_id()));
					c3.setTimestamp((new java.util.Date(eventTime3)).toString());
					c3.setTruck_id(truckId3);
					c3.setCo2(co2_3);
					c3.setOxygen(oxy3);
					c3.setMoisture(moisture3);
					c3.setPressure(pressure3);
					c3.setEthylene(ethylene3);
					c3.setTemp(temp4);
					c3.setLocation(loc4);
					c3.setScoreLabel(score4);
					
					co2_truck3.add(c3.getCo2());
					oxygen_truck3.add(c3.getOxygen());
					moisture_truck3.add(c3.getMoisture());
					pressure_truck3.add(c3.getPressure());
					ethylene_truck3.add(c3.getEthylene());
					temp_truck3.add(c3.getTemp());
						
					results.add(c3);

				}
			}
				
			boolean duplicate = false;
			System.out.println("-------result------" + results.size());
			for (int i = (batchSize - 1) * 4; i < batchSize * 4; i++) {
				/*duplicate = false;
				System.out.println("-------sendResult------"
						+ sendResults.size());
				if (sendResults.size() != 0) {

					for (int j = 0; j < sendResults.size(); j++) {
						if (((Coordinate) sendResults.get(j)).getDriver_id()
								.equals(results.get(i).getDriver_id())) {
							duplicate = true;
							sendResults.set(j, results.get(i));
							break;
						}

					}
					if (duplicate == false) {
						sendResults.add(results.get(i));
					}

				} else*/
					sendResults.add(results.get(i));
			}
			
			System.out.println("----sendResultfinal----" + sendResults.size());
			List<Coordinate> finalSendResult = new ArrayList();
			
			truck_lists = (Coordinate) sendResults.get(0);
			
			truck_lists.setCo2List(co2_truck);
			truck_lists.setOxygenList(oxygen_truck);
			truck_lists.setEthyleneList(ethylene_truck);
			truck_lists.setMoistureList(moisture_truck);
			truck_lists.setPressureList(pressure_truck);
			truck_lists.setTempList(temp_truck);
			//Coordinate truck_lists_1 = new Coordinate();  //truck - 2 all lists
			
			truck_lists_1 = (Coordinate) sendResults.get(1);
			
			
			truck_lists_1.setCo2List(co2_truck1);
			truck_lists_1.setOxygenList(oxygen_truck1);
			truck_lists_1.setEthyleneList(ethylene_truck1);
			truck_lists_1.setMoistureList(moisture_truck1);
			truck_lists_1.setPressureList(pressure_truck1);
			truck_lists_1.setTempList(temp_truck1);
			
			//Coordinate truck_lists_2 = new Coordinate();  //truck - 3 all lists
			
			truck_lists_2 = (Coordinate) sendResults.get(2);
			
			truck_lists_2.setCo2List(co2_truck2);
			truck_lists_2.setOxygenList(oxygen_truck2);
			truck_lists_2.setEthyleneList(ethylene_truck2);
			truck_lists_2.setMoistureList(moisture_truck2);
			truck_lists_2.setPressureList(pressure_truck2);
			truck_lists_2.setTempList(temp_truck2);
			
			//Coordinate truck_lists_3 = new Coordinate();  //truck - 4 all lists
			
			truck_lists_3 = (Coordinate) sendResults.get(3);
			
			truck_lists_3.setCo2List(co2_truck3);
			truck_lists_3.setOxygenList(oxygen_truck3);
			truck_lists_3.setEthyleneList(ethylene_truck3);
			truck_lists_3.setMoistureList(moisture_truck3);
			truck_lists_3.setPressureList(pressure_truck3);
			truck_lists_3.setTempList(temp_truck3);
			
			finalSendResult.add(truck_lists);
			finalSendResult.add(truck_lists_1);
			finalSendResult.add(truck_lists_2);
			finalSendResult.add(truck_lists_3);
			
			
			
			return finalSendResult;

		} finally {
			if (scanner != null) {
				scanner.close();
			}

			if (eventsTbl != null) {
				eventsTbl.close();
			}
		}

	}

	public static void main(String str[]) throws IOException {
		(new PopulateUIFromHBase()).getCoordinates(10);
	}

}
