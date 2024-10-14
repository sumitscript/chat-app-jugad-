<%@ page import="com.mongodb.client.MongoClients"%>
<%@ page import="org.bson.Document"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>

<%
    String uniqueCode = request.getParameter("uniqueCode");
    String mongoUri = "mongodb+srv://sdbluezomegaming22:erp1234@erp.cilto.mongodb.net/chatapp?retryWrites=true&w=majority";

    try (var mongoClient = MongoClients.create(mongoUri)) {
        var database = mongoClient.getDatabase("chatapp");
        var profileCollection = database.getCollection("profiles");

        // Fetch all messages from all profiles
        List<Document> messagesList = new ArrayList<>();
        for (Document profile : profileCollection.find()) {
            List<Document> messages = profile.getList("messages", Document.class, new ArrayList<>());
            for (Document msg : messages) {
                messagesList.add(msg);
            }
        }

        // Display messages
        for (Document msg : messagesList) {
            out.println("<p><strong>" + msg.getString("uniqueCode") + ":</strong> " + msg.getString("message") + "</p>");
        }
    } catch (Exception e) {
        out.println("Error fetching messages: " + e.getMessage());
    }
%>
