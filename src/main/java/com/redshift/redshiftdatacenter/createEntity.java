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

public class createEntity extends HttpServlet {
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp)throws IOException {
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		
		String name = req.getParameter("name");
		Text notes = new Text(req.getParameter("notes"));
	
		Key entityKey = KeyFactory.createKey("Entity", "default");
		Entity entity = new Entity("Entity", entityKey);
		
		entity.setProperty("Name", name);
		entity.setUnindexedProperty("Notes", notes);
	
		datastore.put(entity);

		resp.sendRedirect("/entityAdmin/createEntityAdmin.jsp?key="+KeyFactory.keyToString(entity.getKey()));
	}
}