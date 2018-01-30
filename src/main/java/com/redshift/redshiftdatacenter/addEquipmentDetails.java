package com.redshift.redshiftdatacenter;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.Email;
import com.google.appengine.api.datastore.Text;
import com.google.appengine.api.datastore.PhoneNumber;
import com.google.appengine.api.datastore.EntityNotFoundException;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class addEquipmentDetails extends HttpServlet {
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp)throws IOException {
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		try {
			Key equipmentKey = KeyFactory.stringToKey(req.getParameter("equipmentKey"));
			Entity equipment = datastore.get(equipmentKey);
			
			Key typeKey = (Key) equipment.getProperty("Type");
			Entity equipmentType = datastore.get(typeKey);
			
			Integer propertyNumber = 1;
			String parameterToCheck = "propertyNumber" + propertyNumber;
			String propertyType = "";
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			while(req.getParameterMap().containsKey(parameterToCheck)){
				if((Boolean) equipmentType.hasProperty("Property " + propertyNumber + " Type")){
					propertyType = (String) equipmentType.getProperty("Property " + propertyNumber + " Type");
					switch(propertyType){
						case "Short Text":
							if(!req.getParameter("propertyNumber"+propertyNumber).isEmpty()){
								equipment.setUnindexedProperty("Property " + propertyNumber, req.getParameter("propertyNumber"+propertyNumber));
							}else{
								equipment.setUnindexedProperty("Property " + propertyNumber, null);
							}
							break;
						case "Long Text":
							if(!req.getParameter("propertyNumber"+propertyNumber).isEmpty()){
								equipment.setUnindexedProperty("Property " + propertyNumber, new Text(req.getParameter("propertyNumber"+propertyNumber)));
							}else{
								equipment.setUnindexedProperty("Property " + propertyNumber, null);
							}
							break;
						case "Drop Down":
							if(!req.getParameter("propertyNumber"+propertyNumber).isEmpty()){
								equipment.setUnindexedProperty("Property " + propertyNumber, req.getParameter("propertyNumber"+propertyNumber));
							}else{
								equipment.setUnindexedProperty("Property " + propertyNumber, null);
							}
							break;
						case "Integer":
							if(!req.getParameter("propertyNumber"+propertyNumber).isEmpty()){
								equipment.setUnindexedProperty("Property " + propertyNumber, Integer.parseInt(req.getParameter("propertyNumber"+propertyNumber)));
							}else{
								equipment.setUnindexedProperty("Property " + propertyNumber, null);
							}
							break;
						case "Double":
							if(!req.getParameter("propertyNumber"+propertyNumber).isEmpty()){
								equipment.setUnindexedProperty("Property " + propertyNumber, Double.valueOf(req.getParameter("propertyNumber"+propertyNumber)));
							}else{
								equipment.setUnindexedProperty("Property " + propertyNumber, null);
							}
							break;
						case "True/False":
							if(!req.getParameter("propertyNumber"+propertyNumber).isEmpty()){
								equipment.setUnindexedProperty("Property " + propertyNumber, Boolean.parseBoolean(req.getParameter("propertyNumber"+propertyNumber)));
							}else{
								equipment.setUnindexedProperty("Property " + propertyNumber, null);
							}
							break;
						case "Date":
							if(!req.getParameter("propertyNumber"+propertyNumber).isEmpty()){
								try{
									equipment.setUnindexedProperty("Property " + propertyNumber, formatter.parse(req.getParameter("propertyNumber"+propertyNumber)));
								}catch (ParseException e){
									e.printStackTrace();
								}
							}else{
								equipment.setUnindexedProperty("Property " + propertyNumber, null);
							}
							break;
						case "Date Time":
							if(!req.getParameter("propertyNumber"+propertyNumber).isEmpty()){
								try{
									equipment.setUnindexedProperty("Property " + propertyNumber, formatter.parse(req.getParameter("propertyNumber"+propertyNumber)));
								}catch (ParseException e){
									e.printStackTrace();
								}
							}else{
								equipment.setUnindexedProperty("Property " + propertyNumber, null);
							}
							break;
						case "Duration":
							if(!req.getParameter("propertyNumber"+propertyNumber).isEmpty()){
								equipment.setUnindexedProperty("Property " + propertyNumber, "Every " + req.getParameter("propertyNumber"+propertyNumber) + " " + req.getParameter("propertyNumber"+propertyNumber+"Options"));
							}else{
								equipment.setUnindexedProperty("Property " + propertyNumber, null);
							}
							break;
						default:
							if(!req.getParameter("propertyNumber"+propertyNumber).isEmpty()){
								equipment.setUnindexedProperty("Property " + propertyNumber, req.getParameter("propertyNumber"+propertyNumber));
							}else{
								equipment.setUnindexedProperty("Property " + propertyNumber, null);
							}
					}
				}
				propertyNumber += 1;
				parameterToCheck = "propertyNumber" + propertyNumber;
			}
			
			datastore.put(equipment);

			resp.sendRedirect("/viewEquipmentDetails.jsp?key="+req.getParameter("equipmentKey"));
		}catch(EntityNotFoundException e){
			e.printStackTrace();
		}
	}
}