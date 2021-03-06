<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Mail TimeSheet to Employees</title> <script
		src="http://code.jquery.com/jquery-1.9.1.min.js"></script>

	<!--  RichText  -->

	<script src="../resources/bmn/ckeditor/ckeditor.js">
		
	</script>
	<link rel="stylesheet"
		href="../resources/bmn/ckeditor/samples/sample.css" />
	<script type="text/javascript"
		src="../resources/bmn/ckeditor/config.js">
		
	</script>
	<link rel="stylesheet" type="text/css"
		href="../resources/bmn/ckeditor/skins/moono/editor_gecko.css" />
	<script type="text/javascript"
		src="../resources/bmn/ckeditor/lang/en.js"></script>
	<script type="text/javascript"
		src="../resources/bmn/ckeditor/styles.js"></script>
	<!-- End of Rich Text -->



	<script>
		function sendMailInd() {
			$("#sendMailInd").attr("disabled", true);
			var selectedPeriod = $("#INDPERIOD option:selected").text();
			var msgTitle = $("#msgTitle").val();
			var msgBody = CKEDITOR.instances['editor1'].getData();

			var tableStr = null;
			$("#status").html("Sending Please wait");

			$.ajax({
				type : "POST",
				url : "/tempoplus/sendMail/sendInd",
				data : {
					msgBody : msgBody,
					msgTitle : msgTitle,
					selectedPeriod : selectedPeriod

				},
				success : function(data) {
					console.log("data: " + data);
					$("#status").html(data);
					$("#sendMailInd").attr("disabled", false);

				}
			});
		}

		function sendMailDep() {
			$("#sendMailDep").attr("disabled", true);
			var selectedDepartment = $("#DEPARTMENTS option:selected").text();
			var selectedPeriod = $("#DEPPERIOD option:selected").text();
			var msgTitle = $("#msgTitle").val();
			var msgBody = CKEDITOR.instances['editor1'].getData();

			var tableStr = null;
			$("#status").html("Sending Please wait");

			$.ajax({
				type : "POST",
				url : "/tempoplus/sendMail/send",
				data : {
					selectedDepartment : selectedDepartment,
					msgBody : msgBody,
					msgTitle : msgTitle,
					selectedPeriod : selectedPeriod

				},
				success : function(data) {
					
					console.log("data: " + data);
					$("#status").html(data);
					
					$("#sendMailDep").attr("disabled", false);

				}
			});
		}
	</script>

	<script>
	function validatePassword(){
		
		var password = $("#password").val();

		$.ajax({
			type : "POST",
			url : "/tempoplus/sendMail/validatePassword",
			data : {
				
				password : password

			},
			success : function(data) {
			if(data){
				alert("Successed Validation");
				$("#validateForm").hide();
				$("#sendOption").show();
				
			} else {
				alert("Invalid Password");
			}

			}
		});
		
		
	}
	</script>

	<script>
		$(document).ready(function() {
			$("#sendOption").hide();
			$("#sendMailDep").hide();
			$("#sendMailInd").hide();
			$("#DEPARTMENTS").hide();
			$("#EMPLOYEES").hide();
			$("#DEPPERIOD").hide();
			$("#INDPERIOD").hide();

			$("#sendOption").change(function() {
				var selectedOption = $("#sendOption option:selected").text();
				if (selectedOption == "DEPARTMENT") {
					$("#sendMailDep").show()
					$("#DEPARTMENTS").show();
					$("#EMPLOYEES").hide();
					$("#sendMailInd").hide()
					$("#DEPPERIOD").show();
					$("#INDPERIOD").hide();

				} else if (selectedOption == "INDIVIDUAL") {
					$("#sendMailDep").hide()
					$("#DEPARTMENTS").hide();
					$("#EMPLOYEES").show();
					$("#sendMailInd").show()
					$("#INDPERIOD").show();
					$("#DEPPERIOD").hide();
				} else {
					$("#sendMailDep").hide()
					$("#sendMailInd").hide()
					$("#DEPARTMENTS").hide();
					$("#EMPLOYEES").hide();
					$("#INDPERIOD").hide();
					$("#DEPPERIOD").hide();
				}

			});

			$("#EMPLOYEES").change(function() {
				var selectedEmployee = $("#EMPLOYEES option:selected").text();
				var fileList;
				$("#INDPERIOD").empty();
				$.ajax({
					type : "GET",
					url : "/tempoplus/sendMail/getFiles",
					data : {
						selectedEmployee : selectedEmployee
					},
					success : function(response) {

						$.each(response, function(keys, values) {
							fileList += "<option>" + values + "</option>";
						});
						$("#INDPERIOD").append(fileList);
					}
				});

			});

		});
	</script>
