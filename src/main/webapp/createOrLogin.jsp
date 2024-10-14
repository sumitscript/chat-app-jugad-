<%@ page import="com.mongodb.client.MongoClients"%>
<%@ page import="com.mongodb.client.MongoClient"%>
<%@ page import="com.mongodb.client.MongoDatabase"%>
<%@ page import="com.mongodb.client.MongoCollection"%>
<%@ page import="org.bson.Document"%>
<%@ page import="java.util.ArrayList"%>
<%
    String name = request.getParameter("name").toLowerCase();  // Convert name to lowercase
    String dob = request.getParameter("dob").replaceAll("-", "");  // Remove dashes from DOB

    String uniqueCode = name + dob;  // Concatenate name + dob for unique ID

    String mongoUri = "mongodb+srv://sdbluezomegaming22:erp1234@erp.cilto.mongodb.net/chatapp?retryWrites=true&w=majority";
 // Add your MongoDB Atlas connection string

    if (mongoUri == null || mongoUri.isEmpty()) {
        out.println("<h2>Error: MongoDB connection string is not provided.</h2>");
    } else {
        try (MongoClient mongoClient = MongoClients.create(mongoUri)) {
            MongoDatabase database = mongoClient.getDatabase("chatapp");
            MongoCollection<Document> collection = database.getCollection("profiles");

            // Check if profile exists
            Document existingProfile = collection.find(new Document("uniqueCode", uniqueCode)).first();

            if (existingProfile == null) {
                // Profile does not exist, so create it
                Document newProfile = new Document("name", name)
                                      .append("dob", dob)
                                      .append("uniqueCode", uniqueCode)
                                      .append("messages", new ArrayList<Document>());
                collection.insertOne(newProfile);
                out.println("<h2>Profile created! Welcome to the chat room!</h2>");
            } else {
                // Profile exists, log the user in
                out.println("<h2>Welcome back to the chat room, " + name + "!</h2>");
            }
            out.println("<a href='chat.jsp?uniqueCode=" + uniqueCode + "'>Enter Chat Room</a>");
        } catch (Exception e) {
            out.println("<h2>Error: " + e.getMessage() + "</h2>");
        }
    }
%>
