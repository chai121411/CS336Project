<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Query Results</title>
</head>
<body>
	<%
		List<String> list = new ArrayList<String>();

		try {

			//Create a connection string
			String url = "jdbc:mysql://cs336.cpdjrnvmh5hy.us-east-1.rds.amazonaws.com:3306/cs336";
			//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
			Class.forName("com.mysql.jdbc.Driver");

			//Create a connection to your DB
			Connection con = DriverManager.getConnection(url, "cs336project", "cs336project");
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the combobox from the HelloWorld.jsp
			String year_entity = request.getParameter("Year");
			String popvotes_entity = request.getParameter("PopVotes");
			String orderby_entity = request.getParameter("OrderBy");
			
			//Make a SELECT query from the Votes table with the range specified by the 'PopVotes' parameter at the HelloWorld.jsp
			String str = "SELECT * FROM Votes WHERE PopVotes >= " + popvotes_entity;
			if (!year_entity.equals("-1")) {
				str += " AND Year = " + year_entity;
			}
			str += " ORDER BY " + orderby_entity;
			System.out.println(str);
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);

			//Make an HTML table to show the results in:
			out.print("<table>");

			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			//print out column header
			out.print("Year");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("State");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Popular Votes");
			out.print("</td>");
			out.print("</tr>");

			//parse out the results
			while (result.next()) {
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//Print out current votes year:
				out.print(result.getString("Year"));
				out.print("</td>");
				out.print("<td>");
				//Print out current state voting:
				out.print(result.getString("State"));
				out.print("</td>");
				out.print("<td>");
				//Print out the number of popular votes
				out.print(result.getString("PopVotes"));
				out.print("</td>");
				out.print("</tr>");

			}
			out.print("</table>");

			//close the connection.
			con.close();

		} catch (Exception e) {
		}
	%>

</body>
</html>