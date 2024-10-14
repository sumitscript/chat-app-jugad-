<%@ page import="com.mongodb.client.MongoClients"%>
<%@ page import="com.mongodb.client.MongoClient"%>
<%@ page import="com.mongodb.client.MongoDatabase"%>
<%@ page import="com.mongodb.client.MongoCollection"%>
<%@ page import="org.bson.Document"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.io.IOException"%>
<%
String mongoUri = "mongodb+srv://sdbluezomegaming22:erp1234@erp.cilto.mongodb.net/chatapp?retryWrites=true&w=majority";
 // Update this with your actual URI
    String message = "";
    String errorMessage = "";

    // Check if the form is submitted
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String name = request.getParameter("name");
        String content = request.getParameter("content");

        if (name == null || content == null || name.isEmpty() || content.isEmpty()) {
            errorMessage = "Name and content cannot be empty.";
        } else {
            try (MongoClient mongoClient = MongoClients.create(mongoUri)) {
                MongoDatabase database = mongoClient.getDatabase("chatapp");
                MongoCollection<Document> collection = database.getCollection("messages");

                // Create a document to insert
                Document doc = new Document("name", name)
                                       .append("content", content);
                collection.insertOne(doc);
                message = "Message inserted successfully!";
            } catch (Exception e) {
                errorMessage = "Error inserting message: " + e.getMessage();
            }
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
<title>Insert Message</title>
</head>
<body>
	<h1>Insert Message into MongoDB</h1>
	<form method="post">
		Name: <input type="text" name="name" required><br>
		Message:
		<textarea name="content" required></textarea>
		<br> <input type="submit" value="Submit">
	</form>

	<h3 style="color: green;"><%= message %></h3>
	<h3 style="color: red;"><%= errorMessage %></h3>
</body>
</html>