</head>
<body>


	
		<h2>Send TimeSheet to Employees</h2>
	

	<div id="validateForm">
	Enter Your Mail Password
	<input type = "password" id="password"/>
	<button onclick="validatePassword()">Validate</button>
	</div>
	<b> Send Time Sheet </b>
	<select id="sendOption">
		<option selected="selected">Select Sending Option</option>
		<option>DEPARTMENT</option>
		<option>INDIVIDUAL</option>
	</select>
	
	<select id="DEPARTMENTS">
		<c:forEach items="${departments}" var="content">
			<option>${content}</option>
		</c:forEach>
	</select>
	<select id="EMPLOYEES">
		<c:forEach items="${names}" var="content">
			<option>${content.firstName} ${content.lastName}
				${content.email}@novare.com.hk</option>
		</c:forEach>
	</select>
	</br>
	<select id="DEPPERIOD">
			<c:forEach items="${periods}" var="content">
			<option>${content}</option>
		</c:forEach>
	</select>
	<select id="INDPERIOD">
		<option selected="selected">Select TimeSheet Period</option>
	</select>
	<button id="sendMailDep" onclick="sendMailDep()">Send
		TimeSheet By Department</button>
	<button id="sendMailInd" onclick="sendMailInd()">Send
		TimeSheet to an employee</button>
	</br>
	</br>
	<div>
		Enter Message Title: <input type="text" size="50" id="msgTitle"></input>
	</div>

	<!-- RichText Editor Implementation -->

	<div>
		<textarea cols="80" id="editor1" name="editor1" rows="10">
			
<p>Hi</p>
</br>
<p>We are providing you with your attendance summary for the period of Month Day Year to Month Day Year.  The summary includes overtime and leaves availed for the same period.  The summary include requests made in Mantis and NT3 as of March 25.  Requests made and approved after March 25, 2013 will be made part of the next cut off.</p>
</br>
<p>This summary report will be routed to you semi-monthly.</p>
</br>
<p>What we request of you?  Please go over the summary:</p>
</br>
<p>1. If you spot missing overtime and/or rest day or holiday hours for payment, please do check the details of your ticket and check for accuracy of the same.  If there are errors on the ticket filed, please log a new request.  For proper administration, all tickets made part of this summary will be tagged as resolved.</p>
</br>
<p>2.  Look in columns Q, R and S as these are usually for deduction.  Immediately log appropriate tickets to ensure that hours for deduction is corrected.  Like filing for a regular request in Mantis and NT3, the requests should be assigned to your immediate supervisor.</p>
</br>
<p>If you are deployed to the Client's site, from Sales Team or a level 5 and up, please ensure that leaves are properly filed.  This is very useful for benefits administration that you may want to avail at a later time.</p>
</br>
<p>Should you have questions or clarifications, please feel free to reach out to hr@novare.com.hk.</p>
</br>
<p>Thank you</p>
<p>HR Team</p>

		</textarea>
		<script>
			// This call can be placed at any point after the
			// <textarea>, or inside a <head><script> in a
			// window.onload event handler.

			// Replace the <textarea id="editor"> with an CKEditor
			// instance, using default configurations.

			CKEDITOR.replace('editor1');
		</script>
	</div>
	<br> Status: <span id="status"> Hold </span> <a
		href="/tempoplus/sendMail/logs" id="logsLink"> <i>check
				sending mail logs</i></a> </br>

</body>
</html>