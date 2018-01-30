package com.redshift.redshiftdatacenter;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.Text;

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
	
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		Key entityUserKey = KeyFactory.createKey("Entity User", "default");
		Entity entityUser = new Entity("Entity User", entityUserKey);
		
		entityUser.setProperty("Name", name);
		entityUser.setProperty("Parent Entity", entityKey);
		entityUser.setProperty("Role", "Service Techician");
	
		datastore.put(entityUser);
		
		MailService mailService = MailServiceFactory.getMailService();
		MailService.Message message = new MailService.Message();
		message.setSender("techfanhubv2@appspot.gserviceaccount.com");
		message.setSubject("Service Tech Registration");
		message.setTo(req.getParameter("email"));
		message.setHtmlBody("You are receiving this notification because you were setup as a service technician. <a href=\"https://redshift-data-center.appspot.com/Registration/Technician.jsp?key=" + KeyFactory.keyToString(entityUser.getKey())) + "\">Click here to register</a>. When prompted, please sign in using your Google account credentials and accept the default permissions. Thank you!");
		mailService.send(message);

		resp.sendRedirect("/entityAdmin/home.jsp");
	}
}