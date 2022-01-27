<html>
<head>
<link rel="stylesheet" href="assets/style.css">
</head>
<body>
	
<?php

// DB connection
require "DBConn.php";

// Get parameters
$orgID = $_GET['org'];
$year = $_GET['year'];

// Query
$rows=$DB->query("SELECT Count(T.animalID)
FROM Transports T
WHERE T.destinationID=" . $orgID . " and Year(T.transportDate)=" . $year);


// Table headings
echo '<table>';
echo '<tr>';
echo '<th>Total Amount</td>';
echo '</tr>';

// Insert each animal's info as row into table
foreach($rows as $row) {
	if ($row[0]==0) {
		echo '<tr>';
		echo '<td>'."0".'</td>';
		echo '</tr>';
	}
	else {
		echo '<tr>';
		echo '<td>'.$row[0].'</td>';
		echo '</tr>';
	}
}
echo '</table>';

?>

</body>
</html>