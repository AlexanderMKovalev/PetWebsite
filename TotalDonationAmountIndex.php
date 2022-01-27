<html>
   <head>

        <script type = "text/javascript" src = "jquery/jquery-3.4.1.min.js"/>
        
        <!-- If these two lines are removed, the scripts below don't work :( -->
        <script type = "text/javascript">
        </script>

        <script type = "text/javascript">
        
        // Called when the SPCA Branch dropdown selection changes
        function onOrgSelected() {

            // If a valid one is selected
            var val = document.getElementById("org-select").value;
            if(val > 0) {
                // Get and display the required data
                var formValues = $("form").serialize();
                $("#total-donation").load("totalDonationAmountResult.php?" + formValues);
            } else {
                // Otherwise, clear the data
                $("#total-donation").empty();
            }
            
        
        }

        // Called when document body loads
        function onBodyLoad() {
            // Make the dropdown selection blank at start
            document.getElementById("org-select").selectedIndex = 0;
        }

        </script>

    </head>

    <!--<body onload="onBodyLoad()">-->
    
		<h4>Please choose an organization </h4>
        <?php

            // DB connection
            require "DBConn.php";

            // Query
            $rows=$DB->query("SELECT O.orgID, O.orgName FROM Organization O");

            // Display dropdown selector
            //$select = '<select id="org-select" name="org" onchange="onSPCSBranchSelected()" name="select">';
			$select = '<select id="org-select" name="org" name="select">';
            $select.='<option value=""></option>';
            foreach($rows as $row) {
                $select.='<option value="'.$row['orgID'].'">'.$row['orgName'].'</option>';
            }
            $select.='</select>';

            // Construct form with dropdown element to submit selected data
            echo '<form id="org-form">';
            echo $select;
            echo '</form>';
        ?>
		<h4> Please enter a year and click submit </h4>
		<form id="yearbox" method="get">
			<label for="year">Year:</label><br><br>
			<input type="text" id="year" name="year" value="2020"><br><br>
			<input type="button" value="Submit" onClick="onOrgSelected()">
		</form>

        <!-- The container to put the DB results into -->
        <div id="total-donation"></div>

    </body>
</html>