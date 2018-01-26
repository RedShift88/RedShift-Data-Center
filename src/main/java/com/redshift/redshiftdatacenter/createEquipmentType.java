package com.redshift.redshiftdatacenter;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.datastore.Query.Filter;
import com.google.appengine.api.datastore.Query.FilterPredicate;
import com.google.appengine.api.datastore.EntityNotFoundException;

import java.io.IOException;
import java.text.ParseException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class createEquipmentType extends HttpServlet {
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
					Key equipmentTypeKey = KeyFactory.createKey("Equipment Type", (String) entity.getProperty("Name"));
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

					resp.sendRedirect("/entityAdmin/home.jsp");
				}catch(EntityNotFoundException e){
					e.printStackTrace();
				}
			}
		}
	}
}