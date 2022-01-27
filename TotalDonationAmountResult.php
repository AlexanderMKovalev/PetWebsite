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
$rows=$DB->query("SELECT sum(amount)
FROM Donation D 
WHERE D.orgID=" . $orgID . " and Year(D.donationDate)=" . $year);


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