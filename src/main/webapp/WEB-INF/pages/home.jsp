<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang = "en">
<head>
<meta charset ="utf-8"/>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.2/themes/smoothness/jquery-ui.css" />
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>

<title>Insert title here</title>

<script>
$(function() {
$( "#employeeDetails" ).tabs();


});


/*  $(".selector").bind("tabsselect", function(event, ui){ 

function retrieveEmployeeDetails(){
	var tableStr = null;
	
	   $.ajax({	
           type: "GET",
           url: "/training-webapp/user/viewUserDetails",
        	
           success: function(employeeDetails) {
				$.each(employeeDetails, function(index, detail){
					
					tableStr += "<tr>";
					tableStr += "<th> " + detail.fullName + "</th>";
					tableStr += "</tr>";
					
				});
				
				$('#UserDetailsTable').append(tableStr);
				
           }
   });
} 
 });  */
</script>

</head>


<body>
<div id ="employeeDetails">
	<div align = "right"> 
		<table>
			<tr>
			<td>Hi ${userId}!</td>
			<td><a href = "logout">Logout</a></td>
			</tr>
		</table>
	</div>
	<ul>
		<li><a href = "#ViewTimeLog">View Time Log</a></li>
		<li><a href = "#MyProfile" >My Profile</a></li>
		<li><a href = "#AccountSettings">Account Settings</a></li>
	</ul>
		
	<div id = "ViewTimeLog">
					
	</div>

	<div id = "MyProfile">
		<table>
		<tbody id = "UserDetailsTable">
				<tr>
					<td>  </td>
					<td>  </td>
				</tr>
						
				<c:forEach items="${employeeDetailsList}" var="employeeDetailsList">
				<tr>
					<th>${employeeDetailsList.firstname} ${employeeDetailsList.middlename} ${employeeDetailsList.lastname} </th>
					
				</tr>
				
				<tr>
					<td><b>${employeeDetailsList.email}</b></td>
					<td>  </td>
				</tr>
				<tr>
					<td>  </td>
					<td>  </td>
				</tr>
				<tr>
					<td>Employee ID: ${employeeDetailsList.employeeId} </td>
					<td>  </td>
				</tr>
				<tr>
					<td>Biometrics ID: ${employeeDetailsList.biometricId} </td>
				</tr>
				
				<tr>
					<td>  </td>
					<td>  </td>
				</tr>
				
				<tr>
					
					<td>Department: ${employeeDetailsList.department} </td>	
				</tr>
				
				<tr>
					<td>Position: ${employeeDetailsList.position} </td>
					<td>Level: ${employeeDetailsList.level} </td>
				</tr>
				
				<tr></tr>
				
				<tr>
					<td>Hire Date:  ${employeeDetailsList.hireDate} </td>
					<td>Regularization Date: ${employeeDetailsList.regularizationDate} </td>
				</tr>
				<c:forEach items="${supervisorDetails}" var="supervisorDetails">
					<tr>
							<td>Supervisor: ${supervisorDetails.firstname} ${supervisorDetails.lastname}</td>
							<td>Supervisor's Email: ${supervisorDetails.email}</td>
					</tr>
				</c:forEach>
				
				
			</c:forEach>
			
				</tbody>	
		
			</table>
		
		</div>


	<div id = "AccountSettings">
	<table>
			 	<form name="changePassword" method="POST" action="<c:url value='/user/changePassword'/>">
					
					
					<b>Change Password</b>
					
						<tr>
							<td><div style = "text-align: right">Current Password:</div> </td>
							<td><input type="password" name = "currentPassword" /></td>
						</tr>
						
						<tr>
							<td><div style = "text-align: right">New Password:</div></td>
							<td> <input type="password" name = "newPassword" /></td>
						</tr>
						
						<tr>
							<td><div style = "text-align: right">Re-enter New Password: </div></td>
							<td><input type="password" name = "repeatNewPassword" /></td>
						</tr>
						
						<tr>
							<td></td>
							<td><div style = "text-align: right"></div>
							<input type= "submit" value="Confirm"/></td>
						</tr>
					
				</form>
			</table>
	<div>${passwordMsg}</div>
	</div>
	

</div>

</body>
</html>