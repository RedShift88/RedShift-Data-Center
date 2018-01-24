function addPropertyItem(itemNumber){
	var form = document.getElementById("equipmentTypeForm");
	var addButton = document.getElementById("addPropertyButton");
	form.insertBefore(document.createTextNode("Property #"+itemNumber+" Description:"), addButton);
	form.insertBefore(document.createElement("br"), addButton);
	input = document.createElement("input");
	input.type = "text";
	input.name = "propertyDescription"+itemNumber;
	form.insertBefore(input, addButton);
	form.insertBefore(document.createElement("br"), addButton);
	form.insertBefore(document.createElement("br"), addButton);
	form.insertBefore(document.createTextNode("Property #"+itemNumber+" Type:"), addButton);
	form.insertBefore(document.createElement("br"), addButton);
	var typeValueArray = ["String","Text","Integer","Double","Boolean","Date","DateTime","Phone Number","Email Address","Postal Address"];
	var typeDisplayArray = ["Short Text","Long Text","Integer","Decimal","True/False","Date","Date & Time","Phone Number","Email Address","Postal Address"];
	var input = document.createElement("select");
	input.name = "propertyType" + itemNumber;
	for (i=0;i<typeValueArray.length;i++){
		input.add(new Option(typeDisplayArray[i], typeValueArray[i]));
	}
	form.insertBefore(input, addButton);
	form.insertBefore(document.createElement("br"), addButton);
	form.insertBefore(document.createElement("br"), addButton);
	form.insertBefore(document.createTextNode("Property #"+itemNumber+" Options:"), addButton);
	form.insertBefore(document.createElement("br"), addButton);
	input = document.createElement("input");
	input.type = "text";
	input.name = "propertyOptions"+itemNumber;
	form.insertBefore(input, addButton);
	form.insertBefore(document.createElement("br"), addButton);
	form.insertBefore(document.createElement("br"), addButton);
	form.insertBefore(document.createTextNode("Property #"+itemNumber+" Trackable:"), addButton);
	form.insertBefore(document.createElement("br"), addButton);
	var typeValueArray = ["true","false"];
	var typeDisplayArray = ["True","False"];
	var input = document.createElement("select");
	input.name = "propertyTracking" + itemNumber;
	for (i=0;i<typeValueArray.length;i++){
		input.add(new Option(typeDisplayArray[i], typeValueArray[i]));
	}
	form.insertBefore(input, addButton);
	form.insertBefore(document.createElement("br"), addButton);
	form.insertBefore(document.createElement("br"), addButton);
	itemNumber += 1;
	addButton.onclick = new Function("addPropertyItem("+itemNumber+")");
}