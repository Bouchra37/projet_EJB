<%@page import="entities.Ville"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Ville Page</title>

<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css">

<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

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
	color: #81c784;
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

img {
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

input, button {
	width: 100%;
	padding: 10px;
	margin-bottom: 16px;
	box-sizing: border-box;
}

button {
	background-color: #81c784;
	color: #fff;
	border: none;
	border-radius: 4px;
	cursor: pointer;
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

h1 {
	text-align: center;
	color: #54524F
}

#villeTable {
	border-collapse: collapse;
	width: 100%;
	margin-top: 20px;
}

#villeTable th, #villeTable td {
	padding: 12px;
	text-align: left;
	border-bottom: 1px solid #ddd;
}

#villeTable th {
	background-color: #54524F;
	color: white;
	text-align: center;
}

#villeTable tbody tr:hover {
	background-color: #f5f5f5;
}

#villeTable tbody tr:nth-child(even) {
	background-color: #f9f9f9;
}

.admin {
	width: 60px;
	height: 60px;
}
</style>
</head>
<body>
	<div class="sidebar">
		<img src="assets/admin.png" alt="Admin" class="admin">
		<h2>Utilisateur</h2>

		<h2>_________________________</h2>
		<p>
			<a href="VilleController">Gestion des villes</a>
		</p>
		<p>
			<a href="HotelController">Gestion des hôtels</a>
		</p>
	</div>

	<form action="VilleController" method="post">
		<h1>Ajouter une Ville</h1>
		<input type="hidden" id="selectedVilleId" name="selectedVilleId"
			value="" /> <span style="font-weight: bold;">Nom : </span><input
			type="text" name="ville" required /><br>

		<button type="submit" class="add">Ajouter</button>
	</form>


	<h1>Liste des villes :</h1>

	<table id="villeTable">
		<thead>
			<tr>
				<th>Nº</th>
				<th>Nom</th>
				<th>Supprimer</th>
				<th>Modifier</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${villes}" var="v">
				<tr>
					<td>${v.id}</td>
					<td>${v.nom}</td>
					<td>
						<button class="delete" onclick="deleteVille(${v.id})">Supprimer</button>
					</td>
					<td>
						<button class="modify" onclick="modifyVille(${v.id})">Modifier</button>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<script>
        $(document).ready(function () {
            $('#villeTable').DataTable({
                dom: 'Bfrtip',
                buttons: [
                    'copy', 'excel', 'csv', 'pdf'
                ]
            });
        });

        function deleteVille(villeId) {
            if (confirm('Etes-vous sûr de vouloir supprimer cette ville ?')) {
                $.ajax({
                    type: 'POST',
                    url: 'VilleController?action=delete&villeId=' + villeId,
                    success: function (data) {
                            var table = $('#villeTable').DataTable();
                            var row = table.row($('#villeTable').find('tr:has(td:contains(' + villeId + '))'));
                            row.remove().draw();
                       
                    },
                    error: function (xhr, status, error) {
                        console.error('Error deleting city:', error);
                        console.error('Status:', status);

                    }
                });
            }
        }
        function modifyVille(villeId) {
            var table = $('#villeTable').DataTable();
            var row = table.row($('#villeTable').find('tr:has(td:contains(' + villeId + '))'));
            var villeNom = row.data()[1];

            $('#selectedVilleId').val(villeId);
            $('input[name="ville"]').val(villeNom);

            $('button[type="submit"]').text('Modifier').removeClass('add').addClass('modify');

            $('h1').text('Modifier une Ville');
        }



    </script>

</body>
</html>
