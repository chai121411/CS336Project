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
			
			String year1 = request.getParameter("Year1");
			String year2 = request.getParameter("Year2");
			String lastname1 = request.getParameter("Candidate1");
			String lastname2 = request.getParameter("Candidate2");
			String orderby = request.getParameter("OrderBy");
			
			String str; //the query string
			
			//Perform percentage query based on parameters from selections
			str = "SELECT *, (V.PopVotes/ST.Voted)*100 AS PercentageOfVotes FROM Votes AS V ";
			str += "JOIN States AS ST ON (V.Year = ST.Year AND V.State = ST.State) ";
			str += "WHERE (V.Year = " + year1 + " AND V.LastName = \"" + lastname1 + "\"";
			str += ") OR (V.Year = " + year2 + " AND V.LastName = \"" + lastname2 + "\")";
			if (!orderby.equals("-1")) {
				str += "ORDER BY " + orderby;
			}			
			//System.out.println(year1);
			//System.out.println(year2);
			//System.out.println(lastname1);
			//System.out.println(lastname2);
			
			System.out.println(str);
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			
			//Create chart tag
			out.print("<canvas id=\"myChart1\" width=\"1200\" height=\"1500\"></canvas>");
			
			//Create chart tag
			out.print("<canvas id=\"myChart2\" width=\"1200\" height=\"1500\"></canvas>");
			
			//Make an HTML table to show the results in:
			out.print("<table>");
			
			out.print("<tr>");
			out.print("<td>");
			out.print("Year");
			out.print("</td>");
			out.print("<td>");
			out.print("FirstName");
			out.print("</td>");
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
			
			//projections
			String year;
			String firstname;
			String lastname;
			String state;
			String popvotes;
			String voted;
			String percent;
			
			//Use the these variables to accumulate the chart data
			String graphname1 = lastname1 + ", " + year1;
			String labels1 = "[";
			String data1 = "[";
			String backgroundColor1 = "[";
			String borderColor1 = "[";
			
			String graphname2 = lastname2 + ", " + year2;
			String labels2 = "[";
			String data2 = "[";
			String backgroundColor2 = "[";
			String borderColor2 = "[";
			
			String dataPoints1 = "[{ x: ";
			String dataPoints2 = "[{ x: ";
			
			
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
					percent = percent.substring(0, percent.indexOf(".") + 3);
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
				out.print(percent + "%");
				out.print("</td>");
				out.print("</tr>");
				
				if (year.equals(year1) && lastname.equals(lastname1)) {
					labels1 += "\"" + state + "\", ";
					data1 += percent + ", ";
					backgroundColor1 += "\"rgba(54, 162, 235, 0.2)\", "; //Blue
					borderColor1 += "\"rgba(54, 162, 235, 1)\", ";
					dataPoints1 += "\"" + state+ "\"" + ", y: " + percent + " }, { x: ";
				} else {
					labels2 += "\"" + state + "\", ";
					data2 += percent + ", ";
					backgroundColor2 += "\"rgba(255, 206, 86, 0.2)\", ";
					borderColor2 += "\"rgba(255, 206, 86, 1)\", ";
					dataPoints2 += "\"" + state+ "\"" + ", y: " + percent + " }, { x: ";
				}	
			}
			
			out.print("</table>");
			
			labels1 = labels1.substring(0, labels1.length() - 2);
			data1 = data1.substring(0, data1.length() - 2);
			backgroundColor1 = backgroundColor1.substring(0, backgroundColor1.length() - 2);
			borderColor1 = borderColor1.substring(0, borderColor1.length() - 2);
			dataPoints1 = dataPoints1.substring(0, dataPoints1.length() - 7);
			labels1 += "]";
			data1 += "]";
			backgroundColor1 += "]";
			borderColor1 += "]";
			dataPoints1 += "]";
			
			labels2 = labels2.substring(0, labels2.length() - 2);
			data2 = data2.substring(0, data2.length() - 2);
			backgroundColor2 = backgroundColor2.substring(0, backgroundColor2.length() - 2);
			borderColor2 = borderColor2.substring(0, borderColor2.length() - 2);
			dataPoints2 = dataPoints2.substring(0, dataPoints2.length() - 7);
			labels2 += "]";
			data2 += "]";
			backgroundColor2 += "]";
			borderColor2 += "]";
			dataPoints2 += "]";
			
			System.out.println(labels1);
			System.out.println(data1);
			System.out.println(dataPoints1);
			System.out.println(dataPoints2);
			
			out.print("<script> var ctx1 = document.getElementById(\"myChart1\");");
			out.print("var myChart1 = new Chart(ctx1, { type: 'line', data: ");
			out.print("{labels: " + labels1 + ", "); //State
			out.print("datasets: [{label: 'Candidate 1: " + graphname1 + "', ");
			out.print("data: "+ dataPoints1 +", "); //PopVotes
			out.print("fill: false, ");
			//out.print("backgroundColor: " + backgroundColor1 + ", ");
			out.print("borderColor: 'rgba(220,180,180,1)', ");
			out.print("borderWidth: 3");
			out.print("}, {label: 'Candidate 2:  " + graphname2 + "', ");
			out.print("data: "+ dataPoints2 +", ");
			out.print("fill: false, ");
			//out.print("backgroundColor: " + backgroundColor2 + ", ");
			out.print("borderColor: 'rgba(151,187,205,1)', ");
			out.print("borderWidth: 3");
			out.print("}]}");
			out.print(", options: { responsive: false, scales: { yAxes: [{ ticks: { beginAtZero:true}}] }}});</script>");
			//out.print(", options: { responsive: false, scales: { xAxes: gridLines:{ color:\"rgba(255,255,255,0.5)\", zeroLineColor:\"rgba(255,255,255,0.5)\" }}],Axes: [{ ticks: { beginAtZero:true}}] }}});</script>");
			
			
			
			
			
			out.print("<script> var ctx = document.getElementById(\"myChart2\");");
			out.print("var myChart2 = new Chart(ctx, { type: 'bar', data: ");
			out.print("{labels: " + labels2 + ", "); //State and Year
			out.print("datasets: [{label: 'Candidate 2: " + graphname2 +"', ");
			out.print("data: "+ data2 +", "); //PopVotes
			out.print("backgroundColor: " + backgroundColor2 + ", ");
			out.print("borderColor: " + borderColor2 + ", ");
			out.print("borderWidth: 1}]}");
			out.print(", options: { responsive: false, scales: { xyAxes: [{ ticks: { beginAtZero:true}}] }}});</script>");
			
			//close the connection.
			con.close();

		} catch (Exception e) {
		
		}
	%>

</body>
</html>