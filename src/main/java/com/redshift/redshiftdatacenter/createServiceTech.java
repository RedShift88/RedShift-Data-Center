package com.redshift.redshiftdatacenter;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.Text;
import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.datastore.Query.Filter;
import com.google.appengine.api.datastore.Query.FilterPredicate;
import com.google.appengine.api.datastore.EntityNotFoundException;

import com.google.appengine.api.mail.MailServiceFactory;
import com.google.appengine.api.mail.MailService;
import com.google.appengine.api.mail.MailService.Message;

import java.io.IOException;
import java.text.ParseException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class createServiceTech extends HttpServlet {
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp)throws IOException {
		String name = req.getParameter("name");
		Text notes = new Text(req.getParameter("notes"));
		String emailAddress = req.getParameter("email");
	
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		if(user != null){
			Key entityUserKey = KeyFactory.createKey("Entity User", "default");
			Filter userIDFilter = new FilterPredicate("User", Query.FilterOperator.EQUAL, user.getUserId());
			Query userQuery = new Query("Entity User", entityUserKey).setFilter(userIDFilter);
			Entity loggedUser = datastore.prepare(userQuery).asSingleEntity();
			if (loggedUser != null) {
				try{
					Key entityKey = (Key) loggedUser.getProperty("Parent Entity");
					Entity entity = datastore.get(entityKey);
					Entity entityUser = new Entity("Entity User", entityUserKey);
					
					entityUser.setProperty("Name", name);
					entityUser.setProperty("Parent Entity", entityKey);
					entityUser.setProperty("Role", "Service Technician");
					entityUser.setUnindexedProperty("Email", emailAddress);
				
					datastore.put(entityUser);
					
					MailService mailService = MailServiceFactory.getMailService();
					MailService.Message message = new MailService.Message();
					message.setSender("redshiftrc@gmail.com");
					message.setSubject("Service Tech Registration");
					message.setTo(emailAddress);
					message.setHtmlBody("You are receiving this notification because you were setup as a service technician for " + (String) entity.getProperty("Name") + ". When prompted, please sign in using your Google account credentials and grant the application the required permissions. <a href=\"https://redshift-data-center.appspot.com/registration/technician.jsp?key=" + KeyFactory.keyToString(entityUser.getKey()) + "\">Click here to complete the registration process</a>. Thank you!");
					mailService.send(message);

					resp.sendRedirect("/entityAdmin/home.jsp");
				}catch(EntityNotFoundException e){
					e.printStackTrace();
				}
			}
		}
	}
}