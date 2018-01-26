package com.redshift.redshiftdatacenter;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
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

public class createEntityAdmin extends HttpServlet {
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp)throws IOException {
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		Key entityKey = KeyFactory.stringToKey(req.getParameter("entityKey"));
		String adminName = req.getParameter("name");
		
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
	
		Key entityUserKey = KeyFactory.createKey("Entity User", "default");
		Entity entityUser = new Entity("Entity User", entityUserKey);
		
		entityUser.setProperty("Name", adminName);
		entityUser.setProperty("Parent Entity", entityKey);
		entityUser.setProperty("User", user.getUserId());
		entityUser.setProperty("Role", "Admin");
	
		datastore.put(entityUser);

		resp.sendRedirect("/entityAdmin/adminHome.jsp");
	}
}