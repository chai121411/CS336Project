<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>State Voting Trends 1996 - 2012</title>
	<script type="text/javascript" src="jquery-2.1.1.min.js"></script>
	<script type="text/javascript" src="Chart.min.js"></script>
</head>
<body>
	
</script>
	
	Hello World in html. <!-- the usual HTML way -->
	<% out.println("Hello World in jsp programming."); %> <!-- output the same thing, but using jsp programming -->

									  
<br>
 <!-- Show html form to i) display something, ii) choose an action via a 
  | radio button -->
 This will perform a SELECT * on Candidate or States
<form method="get" action="show.jsp" enctype=text/plain>
    <!-- note the show.jsp will be invoked when the choice is made -->
	<!-- The next lines give HTML for radio buttons being displayed -->
  <input type="radio" name="command" value="Candidate"/>Let's have a Candidate!
  <br>
  <input type="radio" name="command" value="States"/>Let's go to a State!
    <!-- when the radio for bars is chosen, then 'command' will have value 
     | 'bars', in the show.jsp file, when you access request.parameters -->
  <br>
  <input type="submit" value="submit" />
</form>
<br>

<!-- 
--------------------------------------------------------------- <br>
NOTE THIS DOESNT WORK. <br>
Alternatively, lets type in a bar and a beer and  a price limit. 
<br>
	<form method="post" action="newBeer.jsp">
	<table>
	<tr>    
	<td>Bar</td><td><input type="text" name="bar"></td>
	</tr>
	<tr>
	<td>Beer</td><td><input type="text" name="beer"></td>
	</tr>
	<tr>
	<td>Price</td><td><input type="text" name="price"></td>
	</tr>
	</table>
	<br>
	<input type="submit" value="submit">
	</form>
<br>
-->

--------------------------------------------------------------- <br>


Popular Votes By State And Year
<br>
Add Filters to the results!
<br>
	<form method="query" action="query.jsp">
		Year:
		<select name="Year" size=1>
			<option value="-1">All years</option>
			<option value="1996">1996</option>
			<option value="2000">2000</option>
			<option value="2004">2004</option>
			<option value="2008">2008</option>
			<option value="2012">2012</option>
		</select>&nbsp;<br>
		Popular Votes: 
		<select name="PopVotes" size=1>
			<option value="0">0 and over</option>
			<option value="100000">100,000 and over</option>
			<option value="250000">250,000 and over</option>
			<option value="500000">500,000 and over</option>
			<option value="600000">600,000 and over</option>
			<option value="700000">700,000 and over</option>
			<option value="800000">800,000 and over</option>
			<option value="900000">900,000 and over</option>
			<option value="1000000">1,000,000 and over</option>
			<option value="1100000">1,100,000 and over</option>
			<option value="1200000">1,200,000 and over</option>
			<option value="1300000">1,300,000 and over</option>
			<option value="1400000">1,400,000 and over</option>
			<option value="1500000">1,500,000 and over</option>
			<option value="2000000">2,000,000 and over</option>
			<option value="5000000">5,000,000 and over</option>
		</select>&nbsp;<br>	
		Order Results By: 
		<select name="OrderBy" size=1>
			<option value="Year DESC, State ASC">Year and State(in alphabetical order)</option>
			<option value="PopVotes DESC">Popular Votes</option>
		</select>&nbsp;<br>	
		<input type="submit" value="submit">
	</form>
<br>

--------------------------------------------------------------- <br>
<!--
Aggregate the Result?: 
		<select name="Aggregate" size=1>
			<option value="NO">None</option>
			<option value="AVERAGE">Average</option>
			<option value="SUM">Sum</option>
			<option value="MAX">Max</option>
			<option value="MIN">Min</option>
		</select>&nbsp;<br>
-->

</body>
</html>