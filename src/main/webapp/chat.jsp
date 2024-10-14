<%@ page import="com.mongodb.client.MongoClients"%>
<%@ page import="org.bson.Document"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>

<%
    // Get uniqueCode from query parameter
    String uniqueCode = request.getParameter("uniqueCode"); 
    if (uniqueCode == null || uniqueCode.isEmpty()) {
        uniqueCode = "defaultUniqueCode"; // Handle null or empty case
    }
%>
<!DOCTYPE html>
<html>
<head>
<title>Chat Room</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    function sendMessage() {
        var message = $('#messageInput').val();
        var uniqueCode = '<%= uniqueCode %>';  // Use the uniqueCode passed in URL

        $.ajax({
            type: 'POST',
            url: 'sendMessage.jsp', // Correct path
            data: { uniqueCode: uniqueCode, message: message },
            success: function(response) {
                $('#messageInput').val(''); // Clear input after sending
                $('#messageResult').html(response); // Show success/error on page
                fetchMessages(); // Refresh messages after sending
            },
            error: function(xhr, status, error) {
                $('#messageResult').html('Error: Could not send message.'); // Show error
            }
        });
        return false; // Prevent form submission
    }

    function fetchMessages() {
        $.get('fetchMessages.jsp?uniqueCode=<%= uniqueCode %>', function(data) {
            $('#messages').html(data);
        });
    }

    $(document).ready(function() {
        setInterval(fetchMessages, 1000); // Poll for new messages every second
    });
</script>
</head>
<body>
    <h2>Common Chat Room</h2>
    <form onsubmit="return sendMessage();">
        Message: <input type="text" id="messageInput" required> 
        <input type="submit" value="Send">
    </form>

    <!-- Show the response (success/error) from sendMessage.jsp here -->
    <div id="messageResult"></div>

    <h3>Messages:</h3>
    <div id="messages"></div>
</body>
</html>
