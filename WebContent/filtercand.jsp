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
			
			String year = request.getParameter("Year");
			String party = request.getParameter("Party");
			String won = request.getParameter("Won");
			String ev = request.getParameter("ElectoralVotes");
			String budget = request.getParameter("Budget");
			String orderby = request.getParameter("OrderBy");
		
			String str; //the query string
			
			//Perform percentage query based on parameters from selections
			str = "SELECT * FROM Votes JOIN Candidate ON (Votes.Year = Candidate.Year AND Votes.LastName = Candidate.LastName) WHERE";
			
			if (!year.equals("-1")) 
				str += " Votes.Year = " + year + " AND";
			
			if (!party.equals("-1")) 
				str += " Candidate.Party = \"" + party + "\" AND";
				
			if (!won.equals("-1")) 
				str += " Candidate.Won = " + won + " AND";
			
			if (!ev.equals("-1")) 
				str += " Candidate.ElectoralVotes >= " + ev + " AND";

			if (!budget.equals("-1")) 
				str += " Candidate.BudgetSpent >= " + budget + " AND";
			
			str = str.substring(0, str.length() - 3); //remove last AND
			
			str+= " ORDER BY " + orderby;
			
			//System.out.println(str);
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			
			String graphname = " # of Pop. Votes correlated with: ";
			
			if (!year.equals("-1")) {
				graphname += year + ", ";
			} else {
				graphname += "All years, ";
			}
			
			if (!party.equals("-1")) 
				graphname += party + ", ";
				
			if (won.equals("0")) 
				graphname += "Lost, ";
			else if (won.equals("1")) {
				graphname += "Won, ";
			}
			
			if (!ev.equals("-1")) 
				graphname += "Electoral Votes >= " + ev + ", ";

			if (!budget.equals("-1")) 
				graphname +=  "BudgetSpent >= " + budget + ", ";
			
			graphname = graphname.substring(0, graphname.length() - 2);
			
			out.print("<div id=count></div>");
			
			//Create chart tag
			out.print("<canvas id=\"myChart\" width=\"1100\" height=\"760\"></canvas>");
			
			//Make an HTML table to show the results in:	
			out.print("<br/>");
			out.print("<h2> Table Representation of Results </h2>");
			out.print("<table>");
			
			out.print("<tr>");
			out.print("<td>");
			out.print("Year");
			out.print("</td>");
			out.print("<td>");
			out.print("State");
			out.print("</td>");
			out.print("<td>");
			out.print(graphname);
			out.print("</td>");
			out.print("</tr>");
			
			//projections
			String year_proj;
			String state;
			String popvotes;
			
			//Use the these variables to accumulate the chart data
			String labels = "[";
			String data = "[";
			String backgroundColor = "[";
			String borderColor = "[";
			
			int count = 0;
			
			//parse out the results
			while (result.next()) {
				year_proj = result.getString("Year");
				popvotes = result.getString("PopVotes");
				state = result.getString("State");
				
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//Print out current votes year:
				out.print(year_proj);
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
				
				labels += "\"" + year_proj;
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
			
			out.print("<script> var ctx = document.getElementById(\"myChart\");");
			out.print("var myChart = new Chart(ctx, { type: 'bar', data: ");
			out.print("{labels: " + labels + ", "); //State and Year
			out.print("datasets: [{label: '"+graphname+"', ");
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