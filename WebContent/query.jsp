<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Query Results</title>

	<script type="text/javascript" src="js/jquery-2.1.1.min.js"></script>
	<script type="text/javascript" src="js/Chart.min.js"></script>

	<link rel="stylesheet" type="text/css" href="css/table.css">	
</head>
<body>

<button onclick="location.href = 'HelloWorld.jsp'" style="color:blue"><img src="css/back16.png"/> <b>Home</b></button>
<h2 style = "text-align:center;"> Visual Representation of Results </h2>

	<%

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
			String aggr = request.getParameter("Aggregate");
			String str; //the query string
			
			//Make a SELECT query from the Votes table with the range specified by the 'PopVotes' parameter at the HelloWorld.jsp
			if (!aggr.equals("-1")) {
				str = "SELECT *, SUM(PopVotes) AS SPV FROM Votes";
				if (!year_entity.equals("-1")) {
					str += " WHERE Year = " + year_entity;
				}
				str += " GROUP BY Year, State";
				str += " HAVING SUM(PopVotes) >= " + popvotes_entity;
				str += " ORDER BY " + orderby_entity;
				
			} else {
				str = "SELECT * FROM Votes WHERE PopVotes >= " + popvotes_entity;	
				if (!year_entity.equals("-1")) {
					str += " AND Year = " + year_entity;
				}
				str += " ORDER BY " + orderby_entity;
			}
			
			//System.out.println(str);
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			
			out.print("<div id=count></div>");
			//Create chart tag
			if (!year_entity.equals("-1")) {
				out.print("<canvas id=\"myChart\" width=\"1100\" height=\"760\"></canvas>");
			} else {
				out.print("<canvas id=\"myChart\" width=\"1400\" height=\"1180\"></canvas>");	
			}
			
			//Make an HTML table to show the results in:
			out.print("<br/>");
			out.print("<h2> Table Representation of Results </h2>");	
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
			
			//projections
			String year;
			String state;
			String popvotes;
			
			//Use the these variables to accumulate the chart data
			String labels = "[";
			String data = "[";
			String backgroundColor = "[";
			String borderColor = "[";
			
			String pv_project = "PopVotes";
			
			if (!aggr.equals("-1")) {
				pv_project = "SPV"; //pv may be different depending on user input
			}
			
			int count = 0;
			
			//parse out the results
			while (result.next()) {
				year = result.getString("Year");
				popvotes = result.getString(pv_project);
				state = result.getString("State");
				
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//Print out current votes year:
				out.print(year);
				out.print("</td>");
				out.print("<td>");
				//Print out current state voting:
				out.print(state);
				out.print("</td>");
				out.print("<td>");
				//Print out the number of popular votes
				out.print(popvotes);
				out.print("</td>");
				out.print("</tr>");
				
				labels += "\"" + year;
				labels += state + "\", ";
				data += popvotes + ", ";
				
				backgroundColor += "\"rgba(54, 162, 235, 0.2)\", "; //Blue
				borderColor += "\"rgba(54, 162, 235, 1)\", ";
				count++;
			}
			
			out.print("</table>");
			if (count == 0) {
				out.println("<script>$(\"#count\").append( \"<p>No Results Returned!</p>\")</script>");
			}
			
			labels = labels.substring(0, labels.length() - 2);
			data = data.substring(0, data.length() - 2);
			backgroundColor = backgroundColor.substring(0, backgroundColor.length() - 2);
			borderColor = borderColor.substring(0, borderColor.length() - 2);
			labels += "]";
			data += "]";
			backgroundColor += "]";
			borderColor += "]";
			
			//System.out.println(labels);
			//System.out.println(data);
			//System.out.println(backgroundColor);
			//System.out.println(borderColor);
			
			out.print("<script> var ctx = document.getElementById(\"myChart\");");
			out.print("var myChart = new Chart(ctx, { type: 'bar', data: ");
			out.print("{labels: " + labels + ", "); //State and Year
			out.print("datasets: [{label: '# of PopVotes', ");
			out.print("data: "+ data +", "); //PopVotes
			out.print("backgroundColor: " + backgroundColor + ", ");
			out.print("borderColor: " + borderColor + ", ");
			out.print("borderWidth: 1}]}");
			out.print(", options: { responsive: false, scales: { yAxes: [{ ticks: { beginAtZero:true}}] }}});</script>");
			//close the connection.
			con.close();

		} catch (Exception e) {
		
		}
	%>

</body>
</html>