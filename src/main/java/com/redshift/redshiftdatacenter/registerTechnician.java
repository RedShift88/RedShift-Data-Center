package com.redshift.redshiftdatacenter;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.EntityNotFoundException;

import java.io.IOException;
import java.text.ParseException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class registerTechnician extends HttpServlet {
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp)throws IOException {
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		try {
			Key entityUserKey = KeyFactory.stringToKey(req.getParameter("userKey"));
			Entity entityUser = datastore.get(entityUserKey);
			
			String emailAddress = (String) entityUser.getProperty("Email");
			emailAddress = emailAddress.toLowerCase();
			if(emailAddress.equals(user.getEmail().toLowerCase())){
				entityUser.setProperty("User", user.getUserId());
				entityUser.removeProperty("Email");
		
				datastore.put(entityUser);

				resp.sendRedirect("/home.jsp");
			}else{
				resp.sendRedirect("/errors/registrationError.jsp?code=50");
			}
		}catch(EntityNotFoundException e){
			e.printStackTrace();
		}
	}
}