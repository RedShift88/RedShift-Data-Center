package com.redshift.redshiftdatacenter;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import com.google.appengine.api.datastore.EntityNotFoundException;

import java.io.IOException;
import java.text.ParseException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class createEntityAdmin extends HttpServlet {
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp)throws IOException {
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		try {
			Key entityKey = KeyFactory.stringToKey(req.getParameter("entityKey"));
			Entity entity = datastore.get(entityKey);
			String entityName = (String) entity.getProperty("Name");
			String adminName = req.getParameter("name");
			
			UserService userService = UserServiceFactory.getUserService();
			User user = userService.getCurrentUser();
		
			Key entityUserKey = KeyFactory.createKey("Entity User", "default");
			Entity entityUser = new Entity("Entity User", entityUserKey);
			
			entityUser.setProperty("Name", adminName);
			entityUser.setProperty("Entity Name", entityName);
			entityUser.setProperty("User", user.getUserId());
			entityUser.setProperty("Role", "Admin");
		
			datastore.put(entityAdmin);

			resp.sendRedirect("/entityAdmin/adminHome.jsp");
		}catch(EntityNotFoundException e){
			e.printStackTrace();
		}
	}
}