<%@ page import="com.mongodb.client.MongoClients"%>
<%@ page import="org.bson.Document"%>
<%@ page import="com.mongodb.client.result.UpdateResult"%>
<%@ page import="java.util.Date"%>

<%
    String uniqueCode = request.getParameter("uniqueCode");
    String message = request.getParameter("message");

    String mongoUri = "mongodb+srv://sdbluezomegaming22:erp1234@erp.cilto.mongodb.net/chatapp?retryWrites=true&w=majority";

    if (uniqueCode == null || message == null || uniqueCode.isEmpty() || message.isEmpty()) {
        out.println("Unique code and message cannot be empty.");
        return;
    }

    try (var mongoClient = MongoClients.create(mongoUri)) {
        var database = mongoClient.getDatabase("chatapp");
        var profileCollection = database.getCollection("profiles");

        // Check if the profile exists
        Document existingProfile = profileCollection.find(new Document("uniqueCode", uniqueCode)).first();
        if (existingProfile == null) {
            out.println("Error: Profile not found for uniqueCode: " + uniqueCode);
            return;
        }

        // Create a new message document
        Document newMessage = new Document()
            .append("uniqueCode", uniqueCode)
            .append("message", message)
            .append("timestamp", new Date());

        // Add the message to the profile's messages list
        UpdateResult result = profileCollection.updateOne(
            new Document("uniqueCode", uniqueCode),
            new Document("$push", new Document("messages", newMessage))
        );

        if (result.getModifiedCount() > 0) {
            out.println("Success: Message saved successfully!");
        } else {
            out.println("Error: Failed to save message.");
        }
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>
