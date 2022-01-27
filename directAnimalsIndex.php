<html>
   <head>
		<link rel="stylesheet" href="assets/style.css">
   </head>

    <body>
        <h3>Animals that went from the SPCA directly to a shelter</h3>
		<?php
			// DB connection
			require "DBConn.php";

			// Query
			$rows=$DB->query(	"SELECT A.animalID, A.species
								FROM Animal A, Shelter S
								WHERE A.orgID=S.orgID AND A.animalID NOT IN (SELECT RP.animalID
                                             FROM Rescue_Organization_Payment RP);");

			// Table headings
			echo '<table>';
			echo '<tr>';
			echo '<th>Animal ID</th>';
			echo '<th>Animal species</th>';
			echo '</tr>';

			// Insert each animal's info as row into table
			foreach($rows as $row) {
				echo '<tr>';
				echo '<td>'.$row['animalID'].'</td>';
				echo '<td>'.$row['species'].'</td>';
				echo '</tr>';
			}
			echo '</table>';
		?>
    </body>
</html>