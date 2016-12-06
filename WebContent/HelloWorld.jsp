<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>State Voting Trends 1996 - 2012</title>
	<script type="text/javascript" src="js/jquery-2.1.1.min.js"></script>
	<script type="text/javascript" src="js/sweetalert.min.js"></script>
	
	<link rel="stylesheet" type="text/css" href="css/cs336.css">
	<link rel="stylesheet" type="text/css" href="css/sweetalert.css">
	
	
	<nav>
	<ul class="topnav" id="myTopnav">
		<li id="navbartitle">Voting Trends 1996 - 2012</li>
		<li><a href="#aggr_query">Aggregation Query</a></li>
		<li><a href="#filtercand">Popular Votes, correlated with Candidates Query</a></li>
		<li><a href="#popularvotes">Popular Votes Query</a></li>
		<li><a href="#percentagevotes">Percentage of States Query</a></li>
	</ul>
    </nav>
    
</head>
<body>
	<p> </p>
	<h1>Analyze past election trends about states from 1996 - 2012!</h1> <!-- the usual HTML way -->
	<p id="intro" align="center">Ever wanted to perform adhoc queries and have the results shown in a chart? Here you go!</p>
	
	<hr id=percentagevotes>
	<h2>Percentage of Votes By State </h2>
	<p class="description">See how many votes a candidate took from a state!</p>
	<p class="instruction">Choose two candidates to compare</p>
	<div class="indent">
		<p> A candidate is identified by a <span class="mini-instruction">year</span> and <span class="mini-instruction">name</span></p>
	</div>
	<form method="query" action="percent.jsp" id="percentagevoteform">
		<div class="indent">Candidate 1 - from Year: 
			<select id="Year1" name="Year1" size=1 onchange="javascript: dynamicdropdown(this.options[this.selectedIndex].value);"> 
				<option value="1996">1996</option>
				<option value="2000">2000</option>
				<option value="2004">2004</option>
				<option value="2008">2008</option>
				<option value="2012">2012</option>
			</select>&nbsp;&nbsp;&nbsp; ,&nbsp; Name:
			<select id="Candidate1" name="Candidate1" size=1>
		 		<option value="Dole">Bob Dole</option> 
		 		<option value="Clinton">Bill Clinton</option>
			    <!--<option value="Bush">George Bush</option>
				<option value="Gore">Al Gore</option>
				<option value="Kerry">John Kerry</option>
				<option value="McCain">John McCain</option>
				<option value="Obama">Barack Obama</option>
				<option value="Romney">Mitt Romney</option>-->
			</select>&nbsp;
		</div>
		<div class="indent">Candidate 2 - from Year: 
			<select id="Year2" name="Year2" size=1 onchange="javascript: dynamicdropdown2(this.options[this.selectedIndex].value);"> 
				<option value="1996">1996</option>
				<option value="2000">2000</option>
				<option value="2004">2004</option>
				<option value="2008">2008</option>
				<option value="2012">2012</option>
			</select>&nbsp;&nbsp;&nbsp; ,&nbsp; Name:
			<select id="Candidate2" name="Candidate2" size=1>
		 		<option value="Dole">Bob Dole</option> 
		 		<option value="Clinton">Bill Clinton</option>
			</select>&nbsp;
		</div>
		<div class="indent"> Order results by: 
				<select name="OrderBy" size=1>
					<option value="V.State">State</option>
					<option value="PercentageOfVotes DESC">Percentage of votes</option>
				</select>&nbsp;<br>
			</div>
		<input type="submit" value="Submit" style = "width:5em; height:2.5em">
	</form>
	
	<hr id=popularvotes>
	<h2>Adhoc Query on Popular Votes</h2>
	<p class="description">See how many votes a state gave!</p>
	<p class="instruction">You can filter by year and votes</p>
		<form method="query" action="query.jsp">
			<div class="indent">Year?
				<select id="queryYear" name="Year" size=1 onchange="javascript: dynamicdropdown_query(this.options[this.selectedIndex].value);">
					<option value="-1">All years</option>
					<option value="1996">Only 1996</option>
					<option value="2000">Only 2000</option>
					<option value="2004">Only 2004</option>
					<option value="2008">Only 2008</option>
					<option value="2012">Only 2012</option>
				</select>&nbsp;<br>
			</div>
			<div class="indent"> Popular votes which are: 
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
			<div class="indent">
				<p class="instruction">Change the way results appear with the next two options</p>
			</div>
			<div class="indent"> Group by time and states?: 
				<select name="Aggregate" size=1>
					<option value="SUM">Yes</option>
					<option value="-1">No</option>
				</select>&nbsp;<br>
			</div>
			<div class="indent"> Order results by: 
				<select id="queryOrderBy" name="OrderBy" size=1>
					<option value="Year ASC, State ASC">Year and State</option>
					<option value="State ASC">State</option>
					<option value="PopVotes DESC">Popular Votes</option>
				</select>&nbsp;<br>
			</div>	
			<input type="submit" value="Submit" style = "width:5em; height:2.5em">
		</form>
	
	<hr id=filtercand>
	<h2>Popular Votes from State, correlated with Candidates</h2>
	<p class="description">Filter results that relate to Presidential Candidates of your specification. Get back only results you care about!</p>
	<p class="instruction">Choose your candidate parameters to correlate popular votes with</p>
	<form method="query" action="filtercand.jsp" id="filtercandform">
		<div class="indent"> Year? 
			<select id="filtercand_year" name="Year" size=1 onchange="javascript: dynamicdropdown_filtercand(this.options[this.selectedIndex].value);">
				<option value="-1">All years</option>
				<option value="1996">Only 1996</option>
				<option value="2000">Only 2000</option>
				<option value="2004">Only 2004</option>
				<option value="2008">Only 2008</option>
				<option value="2012">Only 2012</option>
			</select>&nbsp;<br>
		</div>
		<div class="indent">Candidates belonging to a Democrat/Republican party?
			<select id="filtercand_party" name="Party" size=1>
				<option value="-1">Doesn't Matter</option>
				<option value="Democrat">Only Democrat</option>
				<option value="Republican">Only Republican</option>
			</select>&nbsp;<br>
		</div>
		<div class="indent">Results in which Candidates won the election?
			<select id="filtercand_won" name="Won" size=1>
				<option value="-1">Doesn't Matter</option>
				<option value="1">Only Winners</option>
				<option value="0">Only Losers</option>
			</select>&nbsp;<br>
		</div>
		<div class="indent">Candidates receiving 
			<select id="filtercand_ev" name="ElectoralVotes" size=1>
				<option value="0">0 and over</option>
				<option value="100">100 and over</option>
				<option value="150">150 and over</option>
				<option value="175">175 and over</option>
				<option value="200">200 and over</option>
				<option value="250">250 and over</option>
				<option value="300">300 and over</option>
				<option value="350">350 and over</option>
			</select> electoral votes&nbsp;<br>
		</div>
		<div class="indent">Candidate's whose party spent
			<select id="filtercand_budget" name="Budget" size=1>
				<option value="0">$0 and over</option>
				<option value="100000000">$100,000,000 and over</option>
				<option value="150000000">$150,000,000 and over</option>
				<option value="200000000">$200,000,000 and over</option>
				<option value="300000000">$300,000,000 and over</option>
				<option value="400000000">$400,000,000 and over</option>
				<option value="500000000">$500,000,000 and over</option>
				<option value="600000000">$600,000,000 and over</option>
				<option value="700000000">$700,000,000 and over</option>
			</select>&nbsp; for the election?<br>
		</div>
		<div class="indent"> Order results by: 
			<select name="OrderBy" size=1>
				<option value="Year ASC, State ASC">Year and State</option>
				<option value="State ASC">State</option>
				<option value="PopVotes DESC">Popular Votes</option>
			</select>&nbsp;<br>
		</div>
		<input type="submit" value="Submit" style = "width:5em; height:2.5em">
	</form>
	
	<hr id=aggr_query>
	<h2>Aggregation Query about States</h2>
	<p class="description">See some census information about states, aggregated across a selection of years!</p>
	<p class="instruction"> Check off all the years you would like aggregate</p>
		<form method="query" action="aggr.jsp" id="aggrform">
			<div class="indent">
				&nbsp;&nbsp;&nbsp;
				<input type="radio" id="year_aggr1" class="year_aggr" name="year_aggr1" value="1996"/>1996
				<input type="radio" id="year_aggr2" class="year_aggr" name="year_aggr2" value="2000"/>2000
				<input type="radio" id="year_aggr3" class="year_aggr" name="year_aggr3" value="2004"/>2004
				<input type="radio" id="year_aggr4" class="year_aggr" name="year_aggr4" value="2008"/>2008
				<input type="radio" id="year_aggr5" class="year_aggr" name="year_aggr5" value="2012"/>2012
				<button type="button" id="selectAllYears">Select All Years</button>
			</div>
			<div class="instruction">Your question:</div>
			<div class="indent" > How many people 
				<select name="Projection" size=1 onchange="javascript: dynamicdropdown_aggr(this.options[this.selectedIndex].value);">
					<option value="Citizen">were citizens?</option>
					<option value="Registered">were registered to vote?</option>
					<option value="Voted">voted?</option>
				</select>&nbsp;<br>
			</div>
			<div class="indent"> Choose your aggregation mode: 
				<select name="Aggregate" size=1>
					<option value="SUM">Sum</option>
					<option value="AVG">Average</option>
					<option value="STD">Standard Deviation</option>
					<option value="VARIANCE">Variance</option>
					<option value="MAX">Max</option>
					<option value="MIN">Min</option>
				</select>&nbsp;<br>
			</div>
			<div class="indent"> Aggregations resulting in (HAVING): 
				<select name="Having" size=1>
					<option value="0">0 and over</option>
					<option value="25000">25,000 and over</option>
					<option value="50000">50,000 and over</option>
					<option value="75000">75,000 and over</option>
					<option value="100000">100,000 and over</option>
					<option value="200000">200,000 and over</option>
					<option value="250000">250,000 and over</option>
					<option value="500000">500,000 and over</option>
					<option value="750000">750,000 and over</option>
					<option value="800000">800,000 and over</option>
					<option value="900000">900,000 and over</option>
					<option value="1000000">1,000,000 and over</option>
					<option value="1250000">1,250,000 and over</option>
					<option value="1500000">1,500,000 and over</option>
					<option value="2000000">2,000,000 and over</option>
					<option value="3000000">3,000,000 and over</option>
					<option value="4000000">4,000,000 and over</option>
					<option value="5000000">5,000,000 and over</option>
					<option value="6000000">6,000,000 and over</option>
					<option value="7500000">7,500,000 and over</option>
					<option value="10000000">10,000,000 and over</option>
					<option value="15000000">15,000,000 and over</option>
					<option value="15000000">20,000,000 and over</option>
				</select>&nbsp;<br>
			</div>	
			<div class="indent"> Order results by: 
				<select id="aggrOrderBy" name="OrderBy" size=1>
					<option value="State ASC">State</option>
					<option value="aggr_proj"># of people that were citizens</option>
				</select>&nbsp;<br>
			</div>
			<input type="submit" value="Submit" style = "width:5em; height:2.5em">
		</form>
	<hr>
	<div class='footer'>
		<ul class="footernav" id="footernav">
			<li><a href="#aboutUs">About Us</a></li>
			<li><a href="http://www.census.gov/topics/public-sector/voting/data/tables.All.html">Census Resource</a></li>
		</ul>
	</div>
		
	<script>
		<!-- java script to help with dynamic dropdown/error detection-->
		
		$(document).ready(function() {
			<!-- http://t4t5.github.io/sweetalert/ -->
			$("#selectAllYears").click(function() {
				$('.year_aggr').attr('checked',true);
				$('.year_aggr').attr('checkstate', 'true');
				$(this).hide();
			});
			
			$(".year_aggr").click(function() {
			      //if this item is already ticked, make it unticked.
		        if ($(this).attr('checkstate') == 'true')
		        {
		            $(this).attr('checked', false);
		            $(this).attr('checkstate', 'false');  // .attr returns a string for unknown param values.
		        }
		        else
		        {
		            $(this).attr('checked', true);
		            $(this).attr('checkstate', 'true');
		        }
		        //refresh the buttonset to display the states correctly.
		        //$('.year_aggr').buttonset('refresh');
			});
			
					
			$("#percentagevoteform").submit(function() {
				if ( $('#Year1').val() == $('#Year2').val()  && $('#Candidate1').val() == $('#Candidate2').val()) {
					sweetAlert("Please select two different candidates", "You selected the same candidate from the same year.", "error");
					return false;
			    }
			});
			
			$("#aggrform").submit(function() {
				var count = 5;
				if (!$("input[name=year_aggr1]:checked").val() && !$("input[name=year_aggr2]:checked").val()
						&& !$("input[name=year_aggr3]:checked").val() && !$("input[name=year_aggr4]:checked").val()
						&& !$("input[name=year_aggr5]:checked").val()) {
					sweetAlert("Aggregate Query", "You did not select any year to aggregate. Please check off at least one year.", "error");
					return false;
				}		
			});
			
			//anchor offset fix
			$('#myTopnav a').click(function () {
				$('html, body').animate({
					scrollTop: $(this.hash).offset().top - $("#myTopnav").height() - 3 //anchor destination top - fixed header - 3
				}, 1000); //1000 ms
				return false;
			});
		});
		
		function dynamicdropdown_query(listindex) {
	    	document.getElementById("queryOrderBy").options.length = 0;
	        switch (listindex) {
	        case "-1" :
	            document.getElementById("queryOrderBy").options[0]=new Option("Year and State","Year ASC, State ASC");
	            document.getElementById("queryOrderBy").options[1]=new Option("State","State ASC");
	            document.getElementById("queryOrderBy").options[2]=new Option("Popular Votes","PopVotes DESC");
	        	break;
	        default:
	        	document.getElementById("queryOrderBy").options[0]=new Option("State","State ASC");
            	document.getElementById("queryOrderBy").options[1]=new Option("Popular Votes","PopVotes DESC");
	            break;
	        }
	        return true;
	    }
		
		
	    function dynamicdropdown(listindex) {
	    	document.getElementById("Candidate1").options.length = 0;
	        switch (listindex) {
	        case "1996" :
	            document.getElementById("Candidate1").options[0]=new Option("Bob Dole","Dole");
	            document.getElementById("Candidate1").options[1]=new Option("Bill Clinton","Clinton");
	        	break;
	        case "2000" :
	            document.getElementById("Candidate1").options[0]=new Option("George Bush","Bush");
	            document.getElementById("Candidate1").options[1]=new Option("Al Gore","Gore");
	            break;
	        case "2004" :
	            document.getElementById("Candidate1").options[0]=new Option("George Bush","Bush");
	            document.getElementById("Candidate1").options[1]=new Option("John Kerry","Kerry");
	            break;
	        case "2008" :
	            document.getElementById("Candidate1").options[0]=new Option("John McCain","McCain");
	            document.getElementById("Candidate1").options[1]=new Option("Barack Obama","Obama");
	            break;
	        case "2012" :
	            document.getElementById("Candidate1").options[0]=new Option("Mitt Romney","Romney");
	            document.getElementById("Candidate1").options[1]=new Option("Barack Obama","Obama");
	            break;
	        }
	        return true;
	    }
	    
	    function dynamicdropdown2(listindex) {
	    	document.getElementById("Candidate2").options.length = 0;
	        switch (listindex) {
	        case "1996" :
	            document.getElementById("Candidate2").options[0]=new Option("Bob Dole","Dole");
	            document.getElementById("Candidate2").options[1]=new Option("Bill Clinton","Clinton");
	        	break;
	        case "2000" :
	            document.getElementById("Candidate2").options[0]=new Option("George Bush","Bush");
	            document.getElementById("Candidate2").options[1]=new Option("Al Gore","Gore");
	            break;
	        case "2004" :
	            document.getElementById("Candidate2").options[0]=new Option("George Bush","Bush");
	            document.getElementById("Candidate2").options[1]=new Option("John Kerry","Kerry");
	            break;
	        case "2008" :
	            document.getElementById("Candidate2").options[0]=new Option("John McCain","McCain");
	            document.getElementById("Candidate2").options[1]=new Option("Barack Obama","Obama");
	            break;
	        case "2012" :
	            document.getElementById("Candidate2").options[0]=new Option("Mitt Romney","Romney");
	            document.getElementById("Candidate2").options[1]=new Option("Barack Obama","Obama");
	            break;
	        }
	        return true;
	    }
	    
	    function dynamicdropdown_aggr(listindex) {
	    	document.getElementById("aggrOrderBy").options.length = 0;
	        switch (listindex) {
	        case "Citizen" : 
	        	document.getElementById("aggrOrderBy").options[0]=new Option("State","State ASC");
            	document.getElementById("aggrOrderBy").options[1]=new Option("# of people that were citizens","aggr_proj");
	            break;
	        case "Registered" : 
	        	document.getElementById("aggrOrderBy").options[0]=new Option("State","State ASC");
            	document.getElementById("aggrOrderBy").options[1]=new Option("# of people that were registered","aggr_proj");
	            break;
	        case "Voted" : 
	        	document.getElementById("aggrOrderBy").options[0]=new Option("State","State ASC");
            	document.getElementById("aggrOrderBy").options[1]=new Option("# of people that voted","aggr_proj");
	            break;
	        }
	        return true;
	    }
	</script>
</body>
</html>