<html>
<head>
<link rel="stylesheet" href="assets/style.css">
</head>
<body>

<?php

// DB connection
require "DBConn.php";

// Get parameters
$orgID = $_GET['rescue'];

// Query
$rows=$DB->query("SELECT D.firstname,D.lastname, D.emergencyphonenumber, D.licencePlateNumber, D.DriverLicenseNumber
FROM driver D, organization O, rescue_organization R, Volunteers_At V
WHERE D.DriverLicenseNumber=V.DriverLicenseNumber AND V.orgID=O.orgID AND O.orgID=R.orgID AND R.orgID=" . $orgID);

echo '<h3>Driver Information</h3><br>';

// Insert each drivers's info as row into table
foreach($rows as $row) {
	
	// Table headings
	echo '<table>';
	echo '<tr>';
	echo '<th>First Name</th>';
	echo '<th>Last Name</th>';
	echo '<th>Emergency Phone Number</th>';
	echo '<th>License Plate Number</th>';
	echo '<th>Driver\'s License Number</th>';
	echo '</tr>';

    echo '<tr>';
    echo '<td>'.$row[0].'</td>';
    echo '<td>'.$row[1].'</td>';
    echo '<td>'.$row[2].'</td>';
    echo '<td>'.$row[3].'</td>';
	echo '<td>'.$row[4].'</td>';
    echo '</tr>';
	echo '</table>';

	echo '<br>';

	// Query the animal's this driver has transported
	$transports=$DB->query("SELECT sO.orgName,dO.orgName, T.animalID, T.transportDate 
	FROM driver D, organization sO,organization dO, transports T
	WHERE D.DriverLicenseNumber=T.DriverLicenseNumber AND T.sourceID=sO.orgID AND T.destinationID=dO.orgID AND D.DriverLicenseNumber=".$row[4]);

	echo'<h4> This driver has transported the following animals </h4>';

	// Insert each drivers's transported animal info as row into table
	echo '<table>';
	echo '<tr>';
	echo '<th>Source Organization</th>';
	echo '<th>Destination Organization</th>';
	echo '<th>Animal ID</th>';
	echo '<th>Transport Date</th>';
	echo '</tr>';
	foreach($transports as $animal) {
		echo '<tr>';
		echo '<td>'.$animal[0].'</td>';
		echo '<td>'.$animal[1].'</td>';
		echo '<td>'.$animal[2].'</td>';
		echo '<td>'.$animal[3].'</td>';
		echo '</tr>';
	}
	echo '</table>';
	echo '<br>';
	echo '<hr>';
	echo '<br>';

}


?>

</body>
</html>