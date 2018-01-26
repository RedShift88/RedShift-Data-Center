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

import java.io.IOException;
import java.text.ParseException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class createEquipment extends HttpServlet {
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp)throws IOException {
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		if(user != null){
			Key entityUserKey = KeyFactory.createKey("Entity User", "default");
			Filter userIDFilter = new FilterPredicate("User", Query.FilterOperator.EQUAL, user.getUserId());
			Query userQuery = new Query("Entity User", entityUserKey).setFilter(userIDFilter);
			Entity loggedUser = datastore.prepare(userQuery).asSingleEntity();
			if (loggedUser != null) {
				Key entityKey = (Key) loggedUser.getProperty("Parent Entity");
				try{
					Entity entity = datastore.get(entityKey);
					Key equipmentKey = KeyFactory.createKey("Equipment", (String) entity.getProperty("Name"));
					Entity equipment = new Entity("Equipment", equipmentKey);
					
					String description = req.getParameter("description");
					String status = req.getParameter("status");
					Key typeKey = KeyFactory.stringToKey((String) req.getParameter("type"));
					
					equipment.setProperty("Description", description);
					equipment.setProperty("Status", status);
					equipment.setUnindexedProperty("Type", typeKey);
					
					datastore.put(equipment);

					resp.sendRedirect("/addEquipmentDetails.jsp?key="+KeyFactory.keyToString(equipment.getKey()));
				}catch(EntityNotFoundException e){
					e.printStackTrace();
				}
			}
		}
	}
}