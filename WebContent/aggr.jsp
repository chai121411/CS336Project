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

<button onclick="location.href = 'HelloWorld.jsp'" style="color:blue"><b>Home</b></button>
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
			
			String year1 = request.getParameter("year_aggr1");
			String year2 = request.getParameter("year_aggr2");
			String year3 = request.getParameter("year_aggr3");
			String year4 = request.getParameter("year_aggr4");
			String year5 = request.getParameter("year_aggr5");
			
			String aggr = request.getParameter("Aggregate");
			String projection = request.getParameter("Projection");
			String orderby = request.getParameter("OrderBy");
		
			String str; //the query string
			
			//Perform percentage query based on parameters from selections
			str = "SELECT *, " + aggr + "("+ projection +") AS aggr_result FROM States WHERE";
			if (year1 != null) 
				str += " Year = 1996 OR";
			if (year2 != null)
				str += " Year = 2000 OR";
			if (year3 != null)
				str += " Year = 2004 OR";
			if (year4 != null)
				str += " Year = 2008 OR";
			if (year5 != null)
				str += " Year = 2012 OR";
			
			str = str.substring(0, str.length() - 3); //remove last AND
			
			//str += "JOIN States AS ST ON (V.Year = ST.Year AND V.State = ST.State) ";
			//str += "WHERE (V.Year = " + year1 + " AND V.LastName = \"" + lastname1 + "\"";
			//str += ") OR (V.Year = " + year2 + " AND V.LastName = \"" + lastname2 + "\")";
			
			//Add group by clause to enable aggregation
			str+= " GROUP BY State";
			
			if (orderby.equals("aggr_proj")) {
				str += " ORDER BY " + aggr + "("+ projection +") DESC";
			}
			
			System.out.println(str);
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			
			String graphname = null;
			if (projection.equals("Citizen")) {
				graphname = "# of people that are Citizens over ";	
			} else if (projection.equals("Registered")) {
				graphname = "# of people that were Registered to vote over ";
			} else {
				graphname = "# of people that Voted over ";
			}
			
			if (year1 != null) 
				graphname += year1 + ", ";
			if (year2 != null)
				graphname += year2 + ", ";
			if (year3 != null)
				graphname += year3 + ", ";
			if (year4 != null)
				graphname += year4 + ", ";
			if (year5 != null)
				graphname += year5 + ", ";
			
			graphname = graphname.substring(0, graphname.length() - 2);
			graphname += ", " + aggr.substring(0, 1) + aggr.substring(1).toLowerCase();
			
			//Create chart tag
			out.print("<canvas id=\"myChart\" width=\"1100\" height=\"960\"></canvas>");
			
			//Make an HTML table to show the results in:	
			out.print("<br/>");
			out.print("<h2> Table Representation of Results </h2>");
			out.print("<table>");
			
			out.print("<tr>");
			out.print("<td>");
			out.print("State");
			out.print("</td>");
			out.print("<td>");
			//out.print(aggr + "("+ projection +")");
			out.print(graphname);
			out.print("</td>");
			out.print("</tr>");
			
			//projections
			String state;
			String a_result;
			
			//Use the these variables to accumulate the chart data
			String labels = "[";
			String data = "[";
			String backgroundColor = "[";
			String borderColor = "[";
			
			//parse out the results
			while (result.next()) {
				state = result.getString("State");
				a_result = result.getString("aggr_result");
				
				out.print("<tr>");
				out.print("<td>");
				out.print(state);
				out.print("</td>");
				out.print("<td>");
				out.print(a_result);
				out.print("</td>");
				out.print("</tr>");	
				
				labels += "\"" + state + "\", ";
				data += a_result + ", ";
				
				backgroundColor += "\"rgba(54, 162, 235, 0.2)\", "; //Blue
				borderColor += "\"rgba(54, 162, 235, 1)\", ";
			}
			
			out.print("</table>");
			
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