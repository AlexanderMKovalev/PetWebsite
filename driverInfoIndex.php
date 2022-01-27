<html>
   <head>

        <script type = "text/javascript" src = "jquery/jquery-3.4.1.min.js"/>
        
        <!-- If these two lines are removed, the scripts below don't work :( -->
        <script type = "text/javascript">
        </script>

        <script type = "text/javascript">
        
        // Called when the SPCA Branch dropdown selection changes
        function onRescueOrgSelected() {

            // If a valid one is selected
            var val = document.getElementById("rescue-select").value;
            if(val > 0) {
                // Get and display the required data
                var formValues = $("select").serialize();
                $("#driver-selection").load("driverInfoResult.php?" + formValues);
            } else {
                // Otherwise, clear the data
                $("#driver-selection").empty();
            }
            
        }

        // Called when document body loads
        function onBodyLoad() {
            // Make the dropdown selection blank at start
            document.getElementById("branch-select").selectedIndex = 0;
        }

        </script>

    </head>

    <body onload="onBodyLoad()">

        <h3>All Information on Drivers for a Rescue Organization</h3>
		<h4>Please choose a rescue organization </h4>

        <?php

            // DB connection
            require "DBConn.php";

            // Query
            $rows=$DB->query("SELECT O.orgID, O.orgName FROM Organization O, rescue_organization R WHERE O.orgID=R.orgID");

            // Display dropdown selector
            $select = '<select id="rescue-select" name="rescue" onchange="onRescueOrgSelected()" name="select">';
            $select.='<option value=""></option>';
            foreach($rows as $row) {
                $select.='<option value="'.$row['orgID'].'">'.$row['orgName'].'</option>';
            }
            $select.='</select>';

            // Construct form with dropdown element to submit selected data
            echo '<form id="rescue-form">';
            echo $select;
            echo '</form>';

        ?>

        <!-- The container to put the DB results into -->
        <div id="driver-selection"></div>

    </body>
</html>