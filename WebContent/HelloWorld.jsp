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
	
	<link rel="stylesheet" type="text/css" href="cs336.css">
	
	<nav>
	<ul class="topnav" id="myTopnav">
		<li id="navbartitle">Voting Trends 1996 - 2012</li>
		<li><a href="#selectall">select all</a></li>
		<li><a href="#popularvotes">Popular Votes Query</a></li>
	</ul>
    </nav>
</head>
<body>
	
	<p> </p>
	<h2>Analyze past election trends about states from 1996 - 2012!</h2> <!-- the usual HTML way -->
	Ever wanted to perform adhoc queries and have the results shown in a chart? Here you go!

	<hr id=selectall>
	<h3>SELECT * show.jsp</h4>
	<p>This will perform a SELECT * on Candidate or States</p>
	<form method="get" action="show.jsp" id="selectallform" enctype=text/plain>
		<div class="indent">
		<input type="radio" name="command" value="Candidate"/>Let's have a Candidate!
		</div>
		<div class="indent">
		<input type="radio" name="command" value="States"/>Let's go to a State!
		</div>
		<input type="submit" value="submit" />
	</form>

	<hr id=popularvotes>
	<h3>Adhoc Query on Popular Votes</h4>
	<p>Please add filters to the query!</p>
		<form method="query" action="query.jsp">
			<div class="indent">Year: 
				<select name="Year" size=1>
					<option value="-1">All years</option>
					<option value="1996">Only 1996</option>
					<option value="2000">Only 2000</option>
					<option value="2004">Only 2004</option>
					<option value="2008">Only 2008</option>
					<option value="2012">Only 2012</option>
				</select>&nbsp;<br>
			</div>
			<div class="indent"> Popular Votes: 
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
			</div>	
			<div class="indent"> Order Results By: 
				<select name="OrderBy" size=1>
					<option value="Year DESC, State ASC">Year and State</option>
					<option value="State ASC">State</option>
					<option value="PopVotes DESC">Popular Votes</option>
				</select>&nbsp;<br>
			</div>	
			<input type="submit" value="submit">
		</form>
	
	<hr>
	<h3>Aggregate</h4>
	<p>Percentage...</p>
	<form method="query" action="query.jsp">
		
	</form>
	
	<hr>
	
	<p>hi</p>
	<p>hi</p>
	<p>hi</p>
	<p>hi</p>
	<p>hi</p>
	<p>hi</p>
	<p>hi</p>
	<p>hi</p>
	<p>hi</p>
	<p>hi</p>
	<p>hi</p>
	<p>hi</p>
	<p>hi</p>


	<script>
		$(document).ready(function() {
			$("#selectallform").submit(function() {
				if (!$("input[name=command]:checked").val()) {
				  alert('Nothing is checked in Select * Form!');
				  return false;
				}
			});
		});
	</script>

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