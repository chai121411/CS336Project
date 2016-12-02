<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Query Results</title>

	<script type="text/javascript" src="jquery-2.1.1.min.js"></script>
	<script type="text/javascript" src="Chart.min.js"></script>

	<link rel="stylesheet" type="text/css" href="table.css">	
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
			String year1 = request.getParameter("Year1");
			String year2 = request.getParameter("Year2");
			String lastname1 = request.getParameter("Candidate1");
			String lastname2 = request.getParameter("Candidate2");
			String orderby = request.getParameter("OrderBy");
			
			String str; //the query string
			
			//Make a SELECT query from the Votes table with the range specified by the 'PopVotes' parameter at the HelloWorld.jsp
			
			str = "SELECT *, (V.PopVotes/ST.Voted)*100 AS PercentageOfVotes FROM Votes AS V ";
			str += "JOIN States AS ST ON (V.Year = ST.Year AND V.State = ST.State) ";
			str += "WHERE (V.Year = " + year1 + " AND V.LastName = \"" + lastname1 + "\"";
			str += ") OR (V.Year = " + year2 + " AND V.LastName = \"" + lastname2 + "\")";
			if (!orderby.equals("-1")) {
				str += "ORDER BY " + orderby;
			}			
			System.out.println(year1);
			System.out.println(year2);
			System.out.println(lastname1);
			System.out.println(lastname2);
			
			System.out.println(str);
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			
			//Create chart tag
			out.print("<canvas id=\"myChart\" width=\"1600\" height=\"2000\"></canvas>");
			
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
			out.print("FirstName");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("LastName");
			out.print("</td>");
			out.print("<td>");
			out.print("State");
			out.print("</td>");
			out.print("<td>");
			out.print("PopVotes");
			out.print("</td>");
			out.print("<td>");
			out.print("# Of People Voted");
			out.print("</td>");
			out.print("<td>");
			out.print("% Of Votes");
			out.print("</td>");
			out.print("</tr>");
			
			String year;
			String firstname;
			String lastname;
			String state;
			String popvotes;
			String voted;
			String percent;
			//Use the these variables to accumulate the chart data
			String labels = "[";
			String data = "[";
			String backgroundColor = "[";
			String borderColor = "[";
			
			//parse out the results
			while (result.next()) {
				year = result.getString("Year");
				firstname = result.getString("FirstName");
				lastname = result.getString("LastName");
				state = result.getString("State");
				popvotes = result.getString("PopVotes");
				voted = result.getString("Voted");
				percent = result.getString("PercentageOfVotes");
				
				if (percent.length() > 5) {
					percent = percent.substring(0, percent.indexOf(".") + 3) + "%";
				}
				
				out.print("<tr>");
				out.print("<td>");
				out.print(year);
				out.print("</td>");
				out.print("<td>");
				out.print(firstname);
				out.print("</td>");
				out.print("<td>");
				out.print(lastname);
				out.print("</td>");
				out.print("<td>");
				out.print(state);
				out.print("</td>");
				out.print("<td>");
				out.print(popvotes);
				out.print("</td>");
				out.print("<td>");
				out.print(voted);
				out.print("</td>");
				out.print("<td>");
				out.print(percent);
				out.print("</td>");
				out.print("</tr>");
				/*
				labels += "\"" + year;
				labels += state + "\", ";
				data += popvotes + ", ";
				
				backgroundColor += "\"rgba(54, 162, 235, 0.2)\", "; //Blue
				borderColor += "\"rgba(54, 162, 235, 1)\", ";
				*/
			}
			
			out.print("</table>");
			/*
			labels = labels.substring(0, labels.length() - 2);
			data = data.substring(0, data.length() - 2);
			backgroundColor = backgroundColor.substring(0, backgroundColor.length() - 2);
			borderColor = borderColor.substring(0, borderColor.length() - 2);
			labels += "]";
			data += "]";
			backgroundColor += "]";
			borderColor += "]";
			*/
			//System.out.println(labels);
			//System.out.println(data);
			//System.out.println(backgroundColor);
			//System.out.println(borderColor);
			/*
			out.print("<script> var ctx = document.getElementById(\"myChart\");");
			out.print("var myChart = new Chart(ctx, { type: 'bar', data: ");
			out.print("{labels: " + labels + ", "); //State and Year
			out.print("datasets: [{label: '# of PopVotes', ");
			out.print("data: "+ data +", "); //PopVotes
			out.print("backgroundColor: " + backgroundColor + ", ");
			out.print("borderColor: " + borderColor + ", ");
			out.print("borderWidth: 1}]}");
			out.print(", options: { responsive: false, scales: { yAxes: [{ ticks: { beginAtZero:true}}] }}});</script>");
			*/
			//close the connection.
			con.close();

		} catch (Exception e) {
		
		}
	%>

</body>
</html>