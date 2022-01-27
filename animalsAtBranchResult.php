<html>
<head>
<link rel="stylesheet" href="assets/style.css">
</head>
<body>

<?php

// DB connection
require "DBConn.php";

// Get parameters
$orgID = $_GET['branch'];

// Query
$rows=$DB->query("SELECT animalID, species, arrivalDAte, leaveDate
FROM Animal A, SPCA_Branch S
WHERE A.orgID=S.orgID AND S.orgID=" . $orgID);

// Table headings
echo '<table>';
echo '<tr>';
echo '<th>ID</th>';
echo '<th>Species</th>';
echo '<th>Arrival</th>';
echo '<th>Departure</th>';
echo '</tr>';

// Insert each animal's info as row into table
foreach($rows as $row) {
    echo '<tr>';
    echo '<td>'.$row[0].'</td>';
    echo '<td>'.$row[1].'</td>';
    echo '<td>'.$row[2].'</td>';
    echo '<td>'.$row[3].'</td>';
    echo '</tr>';
}
echo '</table>';

?>

</body>
</html>