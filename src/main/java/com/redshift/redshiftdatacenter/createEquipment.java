package com.redshift.redshiftdatacenter;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.Text;

import java.io.IOException;
import java.text.ParseException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class createEquipment extends HttpServlet {
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp)throws IOException {
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		
		String description = req.getParameter("description");
		String status = req.getParameter("status");
		String type = req.getParameter("type");
	
		Key equipmentKey = KeyFactory.createKey("Equipment", "default");
		Entity equipment = new Entity("Equipment", equipmentKey);
		
		equipment.setProperty("Description", description);
		equipment.setProperty("Status", status);
		equipment.setProperty("Type", type);
		
		datastore.put(equipment);

		resp.sendRedirect("/addEquipmentDetails.jsp?key="+KeyFactory.keyToString(equipment.getKey()));
	}
}