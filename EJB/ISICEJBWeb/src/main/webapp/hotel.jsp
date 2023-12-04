<%@page import="entities.Hotel"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Hotel Page</title>

<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css">

<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>

<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f4f4f4;
	align-items: center;
	padding-left: 26em;
	padding-right: 14em;
	padding-top: 5em;
}

.sidebar {
	height: 100vh;
	width: 250px;
	background-color: #E0E0E0;
	position: fixed;
	top: 0;
	left: 0;
	overflow-x: hidden;
	display: flex;
	flex-direction: column;
	align-items: center;
	padding-top: 20px;
}

.sidebar h2 {
	color: #81c784;
	margin-bottom: 20px;
}
.sidebar h1 {
color:#81c784;
}

.sidebar p {
	margin: 0;
	padding: 10px;
	width: 200px;
	text-align: center;
	display: block;
	align-items: center;
}

.sidebar a {
    text-decoration: none;
    color: black;
    transition: background-color 0.3s;
    height: 35px;
    padding-top: 18px;
    font-weight: bold; 
    display: flex;
    align-items: center;
    align-items: flex-start;
}

.sidebar a:hover {
	background-color: #555;
}


img{
width: 40px;
height: 40px;

}

form {
	background-color: #fff;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	width: 100%;
	max-width: 600px;
	margin: 0 auto;
	margin-bottom: 20px;
	padding: 20px;
	box-sizing: border-box;
}

label {
	display: block;
	margin-bottom: 8px;
}

input, select, button {
	width: 100%;
	padding: 10px;
	margin-bottom: 16px;
	box-sizing: border-box;
}

button {
	background-color: #4CAF50;
	color: #fff;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

button:hover {
	background-color: #45a049;
}

h1 {
	text-align: center;
	color: #54524F;
}

#hotelTable {
	border-collapse: collapse;
	width: 100%;
	margin-top: 20px;
}

#hotelTable th, #hotelTable td {
	padding: 12px;
	text-align: left;
	border-bottom: 1px solid #ddd;
}

#hotelTable th {
	background-color: #54524F;
	color: white;
	text-align: center;
}

#hotelTable tbody tr:hover {
	background-color: #f5f5f5;
}

#hotelTable tbody tr:nth-child(even) {
	background-color: #f9f9f9;
}

.delete, .modify {
	padding: 6px 10px;
	margin: 2px;
	cursor: pointer;
	border: none;
	border-radius: 4px;
}

.delete {
	background-color: #e57373;
	color: #fff;
}

.delete:hover {
	background-color: red;
}

.modify {
	background-color: #81c784;
	color: #fff;
}

.modify:hover {
	background-color: green;
}

.add:hover {
	background-color: green;
}

.admin{
width:60px;
height:60px;

}

</style>
</head>
<body>
	<div class="sidebar">
	<img src="assets/admin.png" alt="Admin" class="admin">
		 <h2>Utilisateur</h2>
	
	 <h2>_________________________</h2>
   <p><a href="VilleController">Gestion des villes</a></p>
    <p><a href="HotelController">Gestion des hôtels</a></p>
    </div>

	<form action="HotelController" method="post">
		<h1>Ajouter un Hôtel</h1>
		<input type="hidden" id="selectedHotelId" name="selectedHotelId" value="" />
		
		<label for="nom">Nom :</label> <input type="text" name="nom" required>

		<label for="adresse">Adresse :</label> <input type="text"
			name="adresse" required> <label for="telephone">Téléphone
			:</label> <input type="text" name="telephone" required> <label
			for="ville">Ville :</label> <select name="ville" required>
			<c:forEach items="${villes}" var="v">
				<option value="${v.id}">${v.nom}</option>
			</c:forEach>
		</select>

		<button type="submit" class="add">Ajouter</button>
	</form>

	<h1>Liste des hôtels :</h1>
	<table id="hotelTable">
		<thead>
			<tr>
				<th>Nº</th>
				<th>Nom</th>
				<th>Adresse</th>
				<th>Téléphone</th>
				<th>Ville</th>
				<th>Supprimer</th>
				<th>Modifier</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${hotels}" var="hotel">
				<tr>
					<td>${hotel.id}</td>
					<td>${hotel.nom}</td>
					<td>${hotel.adresse}</td>
					<td>${hotel.telephone}</td>
					<td>${hotel.ville.nom}</td>
					<td>
						<button class="delete" onclick="deleteHotel(${hotel.id})">Supprimer</button>
					</td>
					<td>
						<button class="modify" onclick="modifyHotel(${hotel.id})">Modifier</button>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<script>
    $(document).ready(function() {
        $('#hotelTable').DataTable({
            dom: 'Bfrtip',
            buttons: [
                'copy', 'excel', 'csv', 'pdf', 'print', 'colvis'
            ]
        });
    });

    function deleteHotel(hotelId) {
        if (confirm('Etes-vous sûr de vouloir supprimer cet hôtel ?')) {
            $.ajax({
                type: 'POST',
                url: 'HotelController?action=delete&hotelId=' + hotelId,
                success: function (data) {
                    var table = $('#hotelTable').DataTable();
                    var row = table.row($('#hotelTable').find('tr:has(td:contains(' + hotelId + '))'));
                    row.remove().draw();
                },
                error: function (xhr, status, error) {
                    console.error('Error deleting hotel:', error);
                    console.error('Status:', status);
                }
            });
        }
    }

    function modifyHotel(hotelId) {
        var table = $('#hotelTable').DataTable();
        var row = table.row($('#hotelTable').find('tr:has(td:contains(' + hotelId + '))'));
        var hotelNom = row.data()[1];
        var hotelAdresse = row.data()[2];
        var hotelTelephone = row.data()[3];
        var hotelVilleId = row.data()[4];

        $('#selectedHotelId').val(hotelId);
        $('input[name="nom"]').val(hotelNom);
        $('input[name="adresse"]').val(hotelAdresse);
        $('input[name="telephone"]').val(hotelTelephone);
        $('select[name="ville"]').val(hotelVilleId);

        $('button[type="submit"]').text('Modifier').removeClass('add').addClass('modify');

        $('h1').text('Modifier un Hôtel');
    }
  


    </script>

</body>
</html>
