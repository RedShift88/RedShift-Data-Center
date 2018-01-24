package com.redshift.redshiftdatacenter;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;

import java.io.IOException;
import java.text.ParseException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class createEquipmentType extends HttpServlet {
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp)throws IOException {
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		
		Key equipmentTypeKey = KeyFactory.createKey("Equipment Type", "default");
		Entity equipmentType = new Entity("Equipment Type", equipmentTypeKey);
		
		equipmentType.setProperty("Description", req.getParameter("description"));
		
		Integer propertyNumber = 1;
		String parameterToCheck = "propertyDescription" + propertyNumber;
		while(req.getParameterMap().containsKey(parameterToCheck)){
			equipmentType.setUnindexedProperty("Property " + propertyNumber + " Description", req.getParameter("propertyDescription"+propertyNumber));
			equipmentType.setUnindexedProperty("Property " + propertyNumber + " Type", req.getParameter("propertyType"+propertyNumber));
			equipmentType.setUnindexedProperty("Property " + propertyNumber + " Options", req.getParameter("propertyOptions"+propertyNumber));
			equipmentType.setUnindexedProperty("Property " + propertyNumber + " Tracking", req.getParameter("propertyTracking"+propertyNumber).equals("true"));
			propertyNumber += 1;
			parameterToCheck = "propertyDescription" + propertyNumber;
		}
		
		datastore.put(equipmentType);

		resp.sendRedirect("/");
	}
}